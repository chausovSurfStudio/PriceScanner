//
//  PRSHistoryTableViewCell.h
//  PriceScanner
//
//  Created by Александр Чаусов on 07.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRSHistoryTableCellModel;


@interface PRSHistoryTableViewCell : UITableViewCell

- (void)configureWithModel:(PRSHistoryTableCellModel *)model;

@end
