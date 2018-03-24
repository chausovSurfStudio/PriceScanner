//
//  MainTabBarController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "MainTabBarController.h"

#import "CameraFlowCoordinator.h"
#import "InfoFlowCoordinator.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInitialTabs];
}

- (void)setupInitialTabs {
    UINavigationController *cameraNavigation = [[CameraFlowCoordinator new] initialScreen];
    UINavigationController *infoNavigation = [[InfoFlowCoordinator new] initialScreen];
    
    UITabBarItem *cameraItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    UITabBarItem *infoItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:1];
    
    cameraNavigation.tabBarItem = cameraItem;
    infoNavigation.tabBarItem = infoItem;
    
    [self setViewControllers:@[cameraNavigation, infoNavigation] animated:NO];
}

@end
