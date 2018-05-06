//
//  PRSMainCarouselCell.h
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRSMainCarouselPageModel;


@protocol PRSMainCarouselCellDelegate <NSObject>

/** Метод информирует делегата о том, что в ячейке была нажата кнопка */
- (void)actionButtonDidTap;

@end


/** Ячейка для карусели на главном экране */
@interface PRSMainCarouselCell : UICollectionViewCell

@property (nonatomic, weak) id<PRSMainCarouselCellDelegate> cellDelegate;

/** Метод конфигурации ячейки на основе объекта модели */
- (void)configureWithModel:(PRSMainCarouselPageModel *)model;

@end
