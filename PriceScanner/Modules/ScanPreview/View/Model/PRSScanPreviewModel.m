//
//  PRSScanPreviewModel.m
//  PriceScanner
//
//  Created by Александр Чаусов on 17.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSScanPreviewModel.h"
#import "PRSScanResultEntity.h"


@interface PRSScanPreviewModel()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;

@end


@implementation PRSScanPreviewModel

- (instancetype)initWithEntity:(PRSScanResultEntity *)entity {
    self = [super init];
    if (self) {
        self.name = [entity.name copy];
        self.price = [entity.price copy];
    }
    return self;
}

@end
