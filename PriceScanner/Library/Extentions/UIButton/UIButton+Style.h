//
//  UIButton+Style.h
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (Style)

/** Стиль кнопки с белым текстом и розовым бэкграундом */
- (void)setMainPinkStyle;

/** Стиль для розовой прямоугольной кнопки с белым текстом */
- (void)setRectanglePinkStyle;

/** Стиль для кнопки с розовым текстом */
- (void)setLightPinkStyle;

/** Стиль обычной кнопки с темным текстом, который выровнен по левому краю (и имеет небольшой отступ. По сути, данный стиль - имитация ячейки) */
- (void)setPlainLeftAlignmentStyle;

/** Стиль розовой круглой кнопки без текста */
- (void)setPinkRoundedStyle;

@end
