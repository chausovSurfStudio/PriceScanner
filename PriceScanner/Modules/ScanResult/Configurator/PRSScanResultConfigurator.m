//
//  PRSScanResultConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanResultConfigurator.h"

#import "PRSScanResultViewController.h"
#import "PRSScanResultPresenter.h"


@implementation PRSScanResultConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSScanResultModuleInput> presenter, UIViewController *view))completion {
    PRSScanResultPresenter *presenter = [PRSScanResultPresenter new];
    PRSScanResultViewController *view = [PRSScanResultViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
