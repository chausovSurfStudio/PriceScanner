//
//  PRSModalNavigationController.m
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSModalNavigationController.h"


@interface PRSModalNavigationController ()

@end


@implementation PRSModalNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
}

- (void)configureNavigationBar {
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.tintColor = [UIColor prsMainThemeColor];
    self.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName: [UIColor prsMainThemeColor]
                                                 }];
}

@end
