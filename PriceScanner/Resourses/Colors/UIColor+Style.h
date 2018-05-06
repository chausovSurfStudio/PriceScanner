//
//  UIColor+Style.h
//  PriceScanner
//
//  Created by Александр Чаусов on 05.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Style)

/** Основной цвет приложения */
+ (UIColor *)prsMainThemeColor;

/** Цвет неактивного элемента таббара */
+ (UIColor *)prsTabBarInactiveItemColor;

/** Более светлый цвет градиента в навбаре/таббаре */
+ (UIColor *)prsBarsGradientLightColor;

/** Более темный цвет градиента в навбаре/таббаре */
+ (UIColor *)prsBarsGradientDarkColor;

/** Темно-синий цвет текста */
+ (UIColor *)prsDarkBlueTextColor;

@end
