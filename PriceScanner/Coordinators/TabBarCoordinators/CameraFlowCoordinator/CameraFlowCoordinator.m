//
//  CameraFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "CameraFlowCoordinator.h"
#import "PRSStartDetectionConfigurator.h"

@implementation CameraFlowCoordinator

- (UINavigationController *)initialScreen {
    UIViewController *startDetectionView = [PRSStartDetectionConfigurator configureModule:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:startDetectionView];
    return navigationController;
}

@end
