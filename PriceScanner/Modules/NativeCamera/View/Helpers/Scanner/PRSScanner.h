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


@interface PRSScanner : NSObject

@property (nonatomic, assign) PRSScannerState state;

- (void)prepareForCharBoxScan:(VNRectangleObservation *)charBox;
- (void)completeCharBoxScanWithPrediction:(NSString *)prediction confidence:(CGFloat)confidence;

@end
