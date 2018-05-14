//
//  PRSNativeCameraConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSNativeCameraModuleInput;


@interface PRSNativeCameraConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSNativeCameraModuleInput> presenter, UIViewController *view))completion;

@end
