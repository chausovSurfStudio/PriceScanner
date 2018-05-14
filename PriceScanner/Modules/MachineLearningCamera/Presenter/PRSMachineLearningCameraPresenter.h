//
//  PRSMachineLearningCameraPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSMachineLearningCameraModuleInput.h"
#import "PRSMachineLearningCameraViewOutput.h"

@protocol PRSMachineLearningCameraViewInput;


@interface PRSMachineLearningCameraPresenter : PRSBasePresenter <PRSMachineLearningCameraModuleInput, PRSMachineLearningCameraViewOutput>

@property (nonatomic, weak) id<PRSMachineLearningCameraViewInput> view;

@end
