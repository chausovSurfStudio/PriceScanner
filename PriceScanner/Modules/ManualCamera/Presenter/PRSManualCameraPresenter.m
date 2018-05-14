//
//  PRSManualCameraPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSManualCameraPresenter.h"
#import "PRSManualCameraViewInput.h"


@interface PRSManualCameraPresenter()

@property (nonatomic, copy) void (^openResultAction)(PRSScanResultEntity *scanResultEntity);

@end


@implementation PRSManualCameraPresenter

#pragma mark - PRSManualCameraModuleInput
- (void)configureWithOpenResultAction:(void(^)(PRSScanResultEntity *scanResultEntity))openResultAction {
    self.openResultAction = openResultAction;
}

#pragma mark - PRSManualCameraViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openScanResultModule {
    if (self.openResultAction) {
        self.openResultAction(nil);
    }
}

@end
