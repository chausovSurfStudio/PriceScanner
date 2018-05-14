//
//  PRSMachineLearningCameraViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSMachineLearningCameraViewInput.h"

@protocol PRSMachineLearningCameraViewOutput;


@interface PRSMachineLearningCameraViewController : UIViewController <PRSMachineLearningCameraViewInput>

@property (nonatomic, strong) id<PRSMachineLearningCameraViewOutput> output;

@end
