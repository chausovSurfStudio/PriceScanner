//
//  CameraFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCameraFlowCoordinator.h"
#import "PRSStartDetectionConfigurator.h"

@implementation PRSCameraFlowCoordinator

- (UINavigationController *)initialScreen {
    UIViewController *startDetectionView = [PRSStartDetectionConfigurator configureModule:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:startDetectionView];
    return navigationController;
}

@end
