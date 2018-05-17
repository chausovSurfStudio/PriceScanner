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
#import "PRSScanTimer.h"
#import "PRSScanner.h"
#import "TextModel.h"

#import "UIButton+Style.h"
#import "UIImage+Resize.h"
#import "UIImage+ScanUtils.h"
#import "UIViewController+ScanUtils.h"


@interface PRSNativeCameraViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *scene;
@property (nonatomic, strong) IBOutlet UIButton *startScanButton;
@property (nonatomic, strong) IBOutlet PRSCameraOverlay *overlay;

@property (nonatomic, strong) IBOutlet UIView *scanInProgressView;
@property (nonatomic, strong) IBOutlet UIImageView *scanIconImageView;
@property (nonatomic, strong) IBOutlet UILabel *scanInProgressLabel;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) VNDetectTextRectanglesRequest *textDetectRequest;
@property (nonatomic, strong) VNDetectRectanglesRequest *rectangleRequest;
@property (nonatomic, strong) NSArray<VNCoreMLRequest *> *classificationRequests;

@property (nonatomic, strong) TextModel *model;
@property (nonatomic, strong) NSArray<NSString *> *modelOutputs;

@property (nonatomic, strong) UIImage *snapshot;
@property (nonatomic, strong) PRSScanTimer *scanTimer;
@property (nonatomic, strong) PRSScanner *scanner;

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
    [self showStartScanButton];
    
    self.scanTimer.state = PRSScanTimerStateDisable;
    self.overlay.state = PRSCameraOverlayStateWaiting;
    [self.scanner disableScanner];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - PRSNativeCameraViewInput
- (void)setupInitialState {
    [self initVideoSession];
    [self setupModelOutputs];
    [self configureModel];
    [self configureStyle];
    [self configureTextDetectRequest];
    [self configureClassificationRequest];
    [self configureRectangleRequest];
    [self configureScanTimer];
    [self configureScanner];
}

#pragma mark - Configure
- (void)setupModelOutputs {
    self.modelOutputs = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",
                          @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M",
                          @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z",
                          @"Б", @"Г", @"Д", @"Ж", @"И", @"Й", @"Л", @"П", @"Ф", @"Ц", @"Ч", @"Ш", @"Щ", @"Ъ", @"Ы", @"Ь", @"Э", @"Ю", @"Я"];
}

- (void)configureModel {
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"TextModel" withExtension:@"mlmodelc"];
    self.model = [[TextModel alloc] initWithContentsOfURL:modelUrl error:nil];
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
    @weakify(self);
    VNDetectTextRectanglesRequest *textRequest = [[VNDetectTextRectanglesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        @strongify(self);
        [self handleTextDetectRequest:request];
    }];
    textRequest.reportCharacterBoxes = YES;
    self.textDetectRequest = textRequest;
}

- (void)configureClassificationRequest {
    VNCoreMLModel *mlModel = [VNCoreMLModel modelForMLModel:self.model.model error:nil];
    @weakify(self);
    VNCoreMLRequest *request = [[VNCoreMLRequest alloc] initWithModel:mlModel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        @strongify(self);
        [self handleClassificationRequest:request];
    }];
    request.imageCropAndScaleOption = VNImageCropAndScaleOptionScaleFill;
    self.classificationRequests = @[request];
}

- (void)configureRectangleRequest {
    @weakify(self);
    VNDetectRectanglesRequest *rectangleRequest = [[VNDetectRectanglesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        @strongify(self);
        [self handleRectangleRequest:request];
    }];
    rectangleRequest.minimumSize = 0.3;
    self.rectangleRequest = rectangleRequest;
}

- (void)configureScanTimer {
    self.scanTimer = [PRSScanTimer new];
}

- (void)configureScanner {
    self.scanner = [PRSScanner new];
}

#pragma mark - VNRequest Handlers
- (void)handleTextDetectRequest:(VNRequest *)request {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self clearSceneSublayers];
        for (VNTextObservation *word in request.results) {
            [self highlightWord:word inScene:self.scene];
            for (VNRectangleObservation *characterBox in word.characterBoxes) {
                [self highlightLetter:characterBox inScene:self.scene];
            }
        }
    });
    
    if (self.scanTimer.state == PRSScanTimerStateSnapshot) {
        
        if (CGRectEqualToRect(self.textDetectRequest.regionOfInterest, CGRectMake(0, 0, 1, 1))) {
            // прямоугольник не определился, смысла что-то делать дальше нет
            self.scanTimer.state = PRSScanTimerStateSleep;
            [self.scanner setupAwaitState];
            return;
        }
        
        self.scanTimer.state = PRSScanTimerStateScanning;
        [self.scanner enableScannerWithRegion:self.textDetectRequest.regionOfInterest];
        for (VNTextObservation *word in request.results) {
            for (VNRectangleObservation *characterBox in word.characterBoxes) {
                [self.scanner prepareForCharBoxScan:characterBox];
                UIImage *someLetter = [self cropLetter:characterBox fromImage:self.snapshot];
                VNImageRequestHandler *letterHandler = [[VNImageRequestHandler alloc] initWithCGImage:someLetter.CGImage options:@{}];
                [letterHandler performRequests:self.classificationRequests error:nil];
            }
        }
        CGFloat confidence = [self.scanner scanProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.overlay.progress = confidence;
            if (confidence >= 0.99f) {
                [self.output openScanPreviewModule];
                [self showStartScanButton];
                self.overlay.state = PRSCameraOverlayStateWaiting;
            }
        });
        if (confidence >= 0.99f) {
            self.scanTimer.state = PRSScanTimerStateDisable;
            [self.scanner disableScanner];
        } else {
            self.scanTimer.state = PRSScanTimerStateSleep;
            [self.scanner setupAwaitState];
        }
    }
}

- (void)handleClassificationRequest:(VNRequest *)request {
    NSArray *results = [request.results copy];
    VNCoreMLFeatureValueObservation *mlObservation = (VNCoreMLFeatureValueObservation *)results.firstObject;
    
    NSNumber *confidence = [NSNumber numberWithFloat:0];
    NSNumber *currentConfidence = [NSNumber numberWithFloat:0];
    NSInteger outputIndex = NSNotFound;
    
    for (int i = 0; i < [mlObservation.featureValue multiArrayValue].count; i++) {
        currentConfidence = [[mlObservation.featureValue multiArrayValue] objectAtIndexedSubscript:i];
        if ([currentConfidence floatValue] > [confidence floatValue]){
            confidence = currentConfidence;
            outputIndex = i;
        }
    }
    
    if (outputIndex < self.modelOutputs.count) {
        [self.scanner completeCharBoxScanWithPrediction:self.modelOutputs[outputIndex] confidence:confidence.floatValue];
    }
}

- (void)handleRectangleRequest:(VNRequest *)request {
    NSArray<VNRectangleObservation *> *results = request.results;
    VNRectangleObservation *rectangle = results.firstObject;
    if (!rectangle) {
//        self.textDetectRequest.regionOfInterest = CGRectMake(0, 0, 1, 1);
        return;
    }
    CGRect region = [self regionOfInterestFromRectObservation:rectangle];
    if (CGRectEqualToRect(region, CGRectMake(0, 0, 1, 1))) {
        return;
    }
    self.textDetectRequest.regionOfInterest = region;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self highlightRect:rectangle inScene:self.scene];
    });
}

#pragma mark - Actions
- (IBAction)tapOnStartScanButton:(UIButton *)sender {
    self.scanTimer.state = PRSScanTimerStateActive;
    self.overlay.state = PRSCameraOverlayStateActive;
    [self showScanInProgressView];
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
    if (self.scanTimer.state == PRSScanTimerStateActive) {
        UIImage *rawSnapshot = [UIImage imageFromSampleBuffer:sampleBuffer];
        self.snapshot = [rawSnapshot resizedImage:rawSnapshot.size interpolationQuality:kCGInterpolationHigh];
        self.scanTimer.state = PRSScanTimerStateSnapshot;
    }
    
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CFTypeRef camData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil);
    NSDictionary *requestOptions;
    if ((__bridge id)camData) {
        requestOptions = @{VNImageOptionCameraIntrinsics:(__bridge id)camData};
    }
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCVPixelBuffer:pixelBuffer orientation:kCGImagePropertyOrientationRight options:requestOptions];
    [handler performRequests:@[self.rectangleRequest, self.textDetectRequest] error:nil];
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
