//
//  PRSTabBarCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 28.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSTabBarCoordinator.h"

#import "PRSCameraFlowCoordinator.h"
#import "PRSHistoryFlowCoordinator.h"
#import "PRSMainFlowCoordinator.h"


@interface PRSTabBarCoordinator()

@property (nonatomic, strong) PRSCameraFlowCoordinator *cameraCoordinator;
@property (nonatomic, strong) PRSHistoryFlowCoordinator *historyCoordinator;
@property (nonatomic, strong) PRSMainFlowCoordinator *mainCoordinator;

@end


@implementation PRSTabBarCoordinator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cameraCoordinator = [PRSCameraFlowCoordinator new];
        self.historyCoordinator = [PRSHistoryFlowCoordinator new];
        self.mainCoordinator = [PRSMainFlowCoordinator new];
    }
    return self;
}

- (UINavigationController *)cameraInitialView {
    return [self.cameraCoordinator initialView];
}

- (UINavigationController *)historyInitialView {
    return [self.historyCoordinator initialView];
}

- (UINavigationController *)mainInitialView {
    return [self.mainCoordinator initialView];
}

@end
