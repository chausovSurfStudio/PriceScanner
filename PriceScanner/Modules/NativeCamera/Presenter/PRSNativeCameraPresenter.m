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

@property (nonatomic, copy) void (^openPreviewAction)(PRSScanResultEntity *scanResultEntity);

@end


@implementation PRSNativeCameraPresenter

#pragma mark - PRSNativeCameraModuleInput
- (void)configureWithOpenPreviewAction:(void(^)(PRSScanResultEntity *scanResultEntity))openPreviewAction {
    self.openPreviewAction = openPreviewAction;
}

#pragma mark - PRSNativeCameraViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openScanPreviewModule {
    if (self.openPreviewAction) {
        self.openPreviewAction(nil);
    }
}

@end
