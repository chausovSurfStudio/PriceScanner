//
//  PRSMainViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSMainViewController.h"
#import "PRSMainViewOutput.h"


@interface PRSMainViewController ()

@end


@implementation PRSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSMainViewInput
- (void)setupInitialState {
    // установка начального состояния view
}

@end
