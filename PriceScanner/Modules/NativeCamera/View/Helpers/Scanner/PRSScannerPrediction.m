//
//  PRSScannerPrediction.m
//  PriceScanner
//
//  Created by Александр Чаусов on 17.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScannerPrediction.h"


@interface PRSScannerPrediction()

@property (nonatomic, assign) CGFloat confidence;
@property (nonatomic, strong) NSString *prediction;

@end


@implementation PRSScannerPrediction

- (instancetype)initWithConfidence:(CGFloat)confidence prediction:(NSString *)prediction {
    self = [super init];
    if (self) {
        self.confidence = confidence;
        self.prediction = prediction;
    }
    return self;
}

@end
