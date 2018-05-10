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
#import "PRSScanResultModuleInput.h"

#import "PRSNavigationController.h"
#import "PRSTabbarIndex.h"


@interface PRSHistoryFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSHistoryFlowCoordinator

- (UINavigationController *)initialView {
    @weakify(self);
    UIViewController *historyView = [PRSHistoryConfigurator configureModule:^(id<PRSHistoryModuleInput> presenter, UIViewController *view) {
        @weakify(view);
        [presenter configureWithOpenResultAction:^(PRSScanResultEntity *scanResultEntity) {
            @strongify(self);
            [self openResultModuleWithEntity:scanResultEntity];
        } openCameraModuleAction:^{
            @strongify(view);
            if (view.tabBarController) {
                view.tabBarController.selectedIndex = PRSTabbarIndexCamera;
            }
        }];
    }];
    self.navigationController = [[PRSNavigationController alloc] initWithRootViewController:historyView];
    return self.navigationController;
}

- (void)openResultModuleWithEntity:(PRSScanResultEntity *)entity {
    UIViewController *resultView = [PRSScanResultConfigurator configureModule:^(id<PRSScanResultModuleInput> presenter, UIViewController *view) {
        [presenter configureWithScanResult:entity];
    }];
    [self.navigationController pushViewController:resultView animated:YES];
}

@end
