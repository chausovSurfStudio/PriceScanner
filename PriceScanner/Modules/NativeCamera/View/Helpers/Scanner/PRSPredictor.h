//
//  PRSPredictor.h
//  PriceScanner
//
//  Created by Александр Чаусов on 21.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSSingleScanSession, PRSScannerPrediction;


/** Класс инкапсулирует внутри логику по вынесению предсказаний насчет названия и цены товара */
@interface PRSPredictor : NSObject

/** Возвращает предсказание - название товара - на основе всех сохраненных ранее результатов сканирования ценника */
- (PRSScannerPrediction *)predictNameWithSessions:(NSArray<PRSSingleScanSession *> *)sessions;
/** Возвращает предсказание - стоимость товара - на основе всех сохраненных ранее результатов сканирования ценника */
- (PRSScannerPrediction *)predictPriceWithSessions:(NSArray<PRSSingleScanSession *> *)sessions;

@end
