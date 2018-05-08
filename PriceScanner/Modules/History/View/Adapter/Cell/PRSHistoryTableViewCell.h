//
//  PRSHistoryTableViewCell.h
//  PriceScanner
//
//  Created by Александр Чаусов on 07.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRSHistoryTableCellModel;


/** Яячейка для таблицы на экране истории */
@interface PRSHistoryTableViewCell : UITableViewCell

/** Метод позволяет сконфигурировать ячейку на основе данных из переданной модели */
- (void)configureWithModel:(PRSHistoryTableCellModel *)model;

@end
