//
//  PRSScanPreviewModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultEntity;


@protocol PRSScanPreviewModuleInput <NSObject>

/** Метод позволяет передать в модуль сущность результата сканирования, которую необходимо отобразить на экране */
- (void)configureWithScanResult:(PRSScanResultEntity *)scanResultEntity closeAction:(void(^)(void))closeAction;

@end
