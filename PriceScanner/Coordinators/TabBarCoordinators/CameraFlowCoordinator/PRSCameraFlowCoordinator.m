//
//  CameraFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCameraFlowCoordinator.h"
#import "PRSStartDetectionConfigurator.h"
#import "PRSCameraConfigurator.h"

#import "PRSStartDetectionModuleInput.h"


@interface PRSCameraFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSCameraFlowCoordinator

- (UINavigationController *)initialView {
    UIViewController *startDetectionView = [PRSStartDetectionConfigurator configureModule:^(id<PRSStartDetectionModuleInput> presenter) {
        __weak typeof(self) weakSelf = self;
        [presenter setOpenCameraModuleHandler:^{
            [weakSelf openCameraModule];
        }];
    }];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:startDetectionView];
    return self.navigationController;
}

- (void)openCameraModule {
    UIViewController *cameraView = [PRSCameraConfigurator configureModule:nil];
    [self.navigationController pushViewController:cameraView animated:YES];
    
}

@end
