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

@property (nonatomic, copy) void (^openResultAction)(PRSScanResultEntity *scanResultEntity);

@end


@implementation PRSMachineLearningCameraPresenter

#pragma mark - PRSMachineLearningCameraModuleInput
- (void)configureWithOpenResultAction:(void(^)(PRSScanResultEntity *scanResultEntity))openResultAction {
    self.openResultAction = openResultAction;
}

#pragma mark - PRSMachineLearningCameraViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openScanResultModule {
    if (self.openResultAction) {
        self.openResultAction(nil);
    }
}

@end
