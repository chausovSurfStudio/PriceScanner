//
//  PRSScanResultEntity.m
//  PriceScanner
//
//  Created by Александр Чаусов on 07.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanResultEntity.h"
#import "PRSScanResultEntry.h"


@interface PRSScanResultEntity()

@property (nonatomic, strong) NSNumber *idx;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;

@end


@implementation PRSScanResultEntity

- (instancetype)initWithName:(NSString *)name price:(NSString *)price {
    self = [super init];
    if (self) {
        self.name = name;
        self.price = price;
        self.idx = nil;
    }
    return self;
}

- (instancetype)initWithEntry:(PRSScanResultEntry *)entry {
    self = [super init];
    if (self) {
        self.name = entry.name;
        self.price = entry.price;
        self.idx = [NSNumber numberWithInteger:entry.idx];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Scan result with idx %@, name = %@, price = %@", self.idx, self.name, self.price];
}

@end
