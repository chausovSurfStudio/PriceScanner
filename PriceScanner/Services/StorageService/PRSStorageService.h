//
//  StorageService.h
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultEntity;


/** Сервис для работы с БД */
@interface PRSStorageService : NSObject

/** Метод позволяет добавить результат сканирования в базу данных */
+ (void)addNewScanResult:(PRSScanResultEntity *)entity;
/** Метод возвращает массив со всеми результатами прошлых сканирований, сохраненных в базе данных */
+ (NSArray<PRSScanResultEntity *> *)getAllScanResults;

@end
