//
//  StartDetectionViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartDetectionViewInput.h"

@protocol StartDetectionViewOutput;

@interface StartDetectionViewController : UIViewController <StartDetectionViewInput>

@property (nonatomic, strong) id<StartDetectionViewOutput> output;

@end
