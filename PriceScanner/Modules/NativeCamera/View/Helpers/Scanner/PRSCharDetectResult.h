//
//  PRSCharDetectResult.h
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Vision/Vision.h>


@interface PRSCharDetectResult : NSObject

@property (nonatomic, strong) VNRectangleObservation *charBox;
@property (nonatomic, strong) NSString *prediction;
@property (nonatomic, assign) CGFloat confidence;

- (BOOL)isCorrectlyFilled;

@end
