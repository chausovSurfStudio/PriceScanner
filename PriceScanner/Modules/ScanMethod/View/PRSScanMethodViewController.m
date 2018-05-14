//
//  PRSScanMethodViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanMethodViewController.h"
#import "PRSScanMethodViewOutput.h"


@interface PRSScanMethodViewController ()

@end


@implementation PRSScanMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSScanMethodViewInput
- (void)setupInitialState {
    // установка начального состояния view
}

@end
