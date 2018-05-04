//
//  PRSScanResultPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSScanResultModuleInput.h"
#import "PRSScanResultViewOutput.h"

@protocol PRSScanResultViewInput;


@interface PRSScanResultPresenter : PRSBasePresenter <PRSScanResultModuleInput, PRSScanResultViewOutput>

@property (nonatomic, weak) id<PRSScanResultViewInput> view;

@end
