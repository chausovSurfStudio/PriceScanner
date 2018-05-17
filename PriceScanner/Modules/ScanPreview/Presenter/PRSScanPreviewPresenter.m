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
#import "PRSScanPreviewModel.h"
#import "PRSStorageService.h"


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
    [self.view setupInitialStateWithModel:[[PRSScanPreviewModel alloc] initWithEntity:self.scanPreview]];
}

- (void)saveScanResult {
    [PRSStorageService addNewScanResult:self.scanPreview];
    if (self.closeAction) {
        self.closeAction();
    }
}

- (void)closeModule {
    if (self.closeAction) {
        self.closeAction();
    }
}

@end
