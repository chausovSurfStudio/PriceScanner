//
//  InfoConfigurator.m
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "InfoConfigurator.h"

#import "InfoViewController.h"
#import "InfoPresenter.h"

@implementation InfoConfigurator

+ (UIViewController *)configureModule:(void(^)(id<InfoModuleInput> presenter))completion {
    InfoPresenter *presenter = [InfoPresenter new];
    InfoViewController *view = [InfoViewController new];
    view.output = presenter;
    presenter.view = view;
    if (completion) {
        completion(presenter);
    }
    return view;
}

@end
