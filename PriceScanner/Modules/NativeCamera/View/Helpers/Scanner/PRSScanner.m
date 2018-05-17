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

@property (nonatomic, strong) NSString *lastPredictedName;
@property (nonatomic, strong) NSString *lastPredictedPrice;

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
    NSArray<PRSSingleScanSession *> *sessionsForName = [self getSessionsWithEqualWordsInName:rawSessions];
    NSArray<PRSSingleScanSession *> *sessionsForPrice = [self getSessionsWithEqualWordsInPrice:rawSessions];
    
    CGFloat nameConfidence = [self buildNameWithSessions:sessionsForName];
    CGFloat priceConfidence = [self buildPriceWithSessions:sessionsForPrice];

    NSLog(@"NAME PREDICTION = %@", self.lastPredictedName);
    NSLog(@"PRICE PREDICTION = %@", self.lastPredictedPrice);
    
    return 0.5 * nameConfidence + 0.5 * priceConfidence;
}

- (NSArray<PRSSingleScanSession *> *)getSessionsWithEqualWordsInName:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableDictionary *tempDict = [@{} mutableCopy];
    [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *wordsCount = @(session.nameChars.count);
        if (wordsCount.integerValue != 0) {
            if ([[tempDict allKeys] containsObject:wordsCount]) {
                NSMutableArray *values = tempDict[wordsCount];
                [values addObject:session];
                tempDict[wordsCount] = values;
            } else {
                tempDict[wordsCount] = [@[session] mutableCopy];
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

- (NSArray<PRSSingleScanSession *> *)getSessionsWithEqualWordsInPrice:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableDictionary *tempDict = [@{} mutableCopy];
    [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *wordsCount = @(session.priceChars.count);
        if (wordsCount.integerValue != 0) {
            if ([[tempDict allKeys] containsObject:wordsCount]) {
                NSMutableArray *values = tempDict[wordsCount];
                [values addObject:session];
                tempDict[wordsCount] = values;
            } else {
                tempDict[wordsCount] = [@[session] mutableCopy];
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

- (CGFloat)buildNameWithSessions:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableArray<NSString *> *nameWords = [@[] mutableCopy];
    CGFloat confidence = 0.f;
    CGFloat maxWordConfidence = 1.f / sessions.firstObject.nameChars.count;
    
    for (int i = 0; i < sessions.firstObject.nameChars.count; i++) {
        NSMutableArray<NSArray<PRSCharDetectResult *> *> *words = [@[] mutableCopy];
        __block NSUInteger maxWordLength = 0;
        [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<PRSCharDetectResult *> *word = session.nameChars[i];
            [words addObject:word];
            if (maxWordLength < word.count) {
                maxWordLength = word.count;
            }
        }];
        
        CGFloat maxLetterConfidence = maxWordConfidence / maxWordLength;
        
        NSMutableString *wordPrediction = [@"" mutableCopy];
        for (int j = 0; j < maxWordLength; j++) {
            NSCountedSet *availableLetters = [NSCountedSet new];
            for (NSArray<PRSCharDetectResult *> *word in words) {
                if (j < word.count) {
                    [availableLetters addObject:word[j].prediction];
                }
            }
            
            NSString *mostRepeatedString = @"";
            NSUInteger maxCount = 0;
            
            for (NSString *letter in availableLetters) {
                NSUInteger count = [availableLetters countForObject:letter];
                if (count > maxCount) {
                    maxCount = count;
                    mostRepeatedString = letter;
                }
            }
            [wordPrediction appendString:mostRepeatedString];
            CGFloat delta = maxLetterConfidence / 5 * MIN(5, maxCount);
            confidence += delta;
        }
        [nameWords addObject:[wordPrediction copy]];
    }
    
    self.lastPredictedName = [nameWords componentsJoinedByString:@" "];
    return confidence;
}

- (CGFloat)buildPriceWithSessions:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableArray<NSString *> *priceWords = [@[] mutableCopy];
    CGFloat confidence = 0.f;
    CGFloat maxWordConfidence = 1.f / sessions.firstObject.priceChars.count;
    
    for (int i = 0; i < sessions.firstObject.priceChars.count; i++) {
        NSMutableArray<NSArray<PRSCharDetectResult *> *> *words = [@[] mutableCopy];
        __block NSUInteger maxWordLength = 0;
        [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<PRSCharDetectResult *> *word = session.priceChars[i];
            [words addObject:word];
            if (maxWordLength < word.count) {
                maxWordLength = word.count;
            }
        }];
        
        CGFloat maxLetterConfidence = maxWordConfidence / maxWordLength;
        
        NSMutableString *wordPrediction = [@"" mutableCopy];
        for (int j = 0; j < maxWordLength; j++) {
            NSCountedSet *availableLetters = [NSCountedSet new];
            for (NSArray<PRSCharDetectResult *> *word in words) {
                if (j < word.count) {
                    [availableLetters addObject:word[j].prediction];
                }
            }
            
            NSString *mostRepeatedString = @"";
            NSUInteger maxCount = 0;
            
            for (NSString *letter in availableLetters) {
                NSUInteger count = [availableLetters countForObject:letter];
                if (count > maxCount) {
                    maxCount = count;
                    mostRepeatedString = letter;
                }
            }
            [wordPrediction appendString:mostRepeatedString];
            CGFloat delta = maxLetterConfidence / 5 * MIN(5, maxCount);
            confidence += delta;
        }
        [priceWords addObject:[wordPrediction copy]];
    }
    
    self.lastPredictedPrice = [priceWords componentsJoinedByString:@" "];
    return confidence;
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
