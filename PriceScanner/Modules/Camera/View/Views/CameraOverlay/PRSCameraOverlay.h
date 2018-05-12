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


@interface PRSCameraOverlay : PRSDesignableView

@property (nonatomic, assign) PRSCameraOverlayState state;
@property (nonatomic, assign) CGFloat scanPercent;

@end
