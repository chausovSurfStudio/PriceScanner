//
//  StartDetectionPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "StartDetectionModuleInput.h"
#import "StartDetectionViewOutput.h"

@protocol StartDetectionViewInput;

@interface StartDetectionPresenter : PRSBasePresenter <StartDetectionModuleInput, StartDetectionViewOutput>

@property (nonatomic, weak) id<StartDetectionViewInput> view;

@end
