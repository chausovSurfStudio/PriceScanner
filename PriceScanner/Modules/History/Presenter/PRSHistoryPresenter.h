//
//  PRSHistoryPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSHistoryModuleInput.h"
#import "PRSHistoryViewOutput.h"

@protocol PRSHistoryViewInput;


@interface PRSHistoryPresenter : PRSBasePresenter <PRSHistoryModuleInput, PRSHistoryViewOutput>

@property (nonatomic, weak) id<PRSHistoryViewInput> view;

@end
