//
//  PRSStartDetectionPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSStartDetectionPresenter.h"
#import "PRSStartDetectionViewInput.h"


@interface PRSStartDetectionPresenter()

@property (nonatomic, copy) void (^openCameraModuleHandler)(void);

@end


@implementation PRSStartDetectionPresenter

#pragma mark - PRSStartDetectionModuleInput
- (void)setOpenCameraModuleHandler:(void(^)(void))openCameraModuleHandler {
    _openCameraModuleHandler = openCameraModuleHandler;
}

#pragma mark - PRSStartDetectionViewOutput
- (void)viewLoaded {
    // установка начального состояния presenter'а
}

- (void)openCameraModule {
    if (self.openCameraModuleHandler) {
        self.openCameraModuleHandler();
    }
}

@end
