//
//  PRSScanner.m
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanner.h"
#import "PRSScanSessions.h"
#import "PRSCharDetectResult.h"


@interface PRSScanner()

@property (nonatomic, strong) PRSCharDetectResult *scanResultBuffer;
@property (nonatomic, strong) PRSScanSessions *sessionManager;

@end


@implementation PRSScanner

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [PRSScanSessions new];
        self.state = PRSScannerStateDisable;
    }
    return self;
}

#pragma mark - Custom Setters
- (void)setState:(PRSScannerState)state {
    _state = state;
    switch (state) {
        case PRSScannerStateDisable:
            self.scanResultBuffer = nil;
            [self.sessionManager clear];
            break;
        case PRSScannerStateAwait:
            self.scanResultBuffer = nil;
            NSLog(@"Last session prediction = %@", [self.sessionManager getLastPrediction]);
            break;
        case PRSScannerStateActive:
            self.scanResultBuffer = nil;
            [self.sessionManager startNewSession];
            break;
    }
}

#pragma mark - Interface Methods
- (void)prepareForCharBoxScan:(VNRectangleObservation *)charBox {
    self.scanResultBuffer = [PRSCharDetectResult new];
    self.scanResultBuffer.charBox = charBox;
}

- (void)completeCharBoxScanWithPrediction:(NSString *)prediction confidence:(CGFloat)confidence {
    self.scanResultBuffer.prediction = prediction;
    self.scanResultBuffer.confidence = confidence;
    if ([self.scanResultBuffer isCorrectlyFilled]) {
        [self.sessionManager detectResult:self.scanResultBuffer];
    }
    self.scanResultBuffer = nil;
}

@end
