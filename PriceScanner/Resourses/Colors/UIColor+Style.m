//
//  UIColor+Style.m
//  PriceScanner
//
//  Created by Александр Чаусов on 05.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "UIColor+Style.h"


@implementation UIColor (Style)

+ (UIColor *)prsMainThemeColor {
    return [UIColor colorWithRed: 233 / 255.0 green: 40 / 255.0 blue: 86 / 255.0 alpha: 1.0];
}

+ (UIColor *)prsTabBarInactiveItemColor {
    return [UIColor colorWithRed: 67 / 255.0 green: 67 / 255.0 blue: 67 / 255.0 alpha: 1.0];
}

+ (UIColor *)prsBarsGradientLightColor {
    return [UIColor colorWithRed: 200 / 255.0 green: 0 / 255.0 blue: 141 / 255.0 alpha: 1.0];
}

+ (UIColor *)prsBarsGradientDarkColor {
    return [UIColor colorWithRed: 223 / 255.0 green: 37 / 255.0 blue: 87 / 255.0 alpha: 1.0];
}

@end
