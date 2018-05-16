//
//  PRSScanner.h
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Vision/Vision.h>


/** Объект, инкапсулирующий в себе логику по обработке распознанных в видеопотоке символов */
@interface PRSScanner : NSObject

/** Метод отключение сканера. Вся сохраненная информация стирается */
- (void)disableScanner;
/** Метод для перевода сканера в состояние ожидания */
- (void)setupAwaitState;
/**
 * Метод для перевода сканера в активное состояние, в котором он способен правильно принимать и обрабатывать информацию.
 * В качестве параметра передается регион, внутри которого распознаны символы, информация о которых будет поступать в сканер в дальнейшем
 */
- (void)enableScannerWithRegion:(CGRect)region;

/** Данный метод следует вызывать непосредственно перед вызывом VNRequest'а, который будет обращаться к нейросети за предсказанием */
- (void)prepareForCharBoxScan:(VNRectangleObservation *)charBox;

/**
 * Метод для сохранения результата работы нейросети.
 * Предсказание и точность будут связаны с изображением, информация о котором была передана в предыдущем мтеоде (prepareForCharBoxScan:)
 */
- (void)completeCharBoxScanWithPrediction:(NSString *)prediction confidence:(CGFloat)confidence;

/** Возвращает прогресс процесса сканирования, значение от 0 до 1 включительно. 1 возвращается, когда процесс сканирования считается завершенным */
- (CGFloat)scanProgress;

@end
