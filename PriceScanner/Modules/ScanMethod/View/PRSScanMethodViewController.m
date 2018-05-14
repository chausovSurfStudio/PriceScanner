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

@property (nonatomic, strong) IBOutlet UIButton *iosMethodButton;
@property (nonatomic, strong) IBOutlet UIButton *machineLearningMethodButton;
@property (nonatomic, strong) IBOutlet UIButton *manualMethodButton;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *separators;

@end


@implementation PRSScanMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
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
    
    for (UIButton *button in @[self.iosMethodButton, self.machineLearningMethodButton, self.manualMethodButton]) {
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
    
    [self.iosMethodButton setTitle:@"Средствами iOS".localized forState:UIControlStateNormal];
    [self.machineLearningMethodButton setTitle:@"С помощью машинного обучения".localized forState:UIControlStateNormal];
    [self.manualMethodButton setTitle:@"Ручное определение границы".localized forState:UIControlStateNormal];
}

@end
