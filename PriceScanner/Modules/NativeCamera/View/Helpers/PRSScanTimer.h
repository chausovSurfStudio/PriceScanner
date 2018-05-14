//
//  PRSScanTimer.h
//  PriceScanner
//
//  Created by Александр Чаусов on 14.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>


/** В данном перечислении объявлены возможные состояния таймера */
typedef NS_OPTIONS(NSUInteger, PRSScanTimerState) {
    /** Состояние выключенного таймера */
    PRSScanTimerStateDisable = 0,
    /** Состояние спящего таймера, в котором он находится по-умолчанию, переходит в активное спустя некоторое время */
    PRSScanTimerStateSleep,
    /** Состояние активного таймера, при переходе в это состояние должно осуществляться сохранение изображения с видеопотока */
    PRSScanTimerStateActive,
    /** Состояние таймера в процессе сканирования, в которое он должен переходить после сохранения изображения с видеопотока */
    PRSScanTimerStateScanning
};


/** Вспомогательный класс для процесса сканирования */
@interface PRSScanTimer : NSObject

/** Текущее состояния таймера */
@property (nonatomic, assign) PRSScanTimerState state;

@end
