//
//  PRSLoaderView.m
//  PriceScanner
//
//  Created by Александр Чаусов on 12.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSLoaderView.h"
#import <DGActivityIndicatorView/DGActivityIndicatorView.h>


@interface PRSLoaderView()

@property (nonatomic, strong) IBOutlet DGActivityIndicatorView *activityIndicator;

@end


@implementation PRSLoaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureActivityIndicator];
}

#pragma mark - Interface Methods
- (void)startAnimating {
    [self.activityIndicator startAnimating];
}

- (void)stopAnimating {
    [self.activityIndicator stopAnimating];
}

#pragma mark - Configure
- (void)configureActivityIndicator {
    [self.activityIndicator setType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader];
    [self.activityIndicator setTintColor:[UIColor prsMainThemeColor]];
}


@end
