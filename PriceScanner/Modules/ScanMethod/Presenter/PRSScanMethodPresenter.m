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

@property (nonatomic, copy) void (^openNativeCameraModuleAction)(void);
@property (nonatomic, copy) void (^openMLCameraModuleAction)(void);
@property (nonatomic, copy) void (^openManualCameraModuleAction)(void);

@end


@implementation PRSScanMethodPresenter

#pragma mark - PRSScanMethodModuleInput
- (void)configureWithOpenNativeCameraModuleAction:(void(^)(void))openNativeCameraModuleAction
                         openMLCameraModuleAction:(void(^)(void))openMLCameraModuleAction
                     openManualCameraModuleAction:(void(^)(void))openManualCameraModuleAction {
    self.openNativeCameraModuleAction = openNativeCameraModuleAction;
    self.openMLCameraModuleAction = openMLCameraModuleAction;
    self.openManualCameraModuleAction = openManualCameraModuleAction;
}

#pragma mark - PRSScanMethodViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)tapOnScanWithNativeMethod {
    if (self.openNativeCameraModuleAction) {
        self.openNativeCameraModuleAction();
    }
}

- (void)tapOnScanWithMLMethod {
    if (self.openMLCameraModuleAction) {
        self.openMLCameraModuleAction();
    }
}

- (void)tapOnScanWithManualMethod {
    if (self.openManualCameraModuleAction) {
        self.openManualCameraModuleAction();
    }
}

@end
