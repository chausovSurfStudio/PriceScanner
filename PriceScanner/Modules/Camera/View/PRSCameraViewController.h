//
//  PRSCameraViewController.h
//  PriceScanner
//
//  Created by Alexander Chausov on 28/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSCameraViewInput.h"

@protocol PRSCameraViewOutput;


@interface PRSCameraViewController : UIViewController <PRSCameraViewInput>

@property (nonatomic, strong) id<PRSCameraViewOutput> output;

@end
