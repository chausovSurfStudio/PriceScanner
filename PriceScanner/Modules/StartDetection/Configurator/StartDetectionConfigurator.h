//
//  StartDetectionConfigurator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol StartDetectionModuleInput;

@interface StartDetectionConfigurator : NSObject

+ (UIViewController *)configureModule:(void(^)(id<StartDetectionModuleInput> presenter))completion;

@end
