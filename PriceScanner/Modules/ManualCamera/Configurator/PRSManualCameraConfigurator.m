//
//  PRSManualCameraConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSManualCameraConfigurator.h"

#import "PRSManualCameraViewController.h"
#import "PRSManualCameraPresenter.h"


@implementation PRSManualCameraConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSManualCameraModuleInput> presenter, UIViewController *view))completion {
    PRSManualCameraPresenter *presenter = [PRSManualCameraPresenter new];
    PRSManualCameraViewController *view = [PRSManualCameraViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
