//
//  PRSScanPreviewConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanPreviewConfigurator.h"

#import "PRSScanPreviewViewController.h"
#import "PRSScanPreviewPresenter.h"


@implementation PRSScanPreviewConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSScanPreviewModuleInput> presenter, UIViewController *view))completion {
    PRSScanPreviewPresenter *presenter = [PRSScanPreviewPresenter new];
    PRSScanPreviewViewController *view = [PRSScanPreviewViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter, view);
    }
    return view;
}

@end
