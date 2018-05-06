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


@interface PRSMainCarouselAdapter() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PRSMainCarouselCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<PRSMainCarouselPageModel *> *models;
@property (nonatomic, strong) id<PRSMainCarouselAdapterDelegate> delegate;

@end


@implementation PRSMainCarouselAdapter

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView delegate:(id<PRSMainCarouselAdapterDelegate>)delegate {
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
        self.delegate = delegate;
        
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

- (NSInteger)pagesCount {
    return self.models.count;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PRSMainCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithModel:self.models[indexPath.row]];
    cell.cellDelegate = self;
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self sendCurrentPageToDelegate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self sendCurrentPageToDelegate];
}

#pragma mark - PRSMainCarouselCellDelegate
- (void)actionButtonDidTap {
    if ([self.delegate respondsToSelector:@selector(actionButtonDidTap)]) {
        [self.delegate actionButtonDidTap];
    }
}

#pragma mark - Private Methods
- (void)sendCurrentPageToDelegate {
    if ([self.delegate respondsToSelector:@selector(scrollCarouselToPage:)]) {
        [self.delegate scrollCarouselToPage:[self currentCarouselPage]];
    }
}

- (NSInteger)currentCarouselPage {
    CGFloat pageWidth = self.collectionView.bounds.size.width;
    NSInteger leftVisiblePage = self.collectionView.contentOffset.x / pageWidth;
    CGFloat fractionalValue = ((NSInteger)self.collectionView.contentOffset.x % (NSInteger)pageWidth) / pageWidth;
    return leftVisiblePage + roundf(fractionalValue);
}

@end
