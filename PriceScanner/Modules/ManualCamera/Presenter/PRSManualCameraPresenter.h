//
//  PRSManualCameraPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSManualCameraModuleInput.h"
#import "PRSManualCameraViewOutput.h"

@protocol PRSManualCameraViewInput;


@interface PRSManualCameraPresenter : PRSBasePresenter <PRSManualCameraModuleInput, PRSManualCameraViewOutput>

@property (nonatomic, weak) id<PRSManualCameraViewInput> view;

@end
