//
//  PRSScanPreviewViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanPreviewViewController.h"
#import "PRSScanPreviewViewOutput.h"


@interface PRSScanPreviewViewController ()

@end


@implementation PRSScanPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSScanPreviewViewInput
- (void)setupInitialState {
    // установка начального состояния view
}

@end
