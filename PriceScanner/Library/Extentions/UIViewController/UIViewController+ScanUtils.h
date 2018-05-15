//
//  UIViewController+ScanUtils.h
//  PriceScanner
//
//  Created by Александр Чаусов on 14.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VNTextObservation, VNRectangleObservation;


/** Support-методы viewController'a для работы с распознанными в видеопотоке символами и словами */
@interface UIViewController (ScanUtils)

/** Метод выделяет в текущем видеопотоке границу распознанного слова */
- (void)highlightWord:(VNTextObservation *)word inScene:(UIImageView *)scene;

/** Метод выделяет в текущем видеопотоке границу распознанного символа */
- (void)highlightLetter:(VNRectangleObservation *)letter inScene:(UIImageView *)scene;

/** Метод выделяет в текущем видеопотоке границу распознанного прямоугольника */
- (void)highlightRect:(VNRectangleObservation *)rect inScene:(UIImageView *)scene;

/** Метод возвращает изображение конкретного символа, вырезанного из видеопотока */
- (UIImage *)cropLetter:(VNRectangleObservation *)letter fromImage:(UIImage *)image;

/** Возвращает прямоугольник, характеризующий положение rectObservation относительно текущего видеопотока (фактически - regionOfInterest для request'а на распознавание символов) */
- (CGRect)regionOfInterestFromRectObservation:(VNRectangleObservation *)rectObservation;

@end
