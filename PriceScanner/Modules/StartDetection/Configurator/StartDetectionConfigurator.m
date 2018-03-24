//
//  StartDetectionConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "StartDetectionConfigurator.h"

#import "StartDetectionViewController.h"
#import "StartDetectionPresenter.h"

@implementation StartDetectionConfigurator

+ (UIViewController *)configureModule:(void(^)(id<StartDetectionModuleInput> presenter))completion {
    StartDetectionPresenter *presenter = [StartDetectionPresenter new];
    StartDetectionViewController *view = [StartDetectionViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter);
    }
    return view;
}

@end
