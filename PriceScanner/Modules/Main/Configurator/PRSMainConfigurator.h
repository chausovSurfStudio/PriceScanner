//
//  PRSMainConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PRSMainModuleInput;


@interface PRSMainConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<PRSMainModuleInput> presenter))completion;

@end
