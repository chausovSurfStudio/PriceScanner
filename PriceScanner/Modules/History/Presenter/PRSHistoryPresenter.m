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

@property (nonatomic, copy) void (^openResultAction)(PRSScanResultEntity *scanResultEntity);
@property (nonatomic, copy) void (^openCameraModuleAction)(void);
@property (nonatomic, copy) void (^openAlertAction)(NSString *message);
@property (nonatomic, strong) NSArray<PRSScanResultEntity *> *scanResults;

@end


@implementation PRSHistoryPresenter

#pragma mark - PRSHistoryModuleInput
- (void)configureWithOpenResultAction:(void(^)(PRSScanResultEntity *scanResultEntity))openResultAction
               openCameraModuleAction:(void(^)(void))openCameraModuleAction
                      openAlertAction:(void(^)(NSString *message))openAlertAction {
    self.openResultAction = openResultAction;
    self.openCameraModuleAction = openCameraModuleAction;
    self.openAlertAction = openAlertAction;
}

#pragma mark - PRSHistoryViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)refreshData {
    if (!self.scanResults || self.scanResults.count == 0) {
        // лоадер показываем только в первую загрузку или если результатов пока нет
        [self.view showLoader];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.scanResults = [PRSStorageService getAllScanResults];
        NSMutableArray<PRSHistoryTableCellModel *> *models = [@[] mutableCopy];
        for (PRSScanResultEntity *entity in self.scanResults) {
            [models addObject:[[PRSHistoryTableCellModel alloc] initWithScanResultEntity:entity]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (models.count > 0) {
                [self.view updateWithModels:[models copy]];
            } else {
                [self.view setupEmptyState];
            }
            [self.view hideLoader];
        });
    });
}

- (void)openScanResultModuleForModelId:(NSNumber *)modelId {
    PRSScanResultEntity *selectedEntity = [self findScanResultById:modelId];
    if (selectedEntity && self.openResultAction) {
        self.openResultAction(selectedEntity);
    }
}

- (void)openCameraModule {
    if (self.openCameraModuleAction) {
        self.openCameraModuleAction();
    }
}

- (void)tapOnClearHistoryButton {
    if (self.openAlertAction) {
        self.openAlertAction(@"Вы уверены, что хотите очистить историю?".localized);
    }
}

#pragma mark - Private Methods
/** Метод ищет и возвращает сущность результата сканирования по id, в случае неудачи - вернется nil */
- (PRSScanResultEntity *)findScanResultById:(NSNumber *)modelId {
    __block PRSScanResultEntity *selectedEntity;
    [self.scanResults enumerateObjectsUsingBlock:^(PRSScanResultEntity * _Nonnull entity, NSUInteger idx, BOOL * _Nonnull stop) {
        if (entity.idx.integerValue == modelId.integerValue) {
            selectedEntity = entity;
            *stop = YES;
        }
    }];
    return selectedEntity;
}

@end
