//
//  PRSScanPreviewPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanPreviewPresenter.h"
#import "PRSScanPreviewViewInput.h"

#import "PRSScanResultEntity.h"


@interface PRSScanPreviewPresenter()

@property (nonatomic, strong) PRSScanResultEntity *scanPreview;
@property (nonatomic, copy) void (^closeAction)(void);

@end


@implementation PRSScanPreviewPresenter

#pragma mark - PRSScanPreviewModuleInput
- (void)configureWithScanResult:(PRSScanResultEntity *)scanResultEntity closeAction:(void(^)(void))closeAction {
    self.scanPreview = scanResultEntity;
    self.closeAction = closeAction;
}

#pragma mark - PRSScanPreviewViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

@end
