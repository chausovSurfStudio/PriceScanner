//
//  PRSAlertConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSAlertModuleInput;


@interface PRSAlertConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSAlertModuleInput> presenter, UIViewController *view))completion;

@end
