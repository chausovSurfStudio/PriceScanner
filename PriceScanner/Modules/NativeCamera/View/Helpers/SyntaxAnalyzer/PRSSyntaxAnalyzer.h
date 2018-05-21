//
//  PRSSyntaxAnalyzer.h
//  PriceScanner
//
//  Created by Александр Чаусов on 21.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PRSSyntaxAnalyzer : NSObject

/** Метод проводит синтаксический анализ строки, принимая ее как название товара, и возвращает отредактированный вариант */
- (NSString *)analyzeProductName:(NSString *)productName;

/** Метод проводит синтаксический анализ строки, принимая ее как цену товара, и возвращает отредактированный вариант */
- (NSString *)analyzeProductPrice:(NSString *)productPrice;

@end
