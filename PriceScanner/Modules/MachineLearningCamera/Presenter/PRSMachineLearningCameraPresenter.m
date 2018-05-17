//
//  PRSMachineLearningCameraPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSMachineLearningCameraPresenter.h"
#import "PRSMachineLearningCameraViewInput.h"


@interface PRSMachineLearningCameraPresenter()

@property (nonatomic, copy) void (^openPreviewAction)(PRSScanResultEntity *scanResultEntity);

@end


@implementation PRSMachineLearningCameraPresenter

#pragma mark - PRSMachineLearningCameraModuleInput
- (void)configureWithOpenPreviewAction:(void(^)(PRSScanResultEntity *scanResultEntity))openPreviewAction {
    self.openPreviewAction = openPreviewAction;
}

#pragma mark - PRSMachineLearningCameraViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openScanPreviewModule {
    if (self.openPreviewAction) {
        self.openPreviewAction(nil);
    }
}

@end
