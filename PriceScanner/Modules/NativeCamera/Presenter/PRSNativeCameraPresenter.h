//
//  PRSNativeCameraPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "PRSNativeCameraModuleInput.h"
#import "PRSNativeCameraViewOutput.h"

@protocol PRSNativeCameraViewInput;


@interface PRSNativeCameraPresenter : PRSBasePresenter <PRSNativeCameraModuleInput, PRSNativeCameraViewOutput>

@property (nonatomic, weak) id<PRSNativeCameraViewInput> view;

@end
