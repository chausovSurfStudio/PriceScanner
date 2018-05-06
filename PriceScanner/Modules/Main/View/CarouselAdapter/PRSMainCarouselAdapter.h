//
//  PRSMainCarouselAdapter.h
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSMainCarouselPageModel;


@protocol PRSMainCarouselAdapterDelegate <NSObject>

/** Метод информирует делегата о том, что в ячейке карусели была нажата кнопка */
- (void)actionButtonDidTap;

@end


@interface PRSMainCarouselAdapter : NSObject

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView delegate:(id<PRSMainCarouselAdapterDelegate>)delegate;

- (void)configureWithModels:(NSArray<PRSMainCarouselPageModel *> *)models;

@end
