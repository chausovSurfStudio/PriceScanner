//
//  PRSMainFlowCoordinator.m
//  PriceScanner
//
//  Created by Александр Чаусов on 04.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSMainFlowCoordinator.h"
#import "PRSMainConfigurator.h"

#import "PRSNavigationController.h"


@interface PRSMainFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSMainFlowCoordinator

- (UINavigationController *)initialView {
    UIViewController *mainView = [PRSMainConfigurator configureModule:nil];
    self.navigationController = [[PRSNavigationController alloc] initWithRootViewController:mainView];
    return self.navigationController;
}

@end
