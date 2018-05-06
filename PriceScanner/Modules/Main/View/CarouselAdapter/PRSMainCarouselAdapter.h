//
//  PRSMainCarouselAdapter.h
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSMainCarouselPageModel;


@interface PRSMainCarouselAdapter : NSObject

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

- (void)configureWithModels:(NSArray<PRSMainCarouselPageModel *> *)models;

@end
