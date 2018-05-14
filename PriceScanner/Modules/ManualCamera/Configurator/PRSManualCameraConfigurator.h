//
//  PRSManualCameraConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSManualCameraModuleInput;


@interface PRSManualCameraConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSManualCameraModuleInput> presenter, UIViewController *view))completion;

@end
