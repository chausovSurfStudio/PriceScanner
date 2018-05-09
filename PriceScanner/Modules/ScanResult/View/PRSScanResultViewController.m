//
//  PRSScanResultViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanResultViewController.h"
#import "PRSScanResultViewOutput.h"


@interface PRSScanResultViewController ()

@property (nonatomic, strong) IBOutlet UILabel *photoTitleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *photoImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *nameValueLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceValueLabel;

@end


@implementation PRSScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSScanResultViewInput
- (void)setupInitialState:(BOOL)isModalState {
    [self configureNavigationBar];
    if (isModalState) {
        [self configureCloseModuleButton];
    }
    [self configureStyle];
    [self configureLocalizedTexts];
}

#pragma mark - Configure
- (void)configureNavigationBar {
    self.title = @"Результаты сканирования".localized;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)configureCloseModuleButton {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.tintColor = [UIColor prsMainThemeColor];
    closeButton.frame = CGRectMake(0, 0, 44, 44);
    [closeButton setImage:[UIImage imageNamed:@"icClose"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(tapOnCloseButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.rightBarButtonItem = closeItem;
}

- (void)configureStyle {
    self.photoTitleLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
    self.nameTitleLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
    self.priceTitleLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
    self.nameValueLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightLight];
    self.priceValueLabel.font = [UIFont systemFontOfSize:24.f weight:UIFontWeightBlack];
    
    self.photoTitleLabel.textColor = [UIColor prsDarkBlueTextColor];
    self.nameTitleLabel.textColor = [UIColor prsDarkBlueTextColor];
    self.priceTitleLabel.textColor = [UIColor prsDarkBlueTextColor];
    self.nameValueLabel.textColor = [UIColor prsBlackTextColor];
    self.priceValueLabel.textColor = [UIColor prsBlackTextColor];
}

- (void)configureLocalizedTexts {
    self.photoTitleLabel.text = @"Фотография ценника".localized;
    self.nameTitleLabel.text = @"Название товара".localized;
    self.priceTitleLabel.text = @"Цена".localized;
}

#pragma mark - Actions
- (void)tapOnCloseButton {
    [self.output closeModule];
}

@end
