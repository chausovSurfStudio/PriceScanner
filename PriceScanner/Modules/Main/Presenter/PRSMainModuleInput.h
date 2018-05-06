//
//  PRSMainModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSMainModuleInput <NSObject>

/** Метод позволяет сконфигурировать модуль и указать блок перехода к модулю сканирования ценника */
- (void)configureWithOpenCameraModuleAction:(void(^)(void))openCameraModuleAction;

@end
