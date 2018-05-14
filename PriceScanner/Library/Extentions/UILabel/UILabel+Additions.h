//
//  UILabel+Additions.h
//  PriceScanner
//
//  Created by Александр Чаусов on 09.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (Additions)

/** Метод для установки текста в лейбл с кастомными параметрами
 *
 * @param text Текст, который должен быть установлен в лейбл. При передаче nil - будет установлена пустая строка.
 * @param lineSpacing Величина межстрочного расстояния. При передаче nil - будет установлено значение по-умолчанию.
 * @param letterSpacing Величина межбуквенного расстояния. При передаче nil - будет установлено значение по-умолчанию.
 *
 */
- (void)setText:(NSString *)text withLineSpacing:(NSNumber *)lineSpacing letterSpacing:(NSNumber *)letterSpacing;

@end
