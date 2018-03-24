//
//  PRSInfoConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSInfoConfigurator.h"

#import "PRSInfoViewController.h"
#import "PRSInfoPresenter.h"


@implementation PRSInfoConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSInfoModuleInput> presenter))completion {
    PRSInfoPresenter *presenter = [PRSInfoPresenter new];
    PRSInfoViewController *view = [PRSInfoViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter);
    }
    return view;
}

@end
