//
//  PRSNativeCameraViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSNativeCameraViewInput.h"

@protocol PRSNativeCameraViewOutput;


@interface PRSNativeCameraViewController : UIViewController <PRSNativeCameraViewInput>

@property (nonatomic, strong) id<PRSNativeCameraViewOutput> output;

@end
