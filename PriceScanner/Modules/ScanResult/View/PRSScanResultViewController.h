//
//  PRSScanResultViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSScanResultViewInput.h"

@protocol PRSScanResultViewOutput;


@interface PRSScanResultViewController : UIViewController <PRSScanResultViewInput>

@property (nonatomic, strong) id<PRSScanResultViewOutput> output;

@end
