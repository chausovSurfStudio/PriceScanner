//
//  PRSCharDetectResult.h
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Vision/Vision.h>


/** Вспомогательный объект, необходим для связывания между собой информации о распознанном в видеопотоке изображении и результате работы нейросети */
@interface PRSCharDetectResult : NSObject

@property (nonatomic, strong) VNRectangleObservation *charBox;
@property (nonatomic, strong) NSString *prediction;
@property (nonatomic, assign) CGFloat confidence;

/** Возвращает YES, если все поля объекта заполнены и заполнены корректно, NO в противном случае */
- (BOOL)isCorrectlyFilled;

@end
