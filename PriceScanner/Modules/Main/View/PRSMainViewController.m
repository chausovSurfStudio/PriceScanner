//
//  PRSMainViewController.m
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSMainViewController.h"
#import "PRSMainViewOutput.h"

#import "PRSMainCarouselAdapter.h"


@interface PRSMainViewController ()

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) IBOutlet UIImageView *bottomImageView;

@property (nonatomic, strong) PRSMainCarouselAdapter *carouselAdapter;

@end


@implementation PRSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output viewLoaded];
}

#pragma mark - PRSMainViewInput
- (void)setupInitialState {
    [self configureNavigationBar];
    [self configureBottomImage];
    [self configureAdapter];
}

#pragma mark - Configure
- (void)configureNavigationBar {
    self.title = @"Главная".localized;
}

- (void)configureBottomImage {
    self.bottomImageView.image = [UIImage imageNamed:@"icCircles"];
}

- (void)configureAdapter {
    self.carouselAdapter = [[PRSMainCarouselAdapter alloc] initWithCollectionView:self.collectionView];
}

@end
