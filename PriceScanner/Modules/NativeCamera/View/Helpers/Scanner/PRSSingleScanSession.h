//
//  PRSSingleScanSession.h
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSCharDetectResult;


/** Объект инкапсулирует в себе логику по хранению и обработке результатов распознавания символов в рамках одной сессии */
@interface PRSSingleScanSession : NSObject

/** Конструктор позволяет указать прямоугольник, в рамках которого производится распознавание текста */
- (instancetype)initWithRegion:(CGRect)region;

/** Метод для сохранения информации о распознанном символе */
- (void)detectResult:(PRSCharDetectResult *)result;
/** Метод возвращает строку, которая получилась в результате распознавания в рамках данной сессии */
- (NSString *)getPrediction;

@end
