//
//  ScanResultEntry.h
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Realm/Realm.h>

@class PRSScanResultEntity;


/** Realm сущность для хранения результата сканирования */
@interface PRSScanResultEntry : RLMObject

@property NSInteger idx;
@property NSString *name;
@property NSString *price;

- (instancetype)initWithName:(NSString *)name price:(NSString *)price idx:(NSInteger)idx;
- (instancetype)initWithEntity:(PRSScanResultEntity *)entity;

@end
