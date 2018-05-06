//
//  PRSCameraPresenter.h
//  PriceScanner
//
//  Created by Alexander Chausov on 28/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSCameraModuleInput.h"
#import "PRSCameraViewOutput.h"

@protocol PRSCameraViewInput;


@interface PRSCameraPresenter : PRSBasePresenter <PRSCameraModuleInput, PRSCameraViewOutput>

@property (nonatomic, weak) id<PRSCameraViewInput> view;

@end
