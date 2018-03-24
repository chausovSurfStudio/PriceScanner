//
//  PRSStartDetectionConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSStartDetectionModuleInput;


@interface PRSStartDetectionConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSStartDetectionModuleInput> presenter))completion;

@end
