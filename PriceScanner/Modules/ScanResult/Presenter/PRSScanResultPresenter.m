//
//  PRSScanResultPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanResultPresenter.h"
#import "PRSScanResultViewInput.h"

#import "PRSScanResultEntity.h"


@interface PRSScanResultPresenter()

@property (nonatomic, strong) PRSScanResultEntity *scanResult;
@property (nonatomic, assign) BOOL showAsModal;
@property (nonatomic, copy) void (^closeAction)(void);

@end


@implementation PRSScanResultPresenter

#pragma mark - PRSScanResultModuleInput
- (void)configureWithScanResult:(PRSScanResultEntity *)scanResultEntity {
    self.scanResult = scanResultEntity;
}

- (void)configureAsModalWithCloseAction:(void(^)(void))closeAction {
    self.showAsModal = YES;
    self.closeAction = closeAction;
}

#pragma mark - PRSScanResultViewOutput
- (void)viewLoaded {
    [self.view setupInitialState:self.showAsModal];
}

- (void)closeModule {
    if (self.closeAction) {
        self.closeAction();
    }
}

@end
