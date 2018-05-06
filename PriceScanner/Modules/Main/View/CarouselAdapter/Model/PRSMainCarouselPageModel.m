//
//  PRSMainCarouselPageModel.m
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSMainCarouselPageModel.h"


@interface PRSMainCarouselPageModel()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *actionButtonTitle;

@end


@implementation PRSMainCarouselPageModel

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image actionButtonTitle:(NSString *)actionButtonTitle {
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.image = image;
        self.actionButtonTitle = actionButtonTitle;
    }
    return self;
}
@end
