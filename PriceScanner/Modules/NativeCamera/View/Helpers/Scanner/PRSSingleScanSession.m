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

@end


@implementation PRSSingleScanSession

- (instancetype)initWithRegion:(CGRect)region {
    self = [super init];
    if (self) {
        self.region = region;
        self.sessionResults = [@[] mutableCopy];
    }
    return self;
}

#pragma mark - Interface Methods
- (void)detectResult:(PRSCharDetectResult *)result {
    [self.sessionResults addObject:result];
}

@end
