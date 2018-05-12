//
//  PRSCameraOverlay.m
//  PriceScanner
//
//  Created by Александр Чаусов on 29.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCameraOverlay.h"


static CGFloat const animationDuration = 0.3f;

@interface PRSCameraOverlay()

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *overlayBorderViews;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *verticalCornerLines;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *horizontalCornerLines;

@end


@implementation PRSCameraOverlay

- (void)awakeFromNib {
    [super awakeFromNib];
    _state = PRSCameraOverlayStateWaiting;
    
    [self configureBorders];
    [self configureCornerLines];
}

- (void)setState:(PRSCameraOverlayState)state {
    _state = state;
    UIColor *color = [self cornerColorForCurrentState];
    [self changeCornerLinesColor:color animated:YES];
}

#pragma mark - Interface Methods


#pragma mark - Configure
- (void)configureBorders {
    for (UIView *borderView in self.overlayBorderViews) {
        borderView.backgroundColor = [[UIColor prsBlackTextColor] colorWithAlphaComponent:0.6f];
    }
}

- (void)configureCornerLines {
    UIColor *color = [self cornerColorForCurrentState];
    [self changeCornerLinesColor:color animated:NO];
}

#pragma mark - Private Methods
- (UIColor *)cornerColorForCurrentState {
    return self.state == PRSCameraOverlayStateWaiting ? [UIColor whiteColor] : [UIColor prsMainThemeColor];
}

- (void)changeCornerLinesColor:(UIColor *)color animated:(BOOL)animated {
    NSMutableArray<UIView *> *lines = [@[] mutableCopy];
    [lines addObjectsFromArray:self.verticalCornerLines];
    [lines addObjectsFromArray:self.horizontalCornerLines];
    if (animated) {
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             for (UIView *line in lines) {
                                 line.backgroundColor = color;
                             }
                         }];
    } else {
        for (UIView *line in lines) {
            line.backgroundColor = color;
        }
    }
}

@end
