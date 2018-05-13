//
//  PRSAlertViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSAlertViewController.h"
#import "PRSAlertViewOutput.h"

#import "UIButton+Style.h"
#import "UILabel+Additions.h"


@interface PRSAlertViewController ()

@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UIButton *agreeButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;

@end


@implementation PRSAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSAlertViewInput
- (void)setupInitialStateWithMessage:(NSString *)message {
    [self configureStyle];
    [self configureTitlesWithMessage:message];
}

#pragma mark - Configure
- (void)configureStyle {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    self.containerView.layer.cornerRadius = 10.f;
    self.containerView.layer.masksToBounds = YES;
    
    self.messageLabel.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightRegular];
    self.messageLabel.textColor = [UIColor prsBlackTextColor];
    
    [self.agreeButton setLightPinkStyle];
    [self.cancelButton setLightPinkStyle];
}

- (void)configureTitlesWithMessage:(NSString *)message {
    [self.messageLabel setText:message withLineSpacing:@(4.f) letterSpacing:nil];
    [self.agreeButton setTitle:@"Алерт_кнопка_да".localized forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"Алерт_кнопка_отмена".localized forState:UIControlStateNormal];
}

#pragma mark - Actions
- (IBAction)tapOnAgreeButton:(UIButton *)sender {
    [self.output agreeButtonDidTap];
}

- (IBAction)tapOnCancelButton:(id)sender {
    [self.output cancelButtonDidTap];
}

@end
