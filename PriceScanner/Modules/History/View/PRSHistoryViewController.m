//
//  PRSHistoryViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSHistoryViewController.h"
#import "PRSHistoryViewOutput.h"


@interface PRSHistoryViewController ()

@end


@implementation PRSHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSHistoryViewInput
- (void)setupInitialState {
    // установка начального состояния view
}

@end
