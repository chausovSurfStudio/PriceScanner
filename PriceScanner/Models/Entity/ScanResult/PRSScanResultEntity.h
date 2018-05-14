//
//  PRSScanResultEntity.h
//  PriceScanner
//
//  Created by Александр Чаусов on 07.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultEntry;


/** Сущность-обертка над сущностью Realm, хранящей информацию о результате сканирования */
@interface PRSScanResultEntity : NSObject

@property (nonatomic, strong, readonly) NSNumber *idx;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *price;
@property (nonatomic, strong, readonly) NSData *photoData;

- (instancetype)initWithName:(NSString *)name price:(NSString *)price photoData:(NSData *)photoData;
- (instancetype)initWithEntry:(PRSScanResultEntry *)entry;

@end
