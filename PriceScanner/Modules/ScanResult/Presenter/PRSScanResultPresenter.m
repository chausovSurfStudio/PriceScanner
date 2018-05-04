//
//  PRSScanResultPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanResultPresenter.h"
#import "PRSScanResultViewInput.h"


@implementation PRSScanResultPresenter

#pragma mark - PRSScanResultViewOutput
- (void)viewLoaded {
    // установка начального состояния presenter'а
    [self.view setupInitialState];
}

@end
