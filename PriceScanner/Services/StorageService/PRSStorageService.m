//
//  StorageService.m
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSStorageService.h"

#import "PRSScanResultEntity.h"
#import "PRSScanResultEntry.h"

#import <Realm/Realm.h>


@implementation PRSStorageService

+ (void)addNewScanResult:(PRSScanResultEntity *)entity {
    PRSScanResultEntry *scanResult = [[PRSScanResultEntry alloc] initWithEntity:entity];
    if (!entity.idx) {
        scanResult.idx = [self getNextScanResultId];
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:scanResult];
    [realm commitWriteTransaction];
}

+ (NSArray<PRSScanResultEntity *> *)getAllScanResults {
    RLMResults<PRSScanResultEntry *> *scanResults = [PRSScanResultEntry allObjects];
    NSMutableArray<PRSScanResultEntity *> *results = [@[] mutableCopy];
    for (PRSScanResultEntry *scanResult in scanResults) {
        [results addObject:[[PRSScanResultEntity alloc] initWithEntry:scanResult]];
    }
    return [results copy];
}

#pragma mark - Private Methods
/** Метод возвращает следующий id объекта БД для сущности результата сканирования (возвращаемый id на один больше текущего максимального, либо равен единице) */
+ (NSInteger)getNextScanResultId {
    RLMResults<PRSScanResultEntry *> *scanResults = [PRSScanResultEntry allObjects];
    NSNumber *maxId = [scanResults maxOfProperty:@"idx"];
    return maxId ? [maxId integerValue] + 1 : 1;
}

@end
