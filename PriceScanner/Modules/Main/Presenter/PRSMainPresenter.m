//
//  PRSMainPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSMainPresenter.h"
#import "PRSMainViewInput.h"


@implementation PRSMainPresenter

#pragma mark - PRSMainViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openCameraModule {
    NSLog(@"openCameraModule");
}

@end
