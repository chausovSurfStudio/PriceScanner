//
//  PRSStartDetectionConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSStartDetectionConfigurator.h"

#import "PRSStartDetectionViewController.h"
#import "PRSStartDetectionPresenter.h"


@implementation PRSStartDetectionConfigurator

+ (UIViewController *)configureModule:(void(^)(id<PRSStartDetectionModuleInput> presenter))completion {
    PRSStartDetectionPresenter *presenter = [PRSStartDetectionPresenter new];
    PRSStartDetectionViewController *view = [PRSStartDetectionViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter);
    }
    return view;
}

@end
