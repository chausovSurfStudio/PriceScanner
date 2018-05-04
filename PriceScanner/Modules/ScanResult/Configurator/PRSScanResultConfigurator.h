//
//  PRSScanResultConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSScanResultModuleInput;


@interface PRSScanResultConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSScanResultModuleInput> presenter))completion;

@end
