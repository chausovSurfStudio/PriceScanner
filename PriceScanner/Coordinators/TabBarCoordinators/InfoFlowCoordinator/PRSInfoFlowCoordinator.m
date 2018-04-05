//
//  InfoFlowCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSInfoFlowCoordinator.h"
#import "PRSInfoConfigurator.h"


@interface PRSInfoFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSInfoFlowCoordinator

- (UINavigationController *)initialView {
    UIViewController *infoView = [PRSInfoConfigurator configureModule:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:infoView];
    return self.navigationController;
}

@end
