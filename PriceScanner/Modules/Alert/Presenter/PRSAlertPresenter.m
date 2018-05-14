//
//  PRSAlertPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSAlertPresenter.h"
#import "PRSAlertViewInput.h"


@interface PRSAlertPresenter()

@property (nonatomic, strong) NSString *message;
@property (nonatomic, copy) void (^agreeAction)(void);
@property (nonatomic, copy) void (^cancelAction)(void);

@end


@implementation PRSAlertPresenter

#pragma mark - PRSAlertModuleInput
- (void)configureWithMessage:(NSString *)message agreeAction:(void(^)(void))agreeAction cancelAction:(void(^)(void))cancelAction {
    self.message = message;
    self.agreeAction = agreeAction;
    self.cancelAction = cancelAction;
}

#pragma mark - PRSAlertViewOutput
- (void)viewLoaded {
    [self.view setupInitialStateWithMessage:self.message];
}

- (void)agreeButtonDidTap {
    if (self.agreeAction) {
        self.agreeAction();
    }
}

- (void)cancelButtonDidTap {
    if (self.cancelAction) {
        self.cancelAction();
    }
}

@end
