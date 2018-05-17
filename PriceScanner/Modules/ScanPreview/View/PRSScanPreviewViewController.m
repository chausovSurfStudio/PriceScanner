//
//  PRSScanPreviewViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanPreviewViewController.h"
#import "PRSScanPreviewViewOutput.h"

#import "PRSScanPreviewModel.h"

#import "UIButton+Style.h"
#import "UILabel+Additions.h"


@interface PRSScanPreviewViewController ()

@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) IBOutlet UIButton *closeButton;

@end


@implementation PRSScanPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSScanPreviewViewInput
- (void)setupInitialStateWithModel:(PRSScanPreviewModel *)model {
    [self configureStyle];
    [self configureTitlesWithModel:model];
}

#pragma mark - Configure
- (void)configureStyle {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    self.containerView.layer.cornerRadius = 10.f;
    self.containerView.layer.masksToBounds = YES;
    
    self.nameLabel.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightRegular];
    self.nameLabel.textColor = [UIColor prsBlackTextColor];
    
    self.priceLabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightBlack];
    self.priceLabel.textColor = [UIColor prsBlackTextColor];
    
    [self.saveButton setLightPinkStyle];
    [self.closeButton setLightPinkStyle];
}

- (void)configureTitlesWithModel:(PRSScanPreviewModel *)model {
    [self.nameLabel setText:model.name withLineSpacing:@(4.f) letterSpacing:nil];
    self.priceLabel.text = model.price;
    [self.saveButton setTitle:@"Preview_сохранить".localized forState:UIControlStateNormal];
    [self.closeButton setTitle:@"Preview_закрыть".localized forState:UIControlStateNormal];
}

#pragma mark - Actions
- (IBAction)tapOnSaveButton:(UIButton *)sender {
    [self.output saveScanResult];
}

- (IBAction)tapOnCloseButton:(id)sender {
    [self.output closeModule];
}

@end
