//
//  PRSHistoryViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSHistoryViewController.h"
#import "PRSHistoryViewOutput.h"

#import "PRSHistoryTableAdapter.h"
#import "PRSHistoryEmptyView.h"


@interface PRSHistoryViewController () <PRSHistoryTableAdapterDelegate, PRSHistoryEmptyViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet PRSHistoryEmptyView *emptyView;
@property (nonatomic, strong) PRSHistoryTableAdapter *adapter;

@end


@implementation PRSHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewReadyToAppear];
}

#pragma mark - PRSHistoryViewInput
- (void)setupInitialState {
    [self configureNavigationBar];
    [self configureAdapter];
    [self configureEmptyView];
}

- (void)updateWithModels:(NSArray<PRSHistoryTableCellModel *> *)models {
    self.tableView.hidden = NO;
    self.emptyView.hidden = YES;
    [self.adapter configureWithModels:models];
}

- (void)setupEmptyState {
    self.tableView.hidden = YES;
    self.emptyView.hidden = NO;
}

#pragma mark - Configure
- (void)configureNavigationBar {
    self.title = @"История".localized;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)configureAdapter {
    self.adapter = [[PRSHistoryTableAdapter alloc] initWithTableView:self.tableView delegate:self];
}

- (void)configureEmptyView {
    self.emptyView.delegate = self;
}

#pragma mark - PRSHistoryTableAdapterDelegate
- (void)tapOnModelWithId:(NSNumber *)modelId {
    [self.output openScanResultModuleForModelId:modelId];
}

#pragma mark - PRSHistoryEmptyViewDelegate
- (void)emptyViewActionButtonDidTap {
    [self.output openCameraModule];
}

@end
