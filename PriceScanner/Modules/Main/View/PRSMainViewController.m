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
#import "PRSMainCarouselPageModel.h"


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
    [self.carouselAdapter configureWithModels:[self buildPageModels]];
}

#pragma mark - Private Methods
- (NSArray<PRSMainCarouselPageModel *> *)buildPageModels {
    PRSMainCarouselPageModel *firstPageModel = [[PRSMainCarouselPageModel alloc] initWithTitle:@"Главная_первая_страница_заголовок".localized
                                                                                      subtitle:@"Главная_первая_страница_подзаголовок".localized
                                                                                         image:[UIImage imageNamed:@"icMainModuleFirstPage"]
                                                                             actionButtonTitle:nil];
    PRSMainCarouselPageModel *secondPageModel = [[PRSMainCarouselPageModel alloc] initWithTitle:@"Главная_вторая_страница_заголовок".localized
                                                                                       subtitle:@"Главная_вторая_страница_подзаголовок".localized
                                                                                          image:[UIImage imageNamed:@"icMainModuleSecondPage"]
                                                                              actionButtonTitle:nil];
    PRSMainCarouselPageModel *thirdPageModel = [[PRSMainCarouselPageModel alloc] initWithTitle:@"Главная_третья_страница_заголовок".localized
                                                                                      subtitle:@"Главная_третья_страница_подзаголовок".localized
                                                                                         image:[UIImage imageNamed:@"icMainModuleThirdPage"]
                                                                             actionButtonTitle:nil];
    PRSMainCarouselPageModel *fourthPageModel = [[PRSMainCarouselPageModel alloc] initWithTitle:@"Главная_четвертая_страница_заголовок".localized
                                                                                      subtitle:nil
                                                                                         image:[UIImage imageNamed:@"icMainModuleFourthPage"]
                                                                              actionButtonTitle:@"Главная_четвертая_страница_кнопка".localized];
    return @[firstPageModel, secondPageModel, thirdPageModel, fourthPageModel];
}

@end
