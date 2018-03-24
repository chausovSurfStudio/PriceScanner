//
//  PRSInfoViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSInfoViewInput.h"

@protocol PRSInfoViewOutput;


@interface PRSInfoViewController : UIViewController <PRSInfoViewInput>

@property (nonatomic, strong) id<PRSInfoViewOutput> output;

@end
