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

- (void)tapOnModelWithId:(NSNumber *)modelId;

@end


@interface PRSHistoryTableAdapter : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<PRSHistoryTableAdapterDelegate>)delegate;
- (void)configureWithModels:(NSArray<PRSHistoryTableCellModel *> *)models;

@end
