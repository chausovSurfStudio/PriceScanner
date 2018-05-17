//
//  PRSScanPreviewConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSScanPreviewModuleInput;


@interface PRSScanPreviewConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSScanPreviewModuleInput> presenter, UIViewController *view))completion;

@end
