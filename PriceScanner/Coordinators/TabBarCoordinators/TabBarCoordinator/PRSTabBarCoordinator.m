//
//  PRSTabBarCoordinator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 28.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSTabBarCoordinator.h"

#import "PRSCameraFlowCoordinator.h"
#import "PRSInfoFlowCoordinator.h"


@interface PRSTabBarCoordinator()

@property (nonatomic, strong) PRSCameraFlowCoordinator *cameraCoordinator;
@property (nonatomic, strong) PRSInfoFlowCoordinator *infoCoordinator;

@end


@implementation PRSTabBarCoordinator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cameraCoordinator = [PRSCameraFlowCoordinator new];
        self.infoCoordinator = [PRSInfoFlowCoordinator new];
    }
    return self;
}

- (UINavigationController *)cameraInitialView {
    return [self.cameraCoordinator initialView];
}

- (UINavigationController *)infoInitialView {
    return [self.infoCoordinator initialView];
}

@end
