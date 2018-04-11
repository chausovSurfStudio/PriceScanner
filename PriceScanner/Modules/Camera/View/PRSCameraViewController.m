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

#import "UIImage+Resize.h"


/** Состояние снимка */
typedef NS_ENUM(NSUInteger, SnapshotStatus) {
    SnapshotStatusNone,
    SnapshotStatusMake,
    SnapshotStatusProcessing
};


@interface PRSCameraViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *scene;
@property (nonatomic, strong) IBOutlet UIImageView *testImageView;
@property (nonatomic, strong) IBOutlet UIButton *snapshotButton;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) NSArray<VNRequest *> *requests;

@property (nonatomic, assign) SnapshotStatus makeSnapshot;
@property (nonatomic, strong) UIImage *snapshot;

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
    
    self.makeSnapshot = SnapshotStatusNone;
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
    self.makeSnapshot = SnapshotStatusMake;
    
    [self pauseLiveVideo];
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self startLiveVideo];
    });
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
    if (self.makeSnapshot == SnapshotStatusMake) {
        UIImage *rawSnapshot = [self imageFromSampleBuffer:sampleBuffer];
        self.snapshot = [rawSnapshot resizedImage:rawSnapshot.size interpolationQuality:kCGInterpolationHigh];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.testImageView.image = self.snapshot;
        });
        self.makeSnapshot = SnapshotStatusProcessing;
    }
    
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CFTypeRef camData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil);
    NSDictionary *requestOptions;
    if ((__bridge id)camData) {
        requestOptions = @{VNImageOptionCameraIntrinsics:(__bridge id)camData};
    }
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCVPixelBuffer:pixelBuffer orientation:kCGImagePropertyOrientationRight options:requestOptions];
    [handler performRequests:self.requests error:nil];
}

#pragma mark - Image Builder
- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer {
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0 orientation:UIImageOrientationRight];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
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
            
            if (self.makeSnapshot == SnapshotStatusProcessing) {
                for (VNTextObservation *word in request.results) {
                    for (VNRectangleObservation *characterBox in word.characterBoxes) {
                        [self cropAndSaveLetter:characterBox];
                    }
                }
                self.makeSnapshot = SnapshotStatusNone;
            }
        });
    }];
    textRequest.reportCharacterBoxes = YES;
    self.requests = @[textRequest];
}

/** Метод выделяет в текущем видеопотоке границу распознанного слова */
- (void)highlightWord:(VNTextObservation *)word {
    CALayer *border = [[CALayer alloc] init];
    border.frame = [self frameForWord:word];
    border.borderWidth = 2.f;
    border.borderColor = [UIColor redColor].CGColor;
    
    [self.scene.layer addSublayer:border];
}

/** Метод выделяет в текущем видеопотоке границу распознанного символа */
- (void)highlightLetter:(VNRectangleObservation *)letter {
    CALayer *border = [[CALayer alloc] init];
    border.frame = [self frameForLetter:letter parentSize:self.scene.frame.size];
    border.borderWidth = 1.f;
    border.borderColor = [UIColor blueColor].CGColor;
    
    [self.scene.layer addSublayer:border];
}

- (CGRect)frameForWord:(VNTextObservation *)word {
    NSArray<VNRectangleObservation *> *boxes = word.characterBoxes;
    
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
    
    return CGRectMake(originX, originY, width, height);
}

- (CGRect)frameForLetter:(VNRectangleObservation *)letter parentSize:(CGSize)parentSize {
    CGFloat originX = letter.topLeft.x * parentSize.width;
    CGFloat originY = (1 - letter.topLeft.y) * parentSize.height;
    CGFloat width = (letter.topRight.x - letter.bottomLeft.x) * parentSize.width;
    CGFloat height = (letter.topLeft.y - letter.bottomLeft.y) * parentSize.height;
    
    return CGRectMake(originX, originY, width, height);
}

- (void)cropAndSaveLetter:(VNRectangleObservation *)letter {
    CGRect letterFrame = [self frameForLetter:letter parentSize:self.snapshot.size];
    UIImage *letterImage = [self cutRect:letterFrame fromImage:self.snapshot];
    NSLog(@"image = %@", letterImage);
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

- (UIImage *)cutRect:(CGRect)rect fromImage:(UIImage *)image {
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:image.imageOrientation];
    CGImageRelease(imageRef);

    return resultImage;
}

@end
