//
//  PRSScanMethodPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanMethodPresenter.h"
#import "PRSScanMethodViewInput.h"


@interface PRSScanMethodPresenter()

@property (nonatomic, copy) void (^openIosCameraModuleAction)(void);
@property (nonatomic, copy) void (^openMachineLearningCameraModuleAction)(void);
@property (nonatomic, copy) void (^openManualCameraModuleAction)(void);

@end


@implementation PRSScanMethodPresenter

#pragma mark - PRSScanMethodModuleInput
- (void)configureWithOpenIosCameraModuleAction:(void(^)(void))openIosCameraModuleAction
         openMachineLearningCameraModuleAction:(void(^)(void))openMachineLearningCameraModuleAction
                  openManualCameraModuleAction:(void(^)(void))openManualCameraModuleAction {
    self.openIosCameraModuleAction = openIosCameraModuleAction;
    self.openMachineLearningCameraModuleAction = openMachineLearningCameraModuleAction;
    self.openManualCameraModuleAction = openManualCameraModuleAction;
}

#pragma mark - PRSScanMethodViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)tapOnScanWithIosMethod {
    if (self.openIosCameraModuleAction) {
        self.openIosCameraModuleAction();
    }
}

- (void)tapOnScanWithMachineLearningMethod {
    if (self.openMachineLearningCameraModuleAction) {
        self.openMachineLearningCameraModuleAction();
    }
}

- (void)tapOnScanWithManualMethod {
    if (self.openManualCameraModuleAction) {
        self.openManualCameraModuleAction();
    }
}

@end
