//
//  PRSCameraConfigurator.h
//  PriceScanner
//
//  Created by Alexander Chausov on 28/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSCameraModuleInput;


@interface PRSCameraConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSCameraModuleInput> presenter, UIViewController *view))completion;

@end
