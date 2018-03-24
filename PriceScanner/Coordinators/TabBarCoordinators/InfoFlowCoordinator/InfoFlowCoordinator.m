//
//  InfoFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "InfoFlowCoordinator.h"
#import "PRSInfoConfigurator.h"

@implementation InfoFlowCoordinator

- (UINavigationController *)initialScreen {
    UIViewController *infoView = [PRSInfoConfigurator configureModule:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:infoView];
    return navigationController;
}

@end
