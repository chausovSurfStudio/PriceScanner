//
//  MainTabBarController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "MainTabBarController.h"

#import "InfoConfigurator.h"
#import "StartDetectionConfigurator.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInitialTabs];
}

- (void)setupInitialTabs {
    UIViewController *startDetectionView = [StartDetectionConfigurator configureModule:nil];
    UIViewController *infoView = [InfoConfigurator configureModule:nil];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:startDetectionView];
    UINavigationController *navVC2 = [[UINavigationController alloc] initWithRootViewController:infoView];
    
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:1];
    
    navVC.tabBarItem = firstItem;
    navVC2.tabBarItem = secondItem;
    
    [self setViewControllers:@[navVC, navVC2] animated:NO];
}

@end
