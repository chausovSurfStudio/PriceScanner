//
//  PRSAlertPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSAlertModuleInput.h"
#import "PRSAlertViewOutput.h"

@protocol PRSAlertViewInput;


@interface PRSAlertPresenter : PRSBasePresenter <PRSAlertModuleInput, PRSAlertViewOutput>

@property (nonatomic, weak) id<PRSAlertViewInput> view;

@end
