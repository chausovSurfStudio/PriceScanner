//
//  PRSCameraConfigurator.m
//  PriceScanner
//
//  Created by Alexander Chausov on 28/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSCameraConfigurator.h"

#import "PRSCameraViewController.h"
#import "PRSCameraPresenter.h"


@implementation PRSCameraConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSCameraModuleInput> presenter))completion {
    PRSCameraPresenter *presenter = [PRSCameraPresenter new];
    PRSCameraViewController *view = [PRSCameraViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter);
    }
    
    view.hidesBottomBarWhenPushed = YES;
    
    return view;
}

@end
