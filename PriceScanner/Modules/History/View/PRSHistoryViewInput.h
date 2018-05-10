//
//  PRSHistoryViewInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSHistoryTableCellModel;


@protocol PRSHistoryViewInput <NSObject>

/** Установка начального состояния view */
- (void)setupInitialState;

/** Метод для обновления экрана истории переданным массивом моделей */
- (void)updateWithModels:(NSArray<PRSHistoryTableCellModel *> *)models;

/** Метод сообщает view о том, что необходимо отрисовать empty state экрана */
- (void)setupEmptyState;

@end
