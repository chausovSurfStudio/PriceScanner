//
//  PRSInfoViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSInfoViewController.h"
#import "PRSInfoViewOutput.h"


@interface PRSInfoViewController ()

@property (nonatomic, strong) IBOutlet UILabel *someLabel;

@end


@implementation PRSInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
    
    self.someLabel.text = NSLocalizedString(@"Welcome", nil);
}

#pragma mark - PRSInfoViewInput


@end
