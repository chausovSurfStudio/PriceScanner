//
//  PRSHistoryEmptyView.m
//  PriceScanner
//
//  Created by Александр Чаусов on 10.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSHistoryEmptyView.h"

#import "UIButton+Style.h"
#import "UILabel+Additions.h"


@interface PRSHistoryEmptyView()

@property (nonatomic, strong) IBOutlet UIImageView *emptyIconImageView;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UIButton *actionButton;

@end


@implementation PRSHistoryEmptyView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureStyle];
    [self configureContent];
}

#pragma mark - Configure
- (void)configureStyle {
    self.descriptionLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    self.descriptionLabel.textColor = [UIColor prsDarkBlueTextColor];
    
    [self.actionButton setMainPinkStyle];
}

- (void)configureContent {
    self.emptyIconImageView.image = [UIImage imageNamed:@"icCatInBox"];
    [self.descriptionLabel setText:@"EmptyView_текст".localized withLineSpacing:@(4.f) letterSpacing:nil];
    [self.actionButton setTitle:@"EmptyView_заголовок_кнопки".localized forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)tapOnActionButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(emptyViewActionButtonDidTap)]) {
        [self.delegate emptyViewActionButtonDidTap];
    }
}

@end
