//
//  MainTabBarController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSMainTabBarController.h"

#import "PRSCameraFlowCoordinator.h"
#import "PRSInfoFlowCoordinator.h"


@interface PRSMainTabBarController ()

@end


@implementation PRSMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInitialTabs];
}

- (void)setupInitialTabs {
    UINavigationController *cameraNavigation = [[PRSCameraFlowCoordinator new] initialScreen];
    UINavigationController *infoNavigation = [[PRSInfoFlowCoordinator new] initialScreen];
    
    UITabBarItem *cameraItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    UITabBarItem *infoItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:1];
    
    cameraNavigation.tabBarItem = cameraItem;
    infoNavigation.tabBarItem = infoItem;
    
    [self setViewControllers:@[cameraNavigation, infoNavigation] animated:NO];
}

@end
