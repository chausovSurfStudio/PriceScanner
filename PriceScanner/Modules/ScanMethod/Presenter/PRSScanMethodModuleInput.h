//
//  PRSScanMethodModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSScanMethodModuleInput <NSObject>

/** Метод позволяет сконфигурировать модуль и указать блоки перехода к другим экранам
 *
 * @param openIosCameraModuleAction Блок кода, будет вызываться при необходимости перейти на экран камеры с определением границ ценника средствами ios
 * @param openMachineLearningCameraModuleAction Блок кода, будет вызываться при необходимости перейти на экран камеры с определением границ ценника средствами ML
 * @param openManualCameraModuleAction Блок кода, будет вызываться при необходимости перейти на экран камеры с определением границ ценника вручную
 *
 */
- (void)configureWithOpenIosCameraModuleAction:(void(^)(void))openIosCameraModuleAction
         openMachineLearningCameraModuleAction:(void(^)(void))openMachineLearningCameraModuleAction
                  openManualCameraModuleAction:(void(^)(void))openManualCameraModuleAction;

@end
