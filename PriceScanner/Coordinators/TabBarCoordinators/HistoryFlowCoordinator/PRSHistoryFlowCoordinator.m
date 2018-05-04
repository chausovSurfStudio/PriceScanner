//
//  PRSHistoryFlowCoordinator.m
//  PriceScanner
//
//  Created by Александр Чаусов on 04.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSHistoryFlowCoordinator.h"
#import "PRSHistoryConfigurator.h"

#import "PRSNavigationController.h"

@interface PRSHistoryFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSHistoryFlowCoordinator

- (UINavigationController *)initialView {
    UIViewController *historyView = [PRSHistoryConfigurator configureModule:nil];
    self.navigationController = [[PRSNavigationController alloc] initWithRootViewController:historyView];
    return self.navigationController;
}

@end
