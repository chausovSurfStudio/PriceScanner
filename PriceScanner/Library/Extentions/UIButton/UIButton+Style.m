//
//  UIButton+Style.m
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "UIButton+Style.h"


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

@end
