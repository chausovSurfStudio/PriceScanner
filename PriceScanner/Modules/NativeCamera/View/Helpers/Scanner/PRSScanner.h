//
//  PRSScanner.h
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Vision/Vision.h>


/** В данном перечислении объявлены возможные состояния сканера */
typedef NS_OPTIONS(NSUInteger, PRSScannerState) {
    /** Состояние выключенного сканера */
    PRSScannerStateDisable = 0,
    /** Состояние сканера в процессе ожидания входных данных */
    PRSScannerStateAwait,
    /** Состояние активного сканера */
    PRSScannerStateActive
};


/** Объект, инкапсулирующий в себе логику по обработке распознанных в видеопотоке символов */
@interface PRSScanner : NSObject

/**
 * Сканер следует переводить в отключенное состояние при уходе с экрана (в этом состоянии вся сохраненная информация стирается)
 * При переводе в активное состояние - создается новая сессия, результаты распознавания будут сохраняться в нее
 */
@property (nonatomic, assign) PRSScannerState state;

/** Данный метод следует вызывать непосредственно перед вызывом VNRequest'а, который будет обращаться к нейросети за предсказанием */
- (void)prepareForCharBoxScan:(VNRectangleObservation *)charBox;

/**
 * Метод для сохранения результата работы нейросети.
 * Предсказание и точность будут связаны с изображением, информация о котором была передана в предыдущем мтеоде (prepareForCharBoxScan:)
 */
- (void)completeCharBoxScanWithPrediction:(NSString *)prediction confidence:(CGFloat)confidence;

@end
