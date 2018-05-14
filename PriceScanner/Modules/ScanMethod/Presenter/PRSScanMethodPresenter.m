//
//  PRSScanMethodPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanMethodPresenter.h"
#import "PRSScanMethodViewInput.h"


@implementation PRSScanMethodPresenter

#pragma mark - PRSScanMethodViewOutput
- (void)viewLoaded {
    // установка начального состояния presenter'а
    [self.view setupInitialState];
}

@end
