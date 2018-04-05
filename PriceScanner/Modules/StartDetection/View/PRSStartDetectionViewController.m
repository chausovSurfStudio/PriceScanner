//
//  PRSStartDetectionViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSStartDetectionViewController.h"
#import "PRSStartDetectionViewOutput.h"


@interface PRSStartDetectionViewController ()

@end


@implementation PRSStartDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - Actions
- (IBAction)tapOnStartRecognizeButton:(UIButton *)sender {
    [self.output openCamera];
}

#pragma mark - PRSStartDetectionViewInput

@end
