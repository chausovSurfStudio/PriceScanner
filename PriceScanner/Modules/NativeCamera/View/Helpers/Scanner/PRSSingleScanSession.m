//
//  PRSSingleScanSession.m
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSSingleScanSession.h"
#import "PRSCharDetectResult.h"


@interface PRSSingleScanSession()

@property (nonatomic, assign) CGRect region;
@property (nonatomic, strong) NSMutableArray<PRSCharDetectResult *> *sessionResults;

@property (nonatomic, strong) NSMutableArray<NSMutableArray<PRSCharDetectResult *> *> *nameChars;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<PRSCharDetectResult *> *> *priceChars;

@end


@implementation PRSSingleScanSession

- (instancetype)initWithRegion:(CGRect)region {
    self = [super init];
    if (self) {
        self.region = region;
        self.sessionResults = [@[] mutableCopy];
        
        NSMutableArray<PRSCharDetectResult *> *nameFirstWord = [@[] mutableCopy];
        NSMutableArray<PRSCharDetectResult *> *priceFirstWord = [@[] mutableCopy];
        self.nameChars = [@[nameFirstWord] mutableCopy];
        self.priceChars = [@[priceFirstWord] mutableCopy];
    }
    return self;
}

#pragma mark - Interface Methods
- (void)detectResult:(PRSCharDetectResult *)result {
    [self.sessionResults addObject:result];
    
    if ([self isNameChar:result]) {
        if ([self newResult:result tooFarFromLastResult:self.nameChars.lastObject.lastObject]) {
            [self.nameChars addObject:[@[result] mutableCopy]];
        } else {
            [self.nameChars.lastObject addObject:result];
        }
    } else if ([self isPriceChar:result]) {
        if ([self newResult:result tooFarFromLastResult:self.priceChars.lastObject.lastObject]) {
            [self.priceChars addObject:[@[result] mutableCopy]];
        } else {
            [self.priceChars.lastObject addObject:result];
        }
    }
}

- (void)printResults {
    NSLog(@"\nCOOL PREDICTION!!\nNAME:");
    for (NSMutableArray<PRSCharDetectResult *> *word in self.nameChars) {
        NSMutableArray<NSString *> *wordsLetters = [@[] mutableCopy];
        for (PRSCharDetectResult *result in word) {
            [wordsLetters addObject:result.prediction];
        }
        NSLog(@"%@", [wordsLetters componentsJoinedByString:@""]);
    }
    NSLog(@"\nPRICE:");
    for (NSMutableArray<PRSCharDetectResult *> *word in self.priceChars) {
        NSMutableArray<NSString *> *wordsLetters = [@[] mutableCopy];
        for (PRSCharDetectResult *result in word) {
            [wordsLetters addObject:result.prediction];
        }
        NSLog(@"%@", [wordsLetters componentsJoinedByString:@""]);
    }
}

#pragma mark - Private Methods
- (BOOL)isNameChar:(PRSCharDetectResult *)result {
    CGFloat relativeTopLeftY = ((1 - result.charBox.topLeft.y) - self.region.origin.y) / self.region.size.height;
    return relativeTopLeftY >= 0.17 && relativeTopLeftY <= 0.31;
}

- (BOOL)isPriceChar:(PRSCharDetectResult *)result {
    CGFloat relativeTopLeftY = ((1 - result.charBox.topLeft.y) - self.region.origin.y) / self.region.size.height;
    CGFloat relativeTopLeftX = (result.charBox.topLeft.x - self.region.origin.x) / self.region.size.width;
    return relativeTopLeftY >= 0.57 && relativeTopLeftY <= 0.71 && relativeTopLeftX > 0.5;
}

- (BOOL)newResult:(PRSCharDetectResult *)result tooFarFromLastResult:(PRSCharDetectResult *)lastResult {
    if (!lastResult) {
        return NO;
    }
    
    CGRect currentResultFrame = [self relativeRectForCharBox:result.charBox];
    CGRect lastResultFrame = [self relativeRectForCharBox:lastResult.charBox];
    
    CGFloat xDelta = currentResultFrame.origin.x - lastResultFrame.origin.x;
    if (xDelta < 0 || xDelta > (1.35f * lastResultFrame.size.width)) {
        return YES;
    }
    CGFloat yDelta = currentResultFrame.origin.y - lastResultFrame.origin.y;
    if (yDelta > (1.35f * lastResultFrame.size.height)) {
        return YES;
    }
    
    return NO;
}

- (CGRect)relativeRectForCharBox:(VNRectangleObservation *)charBox {
    CGFloat originX = charBox.topLeft.x;
    CGFloat originY = (1 - charBox.topLeft.y);
    CGFloat width = (charBox.topRight.x - charBox.bottomLeft.x);
    CGFloat height = (charBox.topLeft.y - charBox.bottomLeft.y);
    return CGRectMake(originX, originY, width, height);
}

@end
