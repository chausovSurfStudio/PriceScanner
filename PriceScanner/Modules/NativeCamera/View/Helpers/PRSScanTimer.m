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

- (void)setState:(PRSScanTimerState)state {
    _state = state;
    if (state == PRSScanTimerStateSleep) {
        [self scheduleTimer];
    } else {
        [self invalidateTimer];
    }
}

- (void)scheduleTimer {
    @weakify(self);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval repeats:NO block:^(NSTimer * _Nonnull timer) {
        @strongify(self);
        self.state = PRSScanTimerStateActive;
    }];
}

- (void)invalidateTimer {
    [self.timer invalidate];
    self.timer = nil;
}

@end
