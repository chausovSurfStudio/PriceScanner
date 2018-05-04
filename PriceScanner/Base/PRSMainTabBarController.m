//
//  MainTabBarController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSMainTabBarController.h"

#import "PRSTabBarCoordinator.h"


@interface PRSMainTabBarController ()

@property (nonatomic, strong) PRSTabBarCoordinator *mainCoordinator;

@end


@implementation PRSMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInitialTabs];
}

- (void)setupInitialTabs {
    self.mainCoordinator = [PRSTabBarCoordinator new];
    
    UINavigationController *mainNavigation = [self.mainCoordinator mainInitialView];
    UINavigationController *cameraNavigation = [self.mainCoordinator cameraInitialView];
    UINavigationController *historyNavigation = [self.mainCoordinator historyInitialView];
    
    UITabBarItem *mainItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:0];
    UITabBarItem *cameraItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    UITabBarItem *historyItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:2];
    
    mainNavigation.tabBarItem = mainItem;
    cameraNavigation.tabBarItem = cameraItem;
    historyNavigation.tabBarItem = historyItem;
    
    [self setViewControllers:@[mainNavigation, cameraNavigation, historyNavigation] animated:NO];
}

@end
