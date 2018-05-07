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


@interface PRSHistoryViewController () <PRSHistoryTableAdapterDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
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
}

- (void)updateWithModels:(NSArray<PRSHistoryTableCellModel *> *)models {
    [self.adapter configureWithModels:models];
}

#pragma mark - Configure
- (void)configureNavigationBar {
    self.title = @"История".localized;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)configureAdapter {
    self.adapter = [[PRSHistoryTableAdapter alloc] initWithTableView:self.tableView delegate:self];
}

#pragma mark - PRSHistoryTableAdapterDelegate
- (void)tapOnModelWithId:(NSNumber *)modelId {
    [self.output openScanResultModuleForModelId:modelId];
}

@end
