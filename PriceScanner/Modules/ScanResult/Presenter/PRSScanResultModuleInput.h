//
//  PRSScanResultModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultEntity;


@protocol PRSScanResultModuleInput <NSObject>

/** Метод позволяет передать в модуль сущность результата сканирования, которую необходимо отобразить на экране */
- (void)configureWithScanResult:(PRSScanResultEntity *)scanResultEntity;

/** Метод позволяет сконфигурировать модуль под показ в качестве модального окна и указать блок закрытия модуля */
- (void)configureAsModalWithCloseAction:(void(^)(void))closeAction;

@end
