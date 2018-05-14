//
//  PRSScanMethodConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanMethodConfigurator.h"

#import "PRSScanMethodViewController.h"
#import "PRSScanMethodPresenter.h"


@implementation PRSScanMethodConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSScanMethodModuleInput> presenter, UIViewController *view))completion {
    PRSScanMethodPresenter *presenter = [PRSScanMethodPresenter new];
    PRSScanMethodViewController *view = [PRSScanMethodViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
