//
//  NSString+Additions.h
//  PriceScanner
//
//  Created by Александр Чаусов on 04.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Additions)

/** Возвращает локализованный вариант строки, в зависимости от текущей установленной локали устройства */
- (NSString *)localized;

/** Возвращает YES в случае, если строка string не равна nil и не пуста */
+ (BOOL)notEmpty:(NSString *)string;

@end
