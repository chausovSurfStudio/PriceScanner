//
//  PRSInfoConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSInfoModuleInput;


@interface PRSInfoConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSInfoModuleInput> presenter))completion;

@end
