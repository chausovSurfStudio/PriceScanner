//
//  PRSHistoryPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSHistoryPresenter.h"
#import "PRSHistoryViewInput.h"


@interface PRSHistoryPresenter()

@property (nonatomic, copy) void (^openResultAction)(void);

@end


@implementation PRSHistoryPresenter

#pragma mark - PRSHistoryModuleInput
- (void)configureWithOpenResultAction:(void(^)(void))openResultAction {
    self.openResultAction = openResultAction;
}

#pragma mark - PRSHistoryViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openScanResultModule {
    if (self.openResultAction) {
        self.openResultAction();
    }
}

@end
