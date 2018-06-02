//
//  PRSScanner.m
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanner.h"

#import "PRSScanSessionManager.h"
#import "PRSSingleScanSession.h"
#import "PRSCharDetectResult.h"
#import "PRSPredictor.h"
#import "PRSScannerPrediction.h"


/** В данном перечислении объявлены возможные состояния сканера */
typedef NS_OPTIONS(NSUInteger, PRSScannerState) {
    /** Состояние выключенного сканера */
    PRSScannerStateDisable = 0,
    /** Состояние сканера в процессе ожидания входных данных */
    PRSScannerStateAwait,
    /** Состояние активного сканера */
    PRSScannerStateActive
};


@interface PRSScanner()

@property (nonatomic, assign) PRSScannerState state;
@property (nonatomic, strong) PRSCharDetectResult *scanResultBuffer;
@property (nonatomic, strong) PRSScanSessionManager *sessionManager;
@property (nonatomic, strong) PRSPredictor *predictor;

@property (nonatomic, strong) NSString *lastPredictedName;
@property (nonatomic, strong) NSString *lastPredictedPrice;

@end


@implementation PRSScanner

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [PRSScanSessionManager new];
        self.predictor = [PRSPredictor new];
        self.state = PRSScannerStateDisable;
        self.scanResultBuffer = nil;
        self.lastPredictedName = nil;
        self.lastPredictedPrice = nil;
        [self.sessionManager clear];
    }
    return self;
}

#pragma mark - Interface Methods
- (void)disableScanner {
    self.state = PRSScannerStateDisable;
    self.scanResultBuffer = nil;
    [self.sessionManager clear];
}

- (void)setupAwaitState {
    self.state = PRSScannerStateAwait;
    self.scanResultBuffer = nil;
}

- (void)enableScannerWithRegion:(CGRect)region {
    self.state = PRSScannerStateActive;
    self.scanResultBuffer = nil;
    [self.sessionManager startNewSessionInRegion:region];
}

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

- (CGFloat)scanProgress {
    CGFloat confidence = [self predictResult];
    return confidence;
}

#pragma mark - Private Methods
- (CGFloat)predictResult {
    NSArray<PRSSingleScanSession *> *rawSessions = [self.sessionManager getSessionsForPrediction];
    
    PRSScannerPrediction *namePrediction = [self.predictor predictNameWithSessions:rawSessions];
    PRSScannerPrediction *pricePrediction = [self.predictor predictPriceWithSessions:rawSessions];
    
    self.lastPredictedName = namePrediction.prediction;
    self.lastPredictedPrice = pricePrediction.prediction;
    
//    NSLog(@"NAME PREDICTION = %@", self.lastPredictedName);
//    NSLog(@"PRICE PREDICTION = %@", self.lastPredictedPrice);
    
    return 0.5 * namePrediction.confidence + 0.5 * pricePrediction.confidence;
}

@end
