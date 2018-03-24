//
//  InfoFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSInfoFlowCoordinator.h"
#import "PRSInfoConfigurator.h"

@implementation PRSInfoFlowCoordinator

- (UINavigationController *)initialScreen {
    UIViewController *infoView = [PRSInfoConfigurator configureModule:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:infoView];
    return navigationController;
}

@end
