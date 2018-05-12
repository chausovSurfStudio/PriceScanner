//
//  PRSCameraOverlay.m
//  PriceScanner
//
//  Created by Александр Чаусов on 29.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCameraOverlay.h"


@interface PRSCameraOverlay()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *overlayBorderViews;


@end


@implementation PRSCameraOverlay

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureBorders];
}

#pragma mark - Configure
- (void)configureBorders {
    for (UIView *borderView in self.overlayBorderViews) {
        borderView.backgroundColor = [[UIColor prsBlackTextColor] colorWithAlphaComponent:0.6f];
    }
}

@end
