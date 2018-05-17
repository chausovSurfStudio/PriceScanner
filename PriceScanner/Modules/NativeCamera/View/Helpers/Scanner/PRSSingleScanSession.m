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

@property (nonatomic, strong) NSMutableArray<NSMutableArray<PRSCharDetectResult *> *> *nameWords;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<PRSCharDetectResult *> *> *priceWords;

@end


@implementation PRSSingleScanSession

- (instancetype)initWithRegion:(CGRect)region {
    self = [super init];
    if (self) {
        self.region = region;
        
        NSMutableArray<PRSCharDetectResult *> *nameFirstWord = [@[] mutableCopy];
        NSMutableArray<PRSCharDetectResult *> *priceFirstWord = [@[] mutableCopy];
        self.nameWords = [@[nameFirstWord] mutableCopy];
        self.priceWords = [@[priceFirstWord] mutableCopy];
    }
    return self;
}

#pragma mark - Interface Methods
- (void)detectResult:(PRSCharDetectResult *)result {
    NSMutableArray<NSMutableArray<PRSCharDetectResult *> *> *wordsArray = nil;
    if ([self isNameChar:result]) {
        wordsArray = self.nameWords;
    } else if ([self isPriceChar:result]) {
        wordsArray = self.priceWords;
    }
    
    if ([self newResult:result tooFarFromLastResult:wordsArray.lastObject.lastObject]) {
        [wordsArray addObject:[@[result] mutableCopy]];
    } else {
        [wordsArray.lastObject addObject:result];
    }
}

#pragma mark - Private Methods
- (BOOL)isNameChar:(PRSCharDetectResult *)result {
    CGFloat relativeTopLeftY = ((1 - result.charBox.topLeft.y) - self.region.origin.y) / self.region.size.height;
    BOOL isName = relativeTopLeftY < 0.35;
    return isName;
}

- (BOOL)isPriceChar:(PRSCharDetectResult *)result {
    CGFloat relativeTopLeftY = ((1 - result.charBox.topLeft.y) - self.region.origin.y) / self.region.size.height;
    CGFloat relativeTopLeftX = (result.charBox.topLeft.x - self.region.origin.x) / self.region.size.width;
    BOOL isPrice = relativeTopLeftY > 0.5 && relativeTopLeftX > 0.5;
    return isPrice;
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
