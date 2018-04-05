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

@property (nonatomic, copy) void (^openCameraHandler)(void);

@end


@implementation PRSStartDetectionPresenter

#pragma mark - PRSStartDetectionModuleInput
- (void)setOpenCameraHandler:(void(^)(void))openCameraHandler {
    _openCameraHandler = openCameraHandler;
}

#pragma mark - PRSStartDetectionViewOutput
- (void)viewLoaded {
    // установка начального состояния presenter'а
}

- (void)openCamera {
    if (self.openCameraHandler) {
        self.openCameraHandler();
    }
}

@end
