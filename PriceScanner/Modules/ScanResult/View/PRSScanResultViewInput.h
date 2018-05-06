//
//  PRSScanResultViewInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSScanResultViewInput <NSObject>

/** Установка начального состояния view, isModalState == YES, если модуль отображается в качетстве модального экрана */
- (void)setupInitialState:(BOOL)isModalState;

@end
