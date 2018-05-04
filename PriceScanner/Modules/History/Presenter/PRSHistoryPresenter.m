//
//  PRSHistoryPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSHistoryPresenter.h"
#import "PRSHistoryViewInput.h"


@implementation PRSHistoryPresenter

#pragma mark - PRSHistoryViewOutput
- (void)viewLoaded {
    // установка начального состояния presenter'а
    [self.view setupInitialState];
}

@end
