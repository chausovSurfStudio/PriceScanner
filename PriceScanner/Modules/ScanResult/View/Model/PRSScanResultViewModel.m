//
//  PRSScanResultViewModel.m
//  PriceScanner
//
//  Created by Александр Чаусов on 09.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanResultViewModel.h"
#import "PRSScanResultEntity.h"


@interface PRSScanResultViewModel()

@property (nonatomic, strong) NSNumber *idx;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) UIImage *photo;

@end


@implementation PRSScanResultViewModel

- (instancetype)initWithEntity:(PRSScanResultEntity *)entity {
    self = [super init];
    if (self) {
        self.idx = [entity.idx copy];
        self.name = [entity.name copy];
        self.price = [entity.price copy];
        self.photo = [UIImage imageWithData:entity.photoData];
    }
    return self;
}

@end
