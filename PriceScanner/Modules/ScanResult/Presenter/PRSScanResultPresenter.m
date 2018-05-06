//
//  PRSScanResultPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanResultPresenter.h"
#import "PRSScanResultViewInput.h"


@interface PRSScanResultPresenter()

@property (nonatomic, assign) BOOL showAsModal;
@property (nonatomic, copy) void (^closeAction)(void);

@end


@implementation PRSScanResultPresenter

#pragma mark - PRSScanResultViewInput
- (void)configureAsModalWithCloseAction:(void(^)(void))closeAction {
    self.showAsModal = YES;
    self.closeAction = closeAction;
}

#pragma mark - PRSScanResultViewOutput
- (void)viewLoaded {
    // установка начального состояния presenter'а
    [self.view setupInitialState];
}

@end
