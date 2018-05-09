//
//  PRSHistoryConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSHistoryConfigurator.h"

#import "PRSHistoryViewController.h"
#import "PRSHistoryPresenter.h"


@implementation PRSHistoryConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSHistoryModuleInput> presenter, UIViewController *view))completion {
    PRSHistoryPresenter *presenter = [PRSHistoryPresenter new];
    PRSHistoryViewController *view = [PRSHistoryViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
