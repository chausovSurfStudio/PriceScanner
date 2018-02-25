//
//  InfoPresenter.h
//  PriceScanner
//
//  Created by Chausov Alexander on 25.02.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSBasePresenter.h"
#import "InfoModuleInput.h"
#import "InfoViewOutput.h"

@protocol InfoViewInput;

@interface InfoPresenter : PRSBasePresenter <InfoModuleInput, InfoViewOutput>

@property (nonatomic, weak) id<InfoViewInput> view;

@end
