//
//  PRSAlertViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSAlertViewInput.h"

@protocol PRSAlertViewOutput;


@interface PRSAlertViewController : UIViewController <PRSAlertViewInput>

@property (nonatomic, strong) id<PRSAlertViewOutput> output;

@end
