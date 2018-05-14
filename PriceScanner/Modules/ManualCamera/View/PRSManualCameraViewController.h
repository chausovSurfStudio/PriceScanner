//
//  PRSManualCameraViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSManualCameraViewInput.h"

@protocol PRSManualCameraViewOutput;


@interface PRSManualCameraViewController : UIViewController <PRSManualCameraViewInput>

@property (nonatomic, strong) id<PRSManualCameraViewOutput> output;

@end
