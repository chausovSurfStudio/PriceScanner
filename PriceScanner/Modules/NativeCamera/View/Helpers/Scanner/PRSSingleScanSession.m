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

@property (nonatomic, strong) NSMutableArray<PRSCharDetectResult *> *sessionResults;

@end


@implementation PRSSingleScanSession

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionResults = [@[] mutableCopy];
    }
    return self;
}

#pragma mark - Interface Methods
- (void)detectResult:(PRSCharDetectResult *)result {
    [self.sessionResults addObject:result];
}

- (NSString *)getPrediction {
    NSMutableArray<NSString *> *predictions = [@[] mutableCopy];
    for (PRSCharDetectResult *result in [self.sessionResults copy]) {
        [predictions addObject:result.prediction];
    }
    return [[predictions copy] componentsJoinedByString:@""];
}

@end
