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
 * @param openNativeCameraModuleAction Блок кода, будет вызываться при необходимости перейти на экран камеры с определением границ ценника средствами ios
 * @param openMLCameraModuleAction Блок кода, будет вызываться при необходимости перейти на экран камеры с определением границ ценника средствами ML
 * @param openManualCameraModuleAction Блок кода, будет вызываться при необходимости перейти на экран камеры с определением границ ценника вручную
 *
 */
- (void)configureWithOpenNativeCameraModuleAction:(void(^)(void))openNativeCameraModuleAction
                         openMLCameraModuleAction:(void(^)(void))openMLCameraModuleAction
                     openManualCameraModuleAction:(void(^)(void))openManualCameraModuleAction;

@end
