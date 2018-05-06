//
//  PRSMainFlowCoordinator.m
//  PriceScanner
//
//  Created by Александр Чаусов on 04.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSMainFlowCoordinator.h"
#import "PRSMainConfigurator.h"

#import "PRSMainModuleInput.h"

#import "PRSNavigationController.h"
#import "PRSTabbarIndex.h"


@interface PRSMainFlowCoordinator()

@property (nonatomic, strong) UINavigationController *navigationController;

@end


@implementation PRSMainFlowCoordinator

- (UINavigationController *)initialView {
    UIViewController *mainView = [PRSMainConfigurator configureModule:^(id<PRSMainModuleInput> presenter, UIViewController *view) {
        @weakify(view);
        [presenter configureWithOpenCameraModuleAction:^{
            @strongify(view);
            if (view.tabBarController) {
                view.tabBarController.selectedIndex = PRSTabbarIndexCamera;
            }
        }];
    }];
    self.navigationController = [[PRSNavigationController alloc] initWithRootViewController:mainView];
    return self.navigationController;
}

@end
