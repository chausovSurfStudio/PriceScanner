//
//  PRSNavigationController.m
//  PriceScanner
//
//  Created by Александр Чаусов on 05.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSNavigationController.h"


@interface PRSNavigationController ()

@end


@implementation PRSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configureGradientNavigationBar];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barStyle = UIBarStyleBlack;
}

#pragma mark - Configure
- (void)configureGradientNavigationBar {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    CGRect gradientFrame = self.navigationBar.bounds;
    
    gradientFrame.size.height += CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    gradientLayer.frame = gradientFrame;
    gradientLayer.colors = @[(__bridge id)[UIColor prsBarsGradientLightColor].CGColor,
                             (__bridge id)[UIColor prsBarsGradientDarkColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    
    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationBar setBackgroundImage:gradientImage forBarMetrics:UIBarMetricsDefault];
}

@end
