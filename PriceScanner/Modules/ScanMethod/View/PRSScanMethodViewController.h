//
//  PRSScanMethodViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSScanMethodViewInput.h"

@protocol PRSScanMethodViewOutput;


@interface PRSScanMethodViewController : UIViewController <PRSScanMethodViewInput>

@property (nonatomic, strong) id<PRSScanMethodViewOutput> output;

@end
