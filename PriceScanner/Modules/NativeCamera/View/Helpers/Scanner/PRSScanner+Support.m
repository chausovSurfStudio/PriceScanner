//
//  PRSScanner+Support.m
//  PriceScanner
//
//  Created by Александр Чаусов on 17.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanner+Support.h"
#import "PRSSingleScanSession.h"
#import "PRSCharDetectResult.h"
#import "PRSScannerPrediction.h"


@implementation PRSScanner (Support)

- (NSArray<PRSSingleScanSession *> *)selectSessionsForBuildingName:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableDictionary *tempDict = [@{} mutableCopy];
    [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *wordsCount = @(session.nameWords.count);
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

- (NSArray<PRSSingleScanSession *> *)selectSessionsForBuildingPrice:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableDictionary *tempDict = [@{} mutableCopy];
    [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *wordsCount = @(session.priceWords.count);
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

- (PRSScannerPrediction *)predictNameWithSessions:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableArray<NSString *> *nameWords = [@[] mutableCopy];
    CGFloat confidence = 0.f;
    CGFloat maxWordConfidence = 1.f / sessions.firstObject.nameWords.count;
    
    for (int i = 0; i < sessions.firstObject.nameWords.count; i++) {
        NSMutableArray<NSArray<PRSCharDetectResult *> *> *words = [@[] mutableCopy];
        __block NSUInteger maxWordLength = 0;
        [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<PRSCharDetectResult *> *word = session.nameWords[i];
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
    
    NSString *namePrediction = [nameWords componentsJoinedByString:@" "];
    return [[PRSScannerPrediction alloc] initWithConfidence:confidence prediction:namePrediction];
}

- (PRSScannerPrediction *)predictPriceWithSessions:(NSArray<PRSSingleScanSession *> *)sessions {
    NSMutableArray<NSString *> *priceWords = [@[] mutableCopy];
    CGFloat confidence = 0.f;
    CGFloat maxWordConfidence = 1.f / sessions.firstObject.priceWords.count;
    
    for (int i = 0; i < sessions.firstObject.priceWords.count; i++) {
        NSMutableArray<NSArray<PRSCharDetectResult *> *> *words = [@[] mutableCopy];
        __block NSUInteger maxWordLength = 0;
        [sessions enumerateObjectsUsingBlock:^(PRSSingleScanSession * _Nonnull session, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<PRSCharDetectResult *> *word = session.priceWords[i];
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
    
    NSString *pricePrediction = [priceWords componentsJoinedByString:@" "];
    return [[PRSScannerPrediction alloc] initWithConfidence:confidence prediction:pricePrediction];
}

@end
