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

/** Метод вызывается при скролле карусели, передается текущая отображаемая страница карусели */
- (void)scrollCarouselToPage:(NSInteger)page;

@end


/** Адаптер для карусели на главном экране */
@interface PRSMainCarouselAdapter : NSObject

/** Конструктор позволяет передать UICollectionView, в котором будет отображена карусель, а также делегат для адаптера */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView delegate:(id<PRSMainCarouselAdapterDelegate>)delegate;

/** Метод для конфигурации карусели на главной с помощью массива объектов для конфигурации ячеек карусели */
- (void)configureWithModels:(NSArray<PRSMainCarouselPageModel *> *)models;
/** Метод возвращает количество страниц в каруселе */
- (NSInteger)pagesCount;

@end
