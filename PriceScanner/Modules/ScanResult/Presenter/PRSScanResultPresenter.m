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
#import "PRSScanResultViewModel.h"


@interface PRSScanResultPresenter()

@property (nonatomic, strong) PRSScanResultEntity *scanResult;

@end


@implementation PRSScanResultPresenter

#pragma mark - PRSScanResultModuleInput
- (void)configureWithScanResult:(PRSScanResultEntity *)scanResultEntity {
    self.scanResult = scanResultEntity;
}

#pragma mark - PRSScanResultViewOutput
- (void)viewLoaded {
    [self.view setupInitialStateWithScanResult:[[PRSScanResultViewModel alloc] initWithEntity:self.scanResult]];
}

@end
