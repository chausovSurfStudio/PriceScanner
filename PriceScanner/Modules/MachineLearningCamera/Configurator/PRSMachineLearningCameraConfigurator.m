//
//  PRSMachineLearningCameraConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSMachineLearningCameraConfigurator.h"

#import "PRSMachineLearningCameraViewController.h"
#import "PRSMachineLearningCameraPresenter.h"


@implementation PRSMachineLearningCameraConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSMachineLearningCameraModuleInput> presenter, UIViewController *view))completion {
    PRSMachineLearningCameraPresenter *presenter = [PRSMachineLearningCameraPresenter new];
    PRSMachineLearningCameraViewController *view = [PRSMachineLearningCameraViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
