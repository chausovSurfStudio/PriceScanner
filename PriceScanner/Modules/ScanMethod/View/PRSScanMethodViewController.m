//
//  PRSScanMethodViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSScanMethodViewController.h"
#import "PRSScanMethodViewOutput.h"

#import "UIButton+Style.h"
#import "UILabel+Additions.h"


@interface PRSScanMethodViewController ()

@property (nonatomic, strong) IBOutlet UILabel *topDescriptionLabel;
@property (nonatomic, strong) IBOutlet UIImageView *targetImageView;
@property (nonatomic, strong) IBOutlet UILabel *bottomDescriptionLabel;

@property (nonatomic, strong) IBOutlet UIButton *nativeMethodButton;
@property (nonatomic, strong) IBOutlet UIButton *mlMethodButton;
@property (nonatomic, strong) IBOutlet UIButton *manualMethodButton;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *separators;

@end


@implementation PRSScanMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - PRSScanMethodViewInput
- (void)setupInitialState {
    [self configureNavigationBar];
    [self configureStyle];
    [self configureTexts];
}

#pragma mark - Configure
- (void)configureNavigationBar {
    [self.navigationItem setTitle:@"Способы сканирования".localized];
}

- (void)configureStyle {
    self.topDescriptionLabel.font = [UIFont systemFontOfSize:13.f weight:UIFontWeightRegular];
    self.topDescriptionLabel.textColor = [UIColor prsDarkBlueTextColor];
    
    self.bottomDescriptionLabel.font = [UIFont systemFontOfSize:11.f weight:UIFontWeightRegular];
    self.bottomDescriptionLabel.textColor = [UIColor prsBlackTextColor];
    
    self.targetImageView.image = [UIImage imageNamed:@"icTarget"];
    
    for (UIButton *button in @[self.nativeMethodButton, self.mlMethodButton, self.manualMethodButton]) {
        [button setPlainLeftAlignmentStyle];
    }
    
    for (UIView *separator in self.separators) {
        separator.backgroundColor = [UIColor prsSeparatorColor];
    }
    
    for (UIImageView *arrowImageView in self.arrows) {
        arrowImageView.image = [UIImage imageNamed:@"icRightArrow"];
    }
}

- (void)configureTexts {
    [self.topDescriptionLabel setText:@"Способы сканирования_описание".localized withLineSpacing:@(4.f) letterSpacing:nil];
    [self.bottomDescriptionLabel setText:@"Способы сканирования_предупреждение".localized withLineSpacing:@(3.f) letterSpacing:nil];
    
    [self.nativeMethodButton setTitle:@"Средствами iOS".localized forState:UIControlStateNormal];
    [self.mlMethodButton setTitle:@"С помощью машинного обучения".localized forState:UIControlStateNormal];
    [self.manualMethodButton setTitle:@"Ручное определение границы".localized forState:UIControlStateNormal];
}

#pragma mark - Actions
- (IBAction)tapOnNativeMethodButton:(UIButton *)sender {
    [self.output tapOnScanWithNativeMethod];
}

- (IBAction)tapOnMLMethodButton:(UIButton *)sender {
    [self.output tapOnScanWithMLMethod];
}

- (IBAction)tapOnManualMethodButton:(UIButton *)sender {
    [self.output tapOnScanWithManualMethod];
}

@end
