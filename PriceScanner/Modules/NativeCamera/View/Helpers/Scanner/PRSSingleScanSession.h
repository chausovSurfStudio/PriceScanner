//
//  PRSSingleScanSession.h
//  PriceScanner
//
//  Created by Александр Чаусов on 15.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSCharDetectResult;


@interface PRSSingleScanSession : NSObject

- (void)detectResult:(PRSCharDetectResult *)result;
- (NSString *)getPrediction;

@end
