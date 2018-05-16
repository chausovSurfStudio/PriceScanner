//
//  PRSScanSessionManager.h
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSCharDetectResult;


/** Объект инкапсулирует в себе логику по хранению и управлению результатами распознавания, полученными в различных сессиях */
@interface PRSScanSessionManager : NSObject

/** Вызов метода приведет к удалению всех результатов сканирования */
- (void)clear;
/** Вызов метода приводят к созданию новой сессии, результаты распознавания будут сохраняться в дальнейшем именно в нее */
- (void)startNewSessionInRegion:(CGRect)region;
/** Метод для сохранения информации о распознанном символе */
- (void)detectResult:(PRSCharDetectResult *)result;
/** Метод возвращает строку, которая получилась в результате распознавания в рамках последней сессии */
- (NSString *)getLastPrediction;

@end
