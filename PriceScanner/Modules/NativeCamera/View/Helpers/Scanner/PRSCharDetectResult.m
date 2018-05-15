//
//  PRSCharDetectResult.m
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCharDetectResult.h"


@implementation PRSCharDetectResult

- (instancetype)init {
    self = [super init];
    if (self) {
        self.charBox = nil;
        self.prediction = nil;
        self.confidence = 0.f;
    }
    return self;
}

- (BOOL)isCorrectlyFilled {
    return self.charBox && self.prediction && (self.confidence > 0.f && self.confidence <= 1.f);
}

@end
