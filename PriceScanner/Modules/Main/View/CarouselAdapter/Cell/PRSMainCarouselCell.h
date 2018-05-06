//
//  PRSMainCarouselCell.h
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRSMainCarouselPageModel;


@interface PRSMainCarouselCell : UICollectionViewCell

- (void)configureWithModel:(PRSMainCarouselPageModel *)model;

@end
