//
//  PRSScanSessions.h
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSCharDetectResult;


@interface PRSScanSessions : NSObject

- (void)clear;
- (void)startNewSession;
- (void)detectResult:(PRSCharDetectResult *)result;
- (NSString *)getLastPrediction;

@end
