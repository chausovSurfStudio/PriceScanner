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

@property (nonatomic, strong) NSString *lastPrediction;

@end


@implementation PRSScanner

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [PRSScanSessionManager new];
        self.state = PRSScannerStateDisable;
        self.scanResultBuffer = nil;
        [self.sessionManager clear];
        self.lastPrediction = nil;
    }
    return self;
}

#pragma mark - Interface Methods
- (void)disableScanner {
    self.state = PRSScannerStateDisable;
    self.scanResultBuffer = nil;
    [self.sessionManager clear];
    self.lastPrediction = nil;
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
    NSArray<PRSSingleScanSession *> *inSimilarRegionSessions = [self excludeSessionsByRegion:rawSessions];
    NSArray<PRSSingleScanSession *> *sessions = [self getSessionsWithEqualsLength:inSimilarRegionSessions];
    
    NSUInteger lettersCount = sessions.firstObject.sessionResults.count;
    NSMutableString *prediction = [@"" mutableCopy];
    CGFloat tempConfidence = 0.f;
    CGFloat maxSingleLetterConfidence = 0.7f / lettersCount;
    for (int i = 0; i < lettersCount; i++) {
        NSCountedSet *availableLetters = [NSCountedSet new];
        for (PRSSingleScanSession *session in sessions) {
            [availableLetters addObject:session.sessionResults[i]];
        }
        
        NSString *mostRepeatedString = @"";
        NSUInteger maxCount = 0;
        
        for (PRSCharDetectResult *letter in availableLetters) {
            NSUInteger count = [availableLetters countForObject:letter];
            if (count > maxCount) {
                maxCount = count;
                mostRepeatedString = letter.prediction;
            }
        }
        [prediction appendString:mostRepeatedString];
        tempConfidence += maxSingleLetterConfidence * (sessions.count / maxCount);
    }
    self.lastPrediction = [prediction copy];
//    NSLog(@"PREDICTION = %@", self.lastPrediction);
    return 0.5f;
    if (sessions.count <= 3) {
        return sessions.count * 0.1f;
    } else if (tempConfidence >= 0.69f && sessions.count <= 5) {
        return 0.3f + 0.35f * (sessions.count - 3);
    } else {
        return tempConfidence + 0.3f;
    }
}

- (NSArray<PRSSingleScanSession *> *)excludeSessionsByRegion:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableDictionary *tempDict = [@{} mutableCopy];
    for (PRSSingleScanSession *session in sessions) {
        if (tempDict.count == 0) {
            tempDict[[NSValue valueWithCGRect:session.region]] = [@[session] mutableCopy];
        } else {
            __block BOOL rectAlreadySaved = NO;
            NSArray *keys = [tempDict allKeys];
            [keys enumerateObjectsUsingBlock:^(NSValue *savedRegion, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([self rect:[savedRegion CGRectValue] isLooksLikeAnother:session.region]) {
                    NSMutableArray *values = tempDict[keys[idx]];
                    [values addObject:session];
                    tempDict[keys[idx]] = values;
                    *stop = YES;
                    rectAlreadySaved = YES;
                }
            }];
            if (!rectAlreadySaved) {
                tempDict[[NSValue valueWithCGRect:session.region]] = [@[session] mutableCopy];
            }
        }
    }
    
    NSArray *values = [tempDict allValues];
    __block NSUInteger idxOfMax = 0;
    __block NSUInteger maxInArray = 0;
    [values enumerateObjectsUsingBlock:^(NSArray *sessions, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxInArray < sessions.count) {
            maxInArray = sessions.count;
            idxOfMax = idx;
        }
    }];
    
    return [(NSMutableArray *)values[idxOfMax] copy];
}

- (NSArray<PRSSingleScanSession *> *)getSessionsWithEqualsLength:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableDictionary *tempDict = [@{} mutableCopy];
    [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *resultsCount = @(session.sessionResults.count);
        if (resultsCount.integerValue != 0) {
            if ([[tempDict allKeys] containsObject:resultsCount]) {
                NSMutableArray *values = tempDict[resultsCount];
                [values addObject:session];
                tempDict[resultsCount] = values;
            } else {
                tempDict[resultsCount] = [@[session] mutableCopy];
            }
        }
    }];
    
    NSArray *values = [tempDict allValues];
    __block NSUInteger idxOfMax = 0;
    __block NSUInteger maxInArray = 0;
    [values enumerateObjectsUsingBlock:^(NSArray *sessions, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxInArray < sessions.count) {
            maxInArray = sessions.count;
            idxOfMax = idx;
        }
    }];
    
    return [(NSMutableArray *)values[idxOfMax] copy];
}

- (BOOL)rect:(CGRect)firstRect isLooksLikeAnother:(CGRect)secondRect {
    if (ABS(firstRect.origin.x - secondRect.origin.x) > 0.15) {
        return NO;
    }
    if (ABS(firstRect.origin.y - secondRect.origin.y) > 0.1) {
        return NO;
    }
    if (ABS(firstRect.size.width - secondRect.size.width) > 0.15) {
        return NO;
    }
    if (ABS(firstRect.size.height - secondRect.size.height) > 0.1) {
        return NO;
    }
    return YES;
}

@end
