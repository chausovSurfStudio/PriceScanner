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


@interface PRSMainCarouselCell : UICollectionViewCell

@property (nonatomic, weak) id<PRSMainCarouselCellDelegate> cellDelegate;

- (void)configureWithModel:(PRSMainCarouselPageModel *)model;

@end
