//
//  PRSNativeCameraViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSNativeCameraViewController.h"
#import "PRSNativeCameraViewOutput.h"

#import <AVFoundation/AVFoundation.h>
#import <Vision/Vision.h>

#import "PRSCameraOverlay.h"
#import "UIButton+Style.h"
#import "UIImage+Resize.h"
#import "UIImage+ScanUtils.h"
#import "UIViewController+ScanUtils.h"

#import "TextModel.h"


@interface PRSNativeCameraViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *scene;
@property (nonatomic, strong) IBOutlet UIButton *startScanButton;
@property (nonatomic, strong) IBOutlet PRSCameraOverlay *overlay;

@property (nonatomic, strong) IBOutlet UIView *scanInProgressView;
@property (nonatomic, strong) IBOutlet UIImageView *scanIconImageView;
@property (nonatomic, strong) IBOutlet UILabel *scanInProgressLabel;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) NSArray<VNRequest *> *requests;

@property (nonatomic, strong) TextModel *model;
@property (nonatomic, strong) VNCoreMLRequest *classificationRequest;
@property (nonatomic, strong) UIImage *snapshot;
@property (nonatomic, assign) BOOL someFlag;

@end


@implementation PRSNativeCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startLiveVideo];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopLiveVideo];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Configure
- (void)configureModel {
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"TextModel" withExtension:@"mlmodelc"];
    NSError *error;
    self.model = [[TextModel alloc] initWithContentsOfURL:modelUrl error:&error];
    if (error) {
        NSLog(@"scanner error: model not configure");
    }
}

- (void)configureStyle {
    [self configureStartScanButton];
    [self configureScanInProgressView];
    self.scanInProgressView.hidden = YES;
}

- (void)configureStartScanButton {
    [self.startScanButton setRectanglePinkStyle];
    [self.startScanButton setTitle:@"Начать сканирование".localized forState:UIControlStateNormal];
}

- (void)configureScanInProgressView {
    self.scanInProgressView.backgroundColor = [UIColor clearColor];
    self.scanIconImageView.image = [UIImage imageNamed:@"icScan"];
    
    self.scanInProgressLabel.font = [UIFont systemFontOfSize:11.f weight:UIFontWeightRegular];
    self.scanInProgressLabel.textColor = [UIColor whiteColor];
    self.scanInProgressLabel.text = @"Идет сканирование".localized;
}

- (void)configureTextDetectRequest {
    VNDetectTextRectanglesRequest *textRequest = [[VNDetectTextRectanglesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self clearSceneSublayers];
            for (VNTextObservation *word in request.results) {
                [self highlightWord:word inScene:self.scene];
                for (VNRectangleObservation *characterBox in word.characterBoxes) {
                    [self highlightLetter:characterBox inScene:self.scene];
                    
//                    UIImage *someLetter = [self cropLetter:characterBox fromImage:self.snapshot];
//                    NSError *error;
//                    VNImageRequestHandler *letterHandler = [[VNImageRequestHandler alloc] initWithCGImage:someLetter.CGImage options:@{}];
//                    [letterHandler performRequests:@[self.classificationRequest] error:&error];
//                    if (error) {
//                        NSLog(@"ошибка в самом распознавании");
//                    }
                }
            }
        });
        
        if (!self.someFlag) {
            self.someFlag = YES;
            for (VNTextObservation *word in request.results) {
                for (VNRectangleObservation *characterBox in word.characterBoxes) {
                    UIImage *someLetter = [self cropLetter:characterBox fromImage:self.snapshot];
                    NSError *error;
                    VNImageRequestHandler *letterHandler = [[VNImageRequestHandler alloc] initWithCGImage:someLetter.CGImage options:@{}];
                    [letterHandler performRequests:@[self.classificationRequest] error:&error];
                    if (error) {
                        NSLog(@"ошибка в самом распознавании");
                    }
                }
            }
            self.someFlag = NO;
        }
    }];
    textRequest.reportCharacterBoxes = YES;
    self.requests = @[textRequest];
}

- (void)configureClassificationRequest {
    NSError *error;
    VNCoreMLModel *mlModel = [VNCoreMLModel modelForMLModel:self.model.model error:&error];
    if (error) {
        NSLog(@"проблемы с созданием VNCoreMLModel");
    }
    VNCoreMLRequest *request = [[VNCoreMLRequest alloc] initWithModel:mlModel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        for (id observation in request.results) {
//            VNClassificationObservation *topResult = ((VNClassificationObservation *)observation);
//            NSLog(@"%f: %@", topResult.confidence, topResult.identifier);
            if ([observation isKindOfClass:[VNCoreMLFeatureValueObservation class]]) {
                VNCoreMLFeatureValueObservation *response = (VNCoreMLFeatureValueObservation *)observation;
                NSLog(@"value = %@, confidence = %f", response.featureValue.stringValue, response.confidence);
            }
        }
    }];
    self.classificationRequest = request;
}

#pragma mark - Actions
- (IBAction)tapOnStartScanButton:(UIButton *)sender {
    // TODO: тестовый код, поправить позднее
    [self.output openScanResultModule];
}

#pragma mark - PRSNativeCameraViewInput
- (void)setupInitialState {
    [self initVideoSession];
    [self configureModel];
    [self configureStyle];
    [self configureTextDetectRequest];
    [self configureClassificationRequest];
}

#pragma mark - AVCaptureSession
- (void)initVideoSession {
    self.session = [[AVCaptureSession alloc] init];
}

- (void)startLiveVideo {
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"deviceInput not configure");
        return;
    }
    
    AVCaptureVideoDataOutput *deviceOutput = [AVCaptureVideoDataOutput new];
    deviceOutput.videoSettings = @{(NSString *)kCVPixelBufferPixelFormatTypeKey: @((int)kCVPixelFormatType_32BGRA)};
    [deviceOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    if ([self.session canAddInput:deviceInput]) {
        [self.session addInput:deviceInput];
    }
    if ([self.session canAddOutput:deviceOutput]) {
        [self.session addOutput:deviceOutput];
    }
    
    AVCaptureVideoPreviewLayer *imageLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    imageLayer.frame = [UIScreen mainScreen].bounds;
    self.scene.layer.sublayers = nil;
    [self.scene.layer addSublayer:imageLayer];
    
    [self.session startRunning];
}

- (void)stopLiveVideo {
    [self.session stopRunning];
    self.scene.layer.sublayers = nil;
    self.session = [[AVCaptureSession alloc] init];
}

- (void)pauseLiveVideo {
    [self.session stopRunning];
    self.session = [[AVCaptureSession alloc] init];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    self.snapshot = [UIImage imageFromSampleBuffer:sampleBuffer];
    
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CFTypeRef camData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil);
    NSDictionary *requestOptions;
    if ((__bridge id)camData) {
        requestOptions = @{VNImageOptionCameraIntrinsics:(__bridge id)camData};
    }
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCVPixelBuffer:pixelBuffer orientation:kCGImagePropertyOrientationRight options:requestOptions];
    [handler performRequests:self.requests error:nil];
}

#pragma mark - Private logic
/** Метод удаляет все sublayers на scene, кроме первого, в котором расположен видеопоток */
- (void)clearSceneSublayers {
    CALayer *videoLayer = self.scene.layer.sublayers.firstObject;
    if (videoLayer) {
        self.scene.layer.sublayers = @[videoLayer];
    } else {
        self.scene.layer.sublayers = @[];
    }
}

/** Метод анимированно убирает кнопку начала сканирования и показывает view с текстом о том, что сканирование началось */
- (void)showScanInProgressView {
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.startScanButton.alpha = 0.f;
                     } completion:^(BOOL finished) {
                         self.startScanButton.hidden = YES;
                         self.scanInProgressView.alpha = 0.f;
                         self.scanInProgressView.hidden = NO;
                         [UIView animateWithDuration:0.15
                                          animations:^{
                                              self.scanInProgressView.alpha = 1.f;
                                          }];
                     }];
}

/** Метод показывает кнопку начала сканирования, убирая при этом view с текстом о том, что сканирование началось */
- (void)showStartScanButton {
    self.startScanButton.alpha = 1.f;
    self.startScanButton.hidden = NO;
    self.scanInProgressView.hidden = YES;
}

@end
