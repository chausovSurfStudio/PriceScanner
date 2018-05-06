//
//  PRSHistoryViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSHistoryViewInput.h"

@protocol PRSHistoryViewOutput;


@interface PRSHistoryViewController : UIViewController <PRSHistoryViewInput>

@property (nonatomic, strong) id<PRSHistoryViewOutput> output;

@end
