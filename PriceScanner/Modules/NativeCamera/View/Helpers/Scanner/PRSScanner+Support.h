//
//  PRSScanner+Support.h
//  PriceScanner
//
//  Created by Александр Чаусов on 17.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanner.h"

@class PRSSingleScanSession, PRSScannerPrediction;


@interface PRSScanner (Support)

- (NSArray<PRSSingleScanSession *> *)selectSessionsForBuildingName:(NSArray<PRSSingleScanSession *> *)sessions;
- (NSArray<PRSSingleScanSession *> *)selectSessionsForBuildingPrice:(NSArray<PRSSingleScanSession *> *)sessions;
- (PRSScannerPrediction *)predictNameWithSessions:(NSArray<PRSSingleScanSession *> *)sessions;
- (PRSScannerPrediction *)predictPriceWithSessions:(NSArray<PRSSingleScanSession *> *)sessions;

@end
