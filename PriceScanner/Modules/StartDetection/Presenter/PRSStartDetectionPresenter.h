//
//  PRSStartDetectionPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSStartDetectionModuleInput.h"
#import "PRSStartDetectionViewOutput.h"

@protocol PRSStartDetectionViewInput;


@interface PRSStartDetectionPresenter : PRSBasePresenter <PRSStartDetectionModuleInput, PRSStartDetectionViewOutput>

@property (nonatomic, weak) id<PRSStartDetectionViewInput> view;

@end
