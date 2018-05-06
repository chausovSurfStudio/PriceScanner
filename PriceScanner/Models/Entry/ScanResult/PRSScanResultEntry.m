//
//  ScanResultEntry.m
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanResultEntry.h"
#import "PRSScanResultEntity.h"


@implementation PRSScanResultEntry

- (instancetype)initWithName:(NSString *)name price:(NSString *)price idx:(NSInteger)idx {
    self = [super init];
    if (self) {
        self.name = name;
        self.price = price;
        self.idx = idx;
    }
    return self;
}

- (instancetype)initWithEntity:(PRSScanResultEntity *)entity {
    self = [super init];
    if (self) {
        self.name = entity.name;
        self.price = entity.price;
        self.idx = entity.idx ? entity.idx.integerValue : 0;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Scan result with idx %ld, name = %@, price = %@", self.idx, self.name, self.price];
}

#pragma mark - Override Realm Methods
+ (NSString *)primaryKey {
    return @"idx";
}

+ (NSArray *)requiredProperties {
    return @[@"idx", @"name", @"price"];
}

@end
