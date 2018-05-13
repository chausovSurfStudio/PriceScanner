//
//  PRSAlertViewInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSAlertViewInput <NSObject>

/** Установка начального состояния view */
- (void)setupInitialStateWithMessage:(NSString *)message;

@end
