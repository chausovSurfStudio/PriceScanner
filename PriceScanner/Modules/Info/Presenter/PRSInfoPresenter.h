//
//  PRSInfoPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSInfoModuleInput.h"
#import "PRSInfoViewOutput.h"

@protocol PRSInfoViewInput;


@interface PRSInfoPresenter : PRSBasePresenter <PRSInfoModuleInput, PRSInfoViewOutput>

@property (nonatomic, weak) id<PRSInfoViewInput> view;

@end
