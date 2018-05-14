//
//  PRSMachineLearningCameraConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSMachineLearningCameraModuleInput;


@interface PRSMachineLearningCameraConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSMachineLearningCameraModuleInput> presenter, UIViewController *view))completion;

@end
