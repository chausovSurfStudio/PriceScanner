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
    
    UITabBarItem *mainItem = [[UITabBarItem alloc] initWithTitle:@"Главная".localized image:[UIImage imageNamed:@"icTabBarMain"] tag:0];
    UITabBarItem *cameraItem = [[UITabBarItem alloc] initWithTitle:@"Сканировать".localized image:[UIImage imageNamed:@"icTabBarCamera"] tag:1];
    UITabBarItem *historyItem = [[UITabBarItem alloc] initWithTitle:@"История".localized image:[UIImage imageNamed:@"icTabBarHistory"] tag:2];
    
    mainNavigation.tabBarItem = mainItem;
    cameraNavigation.tabBarItem = cameraItem;
    historyNavigation.tabBarItem = historyItem;
    
    self.tabBar.unselectedItemTintColor = [UIColor prsTabBarInactiveItemColor];
    self.tabBar.tintColor = [UIColor prsMainThemeColor];
    
    [self setViewControllers:@[mainNavigation, cameraNavigation, historyNavigation] animated:NO];
}

@end
