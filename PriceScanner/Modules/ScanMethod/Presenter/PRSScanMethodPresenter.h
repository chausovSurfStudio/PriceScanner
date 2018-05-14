//
//  PRSScanMethodPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSScanMethodModuleInput.h"
#import "PRSScanMethodViewOutput.h"

@protocol PRSScanMethodViewInput;


@interface PRSScanMethodPresenter : PRSBasePresenter <PRSScanMethodModuleInput, PRSScanMethodViewOutput>

@property (nonatomic, weak) id<PRSScanMethodViewInput> view;

@end
