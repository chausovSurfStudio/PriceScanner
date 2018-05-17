//
//  PRSScanPreviewPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSScanPreviewModuleInput.h"
#import "PRSScanPreviewViewOutput.h"

@protocol PRSScanPreviewViewInput;


@interface PRSScanPreviewPresenter : PRSBasePresenter <PRSScanPreviewModuleInput, PRSScanPreviewViewOutput>

@property (nonatomic, weak) id<PRSScanPreviewViewInput> view;

@end
