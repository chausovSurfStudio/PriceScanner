//
//  CameraFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCameraFlowCoordinator.h"
#import "PRSCameraConfigurator.h"
#import "PRSScanResultConfigurator.h"

#import "PRSCameraModuleInput.h"
#import "PRSScanResultModuleInput.h"

#import "PRSNavigationController.h"


@interface PRSCameraFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSCameraFlowCoordinator

- (UINavigationController *)initialView {
    @weakify(self);
    UIViewController *cameraView = [PRSCameraConfigurator configureModule:^(id<PRSCameraModuleInput> presenter) {
        [presenter configureWithOpenResultAction:^{
            @strongify(self);
            [self openResultModule];
        }];
    }];
    self.navigationController = [[PRSNavigationController alloc] initWithRootViewController:cameraView];
    return self.navigationController;
}

- (void)openResultModule {
    UIViewController *resultView = [PRSScanResultConfigurator configureModule:^(id<PRSScanResultModuleInput> presenter, UIViewController *view) {
        @weakify(view);
        [presenter configureAsModalWithCloseAction:^{
            @strongify(view);
            [view dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:resultView];
    [self.navigationController.topViewController presentViewController:navigationController animated:YES completion:nil];
}

@end
