//
//  PRSMainCarouselCell.m
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSMainCarouselCell.h"
#import "PRSMainCarouselPageModel.h"

#import "UIButton+Style.h"


static CGFloat const buttonContainerDefaultHeight = 80.f;


@interface PRSMainCarouselCell()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) IBOutlet UIButton *actionButton;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *buttonContainerHeightConstraint;

@end


@implementation PRSMainCarouselCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureStyle];
}

#pragma mark - Interface Methods
- (void)configureWithModel:(PRSMainCarouselPageModel *)model {
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.subtitle;
    self.iconImageView.image = model.image;
    [self.actionButton setTitle:model.actionButtonTitle forState:UIControlStateNormal];
    
    BOOL showActionButton = [NSString notEmpty:model.actionButtonTitle];
    self.buttonContainerHeightConstraint.constant = showActionButton ? buttonContainerDefaultHeight : 0.f;
    self.actionButton.hidden = !showActionButton;
}

#pragma mark - Actions
- (IBAction)tapOnActionButton:(UIButton *)sender {
    if ([self.cellDelegate respondsToSelector:@selector(actionButtonDidTap)]) {
        [self.cellDelegate actionButtonDidTap];
    }
}

#pragma mark - Configure
- (void)configureStyle {
    self.titleLabel.font = [UIFont systemFontOfSize:20.f weight:UIFontWeightBlack];
    self.titleLabel.textColor = [UIColor prsMainThemeColor];
    
    self.subtitleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
    self.subtitleLabel.textColor = [UIColor prsDarkBlueTextColor];
    
    [self.actionButton setMainPinkStyle];
}

@end
