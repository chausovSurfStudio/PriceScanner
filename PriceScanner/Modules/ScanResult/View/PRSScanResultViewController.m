//
//  PRSScanResultViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanResultViewController.h"
#import "PRSScanResultViewOutput.h"


@interface PRSScanResultViewController ()

@end


@implementation PRSScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSScanResultViewInput
- (void)setupInitialState {
    self.title = @"Результаты сканирования".localized;
    // установка начального состояния view
}

@end
