//
//  PRSScanResultViewInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultViewModel;


@protocol PRSScanResultViewInput <NSObject>

/** Установка начального состояния view
 *
 * @param isModalState Передается YES, если модуль отображается в качестве модального экрана, NO в противном случае.
 * @param scanResult Сущность результата сканирования, которую необходимо отобразить на экране.
 *
 */
- (void)setupInitialState:(BOOL)isModalState scanResult:(PRSScanResultViewModel *)scanResult;

@end
