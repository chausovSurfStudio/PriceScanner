//
//  PRSNativeCameraPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSNativeCameraPresenter.h"
#import "PRSNativeCameraViewInput.h"


@interface PRSNativeCameraPresenter()

@property (nonatomic, copy) void (^openResultAction)(PRSScanResultEntity *scanResultEntity);

@end


@implementation PRSNativeCameraPresenter

#pragma mark - PRSNativeCameraModuleInput
- (void)configureWithOpenResultAction:(void(^)(PRSScanResultEntity *scanResultEntity))openResultAction {
    self.openResultAction = openResultAction;
}

#pragma mark - PRSNativeCameraViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openScanResultModule {
    if (self.openResultAction) {
        self.openResultAction(nil);
    }
}

@end
