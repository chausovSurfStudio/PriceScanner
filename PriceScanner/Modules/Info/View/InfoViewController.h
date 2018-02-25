//
//  InfoViewController.h
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewInput.h"

@protocol InfoViewOutput;

@interface InfoViewController : UIViewController <InfoViewInput>

@property (nonatomic, strong) id<InfoViewOutput> output;

@end
