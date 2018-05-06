//
//  PRSMainViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSMainViewInput.h"

@protocol PRSMainViewOutput;


@interface PRSMainViewController : UIViewController <PRSMainViewInput>

@property (nonatomic, strong) id<PRSMainViewOutput> output;

@end
