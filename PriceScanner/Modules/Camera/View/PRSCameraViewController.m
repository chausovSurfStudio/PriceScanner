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

#pragma mark - PRSCameraViewInput
- (void)setupInitialState {
    [self initVideoSession];
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
        NSLog(@"request = %@", request);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self clearSceneSublayers];
            for (VNTextObservation *region in request.results) {
                for (VNRectangleObservation *characterBox in region.characterBoxes) {
                    [self highlightLetters:characterBox];
                }
            }
        });
    }];
    textRequest.reportCharacterBoxes = YES;
    self.requests = @[textRequest];
}

- (void)highlightLetters:(VNRectangleObservation *)box {
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

- (void)clearSceneSublayers {
    CALayer *videoLayer = self.scene.layer.sublayers.firstObject;
    if (videoLayer) {
        self.scene.layer.sublayers = @[videoLayer];
    } else {
        self.scene.layer.sublayers = @[];
    }
}

@end
