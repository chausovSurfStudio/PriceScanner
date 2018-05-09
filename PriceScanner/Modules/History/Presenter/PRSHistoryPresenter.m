//
//  PRSHistoryPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSHistoryPresenter.h"
#import "PRSHistoryViewInput.h"

#import "PRSStorageService.h"
#import "PRSScanResultEntity.h"
#import "PRSHistoryTableCellModel.h"


@interface PRSHistoryPresenter()

@property (nonatomic, copy) void (^openResultAction)(void);

@end


@implementation PRSHistoryPresenter

#pragma mark - PRSHistoryModuleInput
- (void)configureWithOpenResultAction:(void(^)(void))openResultAction {
    self.openResultAction = openResultAction;
}

#pragma mark - PRSHistoryViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)viewReadyToAppear {
    NSArray<PRSScanResultEntity *> *scanResults = [PRSStorageService getAllScanResults];
    NSMutableArray<PRSHistoryTableCellModel *> *models = [@[] mutableCopy];
    for (PRSScanResultEntity *entity in scanResults) {
        [models addObject:[[PRSHistoryTableCellModel alloc] initWithScanResultEntity:entity]];
    }
    [self.view updateWithModels:[models copy]];
}

- (void)openScanResultModuleForModelId:(NSNumber *)modelId {
    if (self.openResultAction) {
        self.openResultAction();
    }
}

@end
