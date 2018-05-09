//
//  PRSHistoryTableCellModel.m
//  PriceScanner
//
//  Created by Александр Чаусов on 08.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSHistoryTableCellModel.h"
#import "PRSScanResultEntity.h"


@interface PRSHistoryTableCellModel()

@property (nonatomic, strong) NSNumber *idx;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) UIImage *photo;

@end


@implementation PRSHistoryTableCellModel

- (instancetype)initWithScanResultEntity:(PRSScanResultEntity *)entity {
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
