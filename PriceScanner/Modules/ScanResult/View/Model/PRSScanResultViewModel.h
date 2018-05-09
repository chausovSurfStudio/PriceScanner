//
//  PRSScanResultViewModel.h
//  PriceScanner
//
//  Created by Александр Чаусов on 09.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultEntity;


/** Модель сущности, используемой на экране результата сканирования */
@interface PRSScanResultViewModel : NSObject

@property (nonatomic, strong, readonly) NSNumber *idx;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *price;
@property (nonatomic, strong, readonly) UIImage *photo;

- (instancetype)initWithEntity:(PRSScanResultEntity *)entity;

@end
