//
//  PRSMainPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSMainModuleInput.h"
#import "PRSMainViewOutput.h"

@protocol PRSMainViewInput;


@interface PRSMainPresenter : PRSBasePresenter <PRSMainModuleInput, PRSMainViewOutput>

@property (nonatomic, weak) id<PRSMainViewInput> view;

@end
