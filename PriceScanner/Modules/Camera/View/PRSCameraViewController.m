//
//  PRSCameraViewController.m
//  PriceScanner
//
//  Created by Alexander Chausov on 28/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSCameraViewController.h"
#import "PRSCameraViewOutput.h"

#import <AVFoundation/AVFoundation.h>
#import <Vision/Vision.h>


@interface PRSCameraViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *scene;
@property (nonatomic, strong) IBOutlet UIButton *snapshotButton;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) NSArray<VNRequest *> *requests;

@end


@implementation PRSCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
    [self createTextDetectRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startLiveVideo];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopLiveVideo];
}

#pragma mark - Configure
- (void)configureStyle {
    [self configureSnapshotButton];
}

- (void)configureSnapshotButton {
    [self.snapshotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.snapshotButton setTitle:@"Сделать снимок" forState:UIControlStateNormal];
}

#pragma mark - Actions
- (IBAction)tapOnSnapshotButton:(UIButton *)sender {
    NSLog(@"tapOnSnapshotButton");
}

#pragma mark - PRSCameraViewInput
- (void)setupInitialState {
    [self initVideoSession];
    [self configureStyle];
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
    imageLayer.frame = self.scene.bounds;
    [self.scene.layer addSublayer:imageLayer];
    
    [self.session startRunning];
}

- (void)stopLiveVideo {
    [self.session stopRunning];
    self.scene.layer.sublayers = nil;
    self.session = [[AVCaptureSession alloc] init];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
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
- (void)createTextDetectRequest {
    VNDetectTextRectanglesRequest *textRequest = [[VNDetectTextRectanglesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self clearSceneSublayers];
            for (VNTextObservation *word in request.results) {
                [self highlightWord:word];
                for (VNRectangleObservation *characterBox in word.characterBoxes) {
                    [self highlightLetter:characterBox];
                }
            }
        });
    }];
    textRequest.reportCharacterBoxes = YES;
    self.requests = @[textRequest];
}

/** Метод выделяет в текущем видеопотоке границу распознанного слова */
- (void)highlightWord:(VNTextObservation *)box {
    NSArray<VNRectangleObservation *> *boxes = box.characterBoxes;
    
    CGFloat minX = 9999.f;
    CGFloat maxX = 0.f;
    CGFloat minY = 9999.f;
    CGFloat maxY = 0.f;
    
    for (VNRectangleObservation *charBox in boxes) {
        if (charBox.bottomLeft.x < minX) {
            minX = charBox.bottomLeft.x;
        }
        if (charBox.bottomRight.x > maxX) {
            maxX = charBox.bottomRight.x;
        }
        if (charBox.bottomRight.y < minY) {
            minY = charBox.bottomRight.y;
        }
        if (charBox.topRight.y > maxY) {
            maxY = charBox.topRight.y;
        }
    }
    
    CGFloat originX = minX * self.scene.frame.size.width;
    CGFloat originY = (1 - maxY) * self.scene.frame.size.height;
    CGFloat width = (maxX - minX) * self.scene.frame.size.width;
    CGFloat height = (maxY - minY) * self.scene.frame.size.height;
    
    CALayer *border = [[CALayer alloc] init];
    border.frame = CGRectMake(originX, originY, width, height);
    border.borderWidth = 2.f;
    border.borderColor = [UIColor redColor].CGColor;
    
    [self.scene.layer addSublayer:border];
}

/** Метод выделяет в текущем видеопотоке границу распознанного символа */
- (void)highlightLetter:(VNRectangleObservation *)box {
    CGFloat originX = box.topLeft.x * self.scene.frame.size.width;
    CGFloat originY = (1 - box.topLeft.y) * self.scene.frame.size.height;
    CGFloat width = (box.topRight.x - box.bottomLeft.x) * self.scene.frame.size.width;
    CGFloat height = (box.topLeft.y - box.bottomLeft.y) * self.scene.frame.size.height;
    
    CALayer *border = [[CALayer alloc] init];
    border.frame = CGRectMake(originX, originY, width, height);
    border.borderWidth = 1.f;
    border.borderColor = [UIColor blueColor].CGColor;
    
    [self.scene.layer addSublayer:border];
}

/** Метод удаляет все sublayers на scene, кроме первого, в котором расположен видеопоток */
- (void)clearSceneSublayers {
    CALayer *videoLayer = self.scene.layer.sublayers.firstObject;
    if (videoLayer) {
        self.scene.layer.sublayers = @[videoLayer];
    } else {
        self.scene.layer.sublayers = @[];
    }
}

@end
