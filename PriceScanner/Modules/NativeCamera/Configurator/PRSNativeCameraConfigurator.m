//
//  PRSNativeCameraConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSNativeCameraConfigurator.h"

#import "PRSNativeCameraViewController.h"
#import "PRSNativeCameraPresenter.h"


@implementation PRSNativeCameraConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSNativeCameraModuleInput> presenter, UIViewController *view))completion {
    PRSNativeCameraPresenter *presenter = [PRSNativeCameraPresenter new];
    PRSNativeCameraViewController *view = [PRSNativeCameraViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
