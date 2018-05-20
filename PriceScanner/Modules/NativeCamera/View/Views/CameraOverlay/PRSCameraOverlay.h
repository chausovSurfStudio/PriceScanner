//
//  PRSCameraOverlay.h
//  PriceScanner
//
//  Created by Александр Чаусов on 29.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSDesignableView.h"


/** В данном перечислении объявлены состояния оверлея для экрана камеры */
typedef NS_OPTIONS(NSUInteger, PRSCameraOverlayState) {
    /** Состояние нективного оверлея, в котором он находится по-умолчанию */
    PRSCameraOverlayStateWaiting = 0,
    /** Состояние активного оверлея, "уголки" в нем обычно имеют другой цвет */
    PRSCameraOverlayStateActive
};


@protocol PRSCameraOverlayDelegate <NSObject>

/** Метод вызывается при изменении границ на оверлее вручную */
- (void)borderDidChange:(CGRect)borderRect;

@end


@interface PRSCameraOverlay : PRSDesignableView

@property (nonatomic, weak) id<PRSCameraOverlayDelegate> delegate;

/** Текущее состояния оверлея, при изменении - "уголки" будут анимированно менять цвет */
@property (nonatomic, assign) PRSCameraOverlayState state;
/** Значение от 0 до 1, характеризует текущий прогресс некоего действия. При установке чего-то вне границ [0,1] - будет выставлено ближайшее граничное значение*/
@property (nonatomic, assign) CGFloat progress;

/** Метод позволяет включить или выключить ручной режим изменений границы оверлея */
- (void)enableManualMode:(BOOL)enable;

@end
