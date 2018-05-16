//
//  PRSScanSessionManager.m
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanSessionManager.h"
#import "PRSSingleScanSession.h"
#import "PRSCharDetectResult.h"


@interface PRSScanSessionManager()

@property (nonatomic, strong) NSArray<PRSSingleScanSession *> *sessions;

@end


@implementation PRSScanSessionManager

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

- (void)startNewSessionInRegion:(CGRect)region {
    NSMutableArray<PRSSingleScanSession *> *currentSessions = [self.sessions mutableCopy];
    [currentSessions addObject:[[PRSSingleScanSession alloc] initWithRegion:region]];
    self.sessions = [currentSessions copy];
}

- (void)detectResult:(PRSCharDetectResult *)result {
    [self.sessions.lastObject detectResult:result];
}

- (NSString *)getLastPrediction {
    return [self.sessions.lastObject getPrediction];
}

@end
