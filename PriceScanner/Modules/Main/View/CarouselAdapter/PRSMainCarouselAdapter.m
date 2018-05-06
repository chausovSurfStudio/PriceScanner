//
//  PRSMainCarouselAdapter.m
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSMainCarouselAdapter.h"
#import "PRSMainCarouselCell.h"
#import "PRSMainCarouselPageModel.h"


static NSString * const cellIdentifier = @"mainCarouselCell";


@interface PRSMainCarouselAdapter() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<PRSMainCarouselPageModel *> *models;

@end


@implementation PRSMainCarouselAdapter

#pragma mark - Internal Methods
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"PRSMainCarouselCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.pagingEnabled = YES;
    }
    return self;
}

#pragma mark - Interface Methods
- (void)configureWithModels:(NSArray<PRSMainCarouselPageModel *> *)models {
    self.models = models;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PRSMainCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithModel:self.models[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
