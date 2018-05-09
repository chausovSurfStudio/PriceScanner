//
//  PRSHistoryTableAdapter.h
//  PriceScanner
//
//  Created by Александр Чаусов on 08.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSHistoryTableCellModel;


@protocol PRSHistoryTableAdapterDelegate <NSObject>

/** Метод информирует делегата о том, что был совершен тап по ячейке с моделью, id которой передается в качестве параметра */
- (void)tapOnModelWithId:(NSNumber *)modelId;

@end


/** Адаптер для таблицы на экране истории */
@interface PRSHistoryTableAdapter : NSObject

/** Конструктор позволяет передать UITableView, в которой будут отображаться данные, а также делегат для адаптера */
- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<PRSHistoryTableAdapterDelegate>)delegate;
/** Метод для конфигурации таблицы на экране истории, передается массив объектов, на основе которых будут заполняться ячейки */
- (void)configureWithModels:(NSArray<PRSHistoryTableCellModel *> *)models;

@end
