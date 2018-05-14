//
//  CameraFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCameraFlowCoordinator.h"
#import "PRSCameraConfigurator.h"
#import "PRSScanMethodConfigurator.h"
#import "PRSScanResultConfigurator.h"

#import "PRSCameraModuleInput.h"
#import "PRSScanMethodModuleInput.h"
#import "PRSScanResultModuleInput.h"

#import "PRSNavigationController.h"
#import "PRSModalNavigationController.h"


@interface PRSCameraFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSCameraFlowCoordinator

- (UINavigationController *)initialView {
    @weakify(self);
    UIViewController *scanMethodView = [PRSScanMethodConfigurator configureModule:^(id<PRSScanMethodModuleInput> presenter, UIViewController *view) {
        [presenter configureWithOpenNativeCameraModuleAction:^{
            @strongify(self);
            [self openNativeCameraModule];
        } openMLCameraModuleAction:^{
            // TODO: доделать
            NSLog(@"openMLCameraModuleAction");
        } openManualCameraModuleAction:^{
            // TODO: доделать
            NSLog(@"openManualCameraModuleAction");
        }];
    }];
    self.navigationController = [[PRSNavigationController alloc] initWithRootViewController:scanMethodView];
    return self.navigationController;
}

- (void)openNativeCameraModule {
    @weakify(self);
    UIViewController *cameraView = [PRSCameraConfigurator configureModule:^(id<PRSCameraModuleInput> presenter, UIViewController *view) {
        [presenter configureWithOpenResultAction:^(PRSScanResultEntity *scanResultEntity) {
            @strongify(self);
            [self openResultModuleWithEntity:scanResultEntity];
        }];
    }];
    [self.navigationController pushViewController:cameraView animated:YES];
}

- (void)openResultModuleWithEntity:(PRSScanResultEntity *)entity {
    UIViewController *resultView = [PRSScanResultConfigurator configureModule:^(id<PRSScanResultModuleInput> presenter, UIViewController *view) {
        @weakify(view);
        [presenter configureWithScanResult:entity];
        [presenter configureAsModalWithCloseAction:^{
            @strongify(view);
            [view dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
    UINavigationController *navigationController = [[PRSModalNavigationController alloc] initWithRootViewController:resultView];
    [self.navigationController.topViewController presentViewController:navigationController animated:YES completion:nil];
}

@end
