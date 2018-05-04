//
//  CameraFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCameraFlowCoordinator.h"
#import "PRSCameraConfigurator.h"


@interface PRSCameraFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSCameraFlowCoordinator

- (UINavigationController *)initialView {
    UIViewController *cameraView = [PRSCameraConfigurator configureModule:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:cameraView];
    return self.navigationController;
}

@end
