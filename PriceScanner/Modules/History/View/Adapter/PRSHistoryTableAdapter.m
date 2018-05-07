//
//  PRSHistoryTableAdapter.m
//  PriceScanner
//
//  Created by Александр Чаусов on 08.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSHistoryTableAdapter.h"
#import "PRSHistoryTableViewCell.h"
#import "PRSHistoryTableCellModel.h"


static NSString * const cellIdentifier = @"historyTableCell";
static CGFloat const cellEstimatedHeight = 85.f;


@interface PRSHistoryTableAdapter() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray<PRSHistoryTableCellModel *> *models;
@property (nonatomic, weak) id<PRSHistoryTableAdapterDelegate> delegate;

@end


@implementation PRSHistoryTableAdapter

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<PRSHistoryTableAdapterDelegate>)delegate {
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.delegate = delegate;
        
        [self.tableView registerNib:[UINib nibWithNibName:@"PRSHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    return self;
}

#pragma mark - Interface Methods
- (void)configureWithModels:(NSArray<PRSHistoryTableCellModel *> *)models {
    self.models = models;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRSHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithModel:self.models[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellEstimatedHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PRSHistoryTableCellModel *model = self.models[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(tapOnModelWithId:)]) {
        [self.delegate tapOnModelWithId:model.idx];
    }
}

@end
