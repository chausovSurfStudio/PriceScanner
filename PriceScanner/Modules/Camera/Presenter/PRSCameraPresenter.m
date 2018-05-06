//
//  PRSCameraPresenter.m
//  PriceScanner
//
//  Created by Alexander Chausov on 28/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSCameraPresenter.h"
#import "PRSCameraViewInput.h"


@interface PRSCameraPresenter()

@property (nonatomic, copy) void (^openResultAction)(void);

@end


@implementation PRSCameraPresenter

#pragma mark - PRSCameraModuleInput
- (void)configureWithOpenResultAction:(void(^)(void))openResultAction {
    self.openResultAction = openResultAction;
}

#pragma mark - PRSCameraViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openScanResultModule {
    if (self.openResultAction) {
        self.openResultAction();
    }
}

@end
