//
//  PRSScanPreviewModel.h
//  PriceScanner
//
//  Created by Александр Чаусов on 17.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanResultEntity;


/** Модуль сущности, используемой в пределах экрана предпросмотра результата сканирования */
@interface PRSScanPreviewModel : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *price;

- (instancetype)initWithEntity:(PRSScanResultEntity *)entity;

@end
