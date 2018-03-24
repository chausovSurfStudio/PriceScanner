//
//  PRSStartDetectionViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSStartDetectionViewInput.h"

@protocol PRSStartDetectionViewOutput;


@interface PRSStartDetectionViewController : UIViewController <PRSStartDetectionViewInput>

@property (nonatomic, strong) id<PRSStartDetectionViewOutput> output;

@end
