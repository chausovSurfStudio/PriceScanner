//
//  PRSHistoryModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultEntity;


@protocol PRSHistoryModuleInput <NSObject>

/** Метод позволяет сконфигурировать модуль, определив логику перехода на соседние экраны.
 *
 * @param openResultAction Блок кода, будет вызываться при необходимости перейти на экран результата сканирования
 * @param openCameraModuleAction Блок кода, будет вызываться при необходимости перейти на экран сканирования
 * @param openAlertAction Блок кода, будет вызываться при необходимости открыть модуль с кастомным алертом
 *
 */
- (void)configureWithOpenResultAction:(void(^)(PRSScanResultEntity *scanResultEntity))openResultAction
               openCameraModuleAction:(void(^)(void))openCameraModuleAction
                      openAlertAction:(void(^)(NSString *message))openAlertAction;

@end
