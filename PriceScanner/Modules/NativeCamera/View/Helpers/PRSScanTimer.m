//
//  PRSScanTimer.m
//  PriceScanner
//
//  Created by Александр Чаусов on 14.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanTimer.h"


static NSTimeInterval const timerInterval = 1.1;


@interface PRSScanTimer()

@property (nonatomic, strong) NSTimer *timer;

@end


@implementation PRSScanTimer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.state = PRSScanTimerStateDisable;
    }
    return self;
}

- (void)setState:(PRSScanTimerState)state {
    _state = state;
    if (state == PRSScanTimerStateSleep) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scheduleTimer];
        });
    } else {
        [self invalidateTimer];
    }
}

- (void)scheduleTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval
                                                  target:self
                                                selector:@selector(timerAction)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)invalidateTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerAction {
    self.state = PRSScanTimerStateActive;
}

@end
