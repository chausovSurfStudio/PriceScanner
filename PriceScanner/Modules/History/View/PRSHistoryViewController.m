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
    [self configureNavigationBar];
}

#pragma mark - Actions
- (IBAction)tapOnOpenResultButton:(UIButton *)sender {
    [self.output openScanResultModule];
}

#pragma mark - Configure
- (void)configureNavigationBar {
    self.title = @"История".localized;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
