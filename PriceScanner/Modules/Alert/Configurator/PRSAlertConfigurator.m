//
//  PRSAlertConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSAlertConfigurator.h"

#import "PRSAlertViewController.h"
#import "PRSAlertPresenter.h"


@implementation PRSAlertConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSAlertModuleInput> presenter, UIViewController *view))completion {
    PRSAlertPresenter *presenter = [PRSAlertPresenter new];
    PRSAlertViewController *view = [PRSAlertViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
