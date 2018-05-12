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
#import "PRSLoaderView.h"


static CGFloat const loaderHidingAnimationDuration = 0.3f;


@interface PRSHistoryViewController () <PRSHistoryTableAdapterDelegate, PRSHistoryEmptyViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet PRSHistoryEmptyView *emptyView;
@property (nonatomic, strong) IBOutlet PRSLoaderView *loaderView;
@property (nonatomic, strong) PRSHistoryTableAdapter *adapter;

@end


@implementation PRSHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output refreshData];
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

- (void)showLoader {
    self.loaderView.alpha = 1.f;
    self.loaderView.hidden = NO;
    [self.loaderView startAnimating];
}

- (void)hideLoader {
    [UIView animateWithDuration:loaderHidingAnimationDuration
                     animations:^{
                         self.loaderView.alpha = 0.f;
                     } completion:^(BOOL finished) {
                         self.loaderView.hidden = YES;
                         [self.loaderView stopAnimating];
                     }];
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
