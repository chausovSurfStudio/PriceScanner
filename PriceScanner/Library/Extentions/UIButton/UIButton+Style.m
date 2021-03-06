//
//  UIButton+Style.m
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "UIButton+Style.h"
#import "UIImage+Additions.h"


@implementation UIButton (Style)

- (void)setMainPinkStyle {
    [self setBackgroundColor:[UIColor prsMainThemeColor]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightLight]];
    
    self.layer.cornerRadius = self.bounds.size.height / 2.f;
    self.clipsToBounds = YES;
}

- (void)setRectanglePinkStyle {
    [self setBackgroundColor:[UIColor prsMainThemeColor]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightLight]];
    
    self.layer.cornerRadius = 4.f;
    self.clipsToBounds = YES;
}

- (void)setLightPinkStyle {
    [self setTitleColor:[UIColor prsMainThemeColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightLight]];
}

- (void)setPlainLeftAlignmentStyle {
    [self setTitleColor:[UIColor prsBlackTextColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]];
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 16.f, 0.f, 0.f)];
}

- (void)setPinkRoundedStyle {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor prsMainThemeColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[[UIColor prsMainThemeColor] colorWithAlphaComponent:0.85f]] forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageWithColor:[[UIColor prsMainThemeColor] colorWithAlphaComponent:0.85f]] forState:UIControlStateHighlighted];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.layer.masksToBounds = YES;
}

@end
