//
//  PRSScanSessions.m
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanSessions.h"
#import "PRSSingleScanSession.h"
#import "PRSCharDetectResult.h"


@interface PRSScanSessions()

@property (nonatomic, strong) NSArray<PRSSingleScanSession *> *sessions;

@end


@implementation PRSScanSessions

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessions = @[];
    }
    return self;
}

#pragma mark - Interface Methods
- (void)clear {
    self.sessions = @[];
}

- (void)startNewSession {
    NSMutableArray<PRSSingleScanSession *> *currentSessions = [self.sessions mutableCopy];
    [currentSessions addObject:[PRSSingleScanSession new]];
    self.sessions = [currentSessions copy];
}

- (void)detectResult:(PRSCharDetectResult *)result {
    [self.sessions.lastObject detectResult:result];
}

- (NSString *)getLastPrediction {
    return [self.sessions.lastObject getPrediction];
}

@end
