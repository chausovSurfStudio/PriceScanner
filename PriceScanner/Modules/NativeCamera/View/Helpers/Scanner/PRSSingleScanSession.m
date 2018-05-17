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

@property (nonatomic, strong) NSMutableArray<NSMutableArray<PRSCharDetectResult *> *> *nameChars;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<PRSCharDetectResult *> *> *priceChars;

@end


@implementation PRSSingleScanSession

- (instancetype)initWithRegion:(CGRect)region {
    self = [super init];
    if (self) {
        self.region = region;
        
        NSMutableArray<PRSCharDetectResult *> *nameFirstWord = [@[] mutableCopy];
        NSMutableArray<PRSCharDetectResult *> *priceFirstWord = [@[] mutableCopy];
        self.nameChars = [@[nameFirstWord] mutableCopy];
        self.priceChars = [@[priceFirstWord] mutableCopy];
    }
    return self;
}

#pragma mark - Interface Methods
- (void)detectResult:(PRSCharDetectResult *)result {
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
    NSLog(@"COOL PREDICTION!!\nNAME:");
    for (NSMutableArray<PRSCharDetectResult *> *word in self.nameChars) {
        NSMutableArray<NSString *> *wordsLetters = [@[] mutableCopy];
        for (PRSCharDetectResult *result in word) {
            [wordsLetters addObject:result.prediction];
        }
//        NSLog(@"%@", [wordsLetters componentsJoinedByString:@""]);
        NSLog(@"name word letters count = %ld", word.count);
    }
    NSLog(@"PRICE:");
    for (NSMutableArray<PRSCharDetectResult *> *word in self.priceChars) {
        NSMutableArray<NSString *> *wordsLetters = [@[] mutableCopy];
        for (PRSCharDetectResult *result in word) {
            [wordsLetters addObject:result.prediction];
        }
//        NSLog(@"%@", [wordsLetters componentsJoinedByString:@""]);
        NSLog(@"price word letters count = %ld", word.count);
    }
}

#pragma mark - Private Methods
- (BOOL)isNameChar:(PRSCharDetectResult *)result {
    CGFloat relativeTopLeftY = ((1 - result.charBox.topLeft.y) - self.region.origin.y) / self.region.size.height;
    BOOL isName = relativeTopLeftY < 0.35;
//    NSLog(@"Name = %@ topLeft = %f isName = %@", result.prediction, relativeTopLeftY, isName ? @"+++" : @"---");
    return isName;
}

- (BOOL)isPriceChar:(PRSCharDetectResult *)result {
    CGFloat relativeTopLeftY = ((1 - result.charBox.topLeft.y) - self.region.origin.y) / self.region.size.height;
    CGFloat relativeTopLeftX = (result.charBox.topLeft.x - self.region.origin.x) / self.region.size.width;
    BOOL isPrice = relativeTopLeftY > 0.5 && relativeTopLeftX > 0.5;
//    NSLog(@"Price = %@ topLeftY = %f topLeftX = %f isPrice = %@", result.prediction, relativeTopLeftY, relativeTopLeftX, isPrice ? @"+++" : @"---");
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
