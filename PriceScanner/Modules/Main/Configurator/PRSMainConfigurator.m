//
//  PRSMainConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSMainConfigurator.h"

#import "PRSMainViewController.h"
#import "PRSMainPresenter.h"


@implementation PRSMainConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSMainModuleInput> presenter, UIViewController *view))completion {
    PRSMainPresenter *presenter = [PRSMainPresenter new];
    PRSMainViewController *view = [PRSMainViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
