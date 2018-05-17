//
//  PRSScanPreviewViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRSScanPreviewViewInput.h"

@protocol PRSScanPreviewViewOutput;


@interface PRSScanPreviewViewController : UIViewController <PRSScanPreviewViewInput>

@property (nonatomic, strong) id<PRSScanPreviewViewOutput> output;

@end
