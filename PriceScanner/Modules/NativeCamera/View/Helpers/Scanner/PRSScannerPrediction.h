//
//  PRSScannerPrediction.h
//  PriceScanner
//
//  Created by Александр Чаусов on 17.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>


/** Небольшой объект, хранящий информацию о распознанной строке и значение уверенности (от 0 до 1) в этом предсказании */
@interface PRSScannerPrediction : NSObject

@property (nonatomic, assign, readonly) CGFloat confidence;
@property (nonatomic, strong, readonly) NSString *prediction;

- (instancetype)initWithConfidence:(CGFloat)confidence prediction:(NSString *)prediction;

@end
