//
//  PRSHistoryFlowCoordinator.m
//  PriceScanner
//
//  Created by Александр Чаусов on 04.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSHistoryFlowCoordinator.h"
#import "PRSHistoryConfigurator.h"
#import "PRSScanResultConfigurator.h"

#import "PRSHistoryModuleInput.h"

#import "PRSNavigationController.h"

@interface PRSHistoryFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSHistoryFlowCoordinator

- (UINavigationController *)initialView {
    @weakify(self);
    UIViewController *historyView = [PRSHistoryConfigurator configureModule:^(id<PRSHistoryModuleInput> presenter) {
        [presenter configureWithOpenResultAction:^{
            @strongify(self);
            [self openResultModule];
        }];
    }];
    self.navigationController = [[PRSNavigationController alloc] initWithRootViewController:historyView];
    return self.navigationController;
}

- (void)openResultModule {
    UIViewController *resultView = [PRSScanResultConfigurator configureModule:nil];
    [self.navigationController pushViewController:resultView animated:YES];
}

@end
