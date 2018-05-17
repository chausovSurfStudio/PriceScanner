//
//  PRSNativeCameraModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultEntity;


@protocol PRSNativeCameraModuleInput <NSObject>

/** Метод позволяет сконфигурировать модуль и указать блок перехода к модулю с предпросмотром результатов сканирования */
- (void)configureWithOpenPreviewAction:(void(^)(PRSScanResultEntity *scanResultEntity))openPreviewAction;

@end
