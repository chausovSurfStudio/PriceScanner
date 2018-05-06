//
//  PRSMainPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSMainPresenter.h"
#import "PRSMainViewInput.h"


@interface PRSMainPresenter()

@property (nonatomic, copy) void (^openCameraModuleAction)(void);

@end


@implementation PRSMainPresenter

#pragma mark - PRSMainModuleInput
- (void)configureWithOpenCameraModuleAction:(void(^)(void))openCameraModuleAction {
    self.openCameraModuleAction = openCameraModuleAction;
}

#pragma mark - PRSMainViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openCameraModule {
    if (self.openCameraModuleAction) {
        self.openCameraModuleAction();
    }
}

@end
