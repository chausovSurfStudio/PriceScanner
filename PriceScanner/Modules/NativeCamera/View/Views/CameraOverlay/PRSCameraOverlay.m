//
//  PRSCameraOverlay.m
//  PriceScanner
//
//  Created by Александр Чаусов on 29.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSCameraOverlay.h"


static CGFloat const cornerColorAnimationDuration = 0.3f;
static CGFloat const cornerSizeAnimationDuration = 0.15f;
static CGFloat const cornerLineDefaultSize = 34.f;
static CGFloat const overlayHorizontalOffset = 16.f;
static CGFloat const overlayTopOffset = 22.f;
static CGFloat const overlayBottomOffset = 62.f;


@interface PRSCameraOverlay()

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *overlayBorderViews;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *verticalCornerLines;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *horizontalCornerLines;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *verticalCornerLineHeights;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *horizontalCornerLineWidths;

@end


@implementation PRSCameraOverlay

- (void)awakeFromNib {
    [super awakeFromNib];
    _state = PRSCameraOverlayStateWaiting;
    _progress = 0.f;
    
    [self configureBorders];
    [self configureCornerLines];
}

- (void)setState:(PRSCameraOverlayState)state {
    _state = state;
    UIColor *color = [self cornerColorForCurrentState];
    [self changeCornerLinesColor:color animated:YES];
    if (state == PRSCameraOverlayStateWaiting) {
        self.progress = 0.f;
    }
}

- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        progress = 0.f;
    } else if (progress > 1) {
        progress = 1.f;
    }
    _progress = progress;
    [self updateCornerLinesSize];
}

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
/** Возвращает цвет для "уголков", подходящий для текущего состояния */
- (UIColor *)cornerColorForCurrentState {
    return self.state == PRSCameraOverlayStateWaiting ? [UIColor whiteColor] : [UIColor prsMainThemeColor];
}

/** Метод позволяет анимированно (или нет) поменять цвет для всех "уголков" */
- (void)changeCornerLinesColor:(UIColor *)color animated:(BOOL)animated {
    NSMutableArray<UIView *> *lines = [@[] mutableCopy];
    [lines addObjectsFromArray:self.verticalCornerLines];
    [lines addObjectsFromArray:self.horizontalCornerLines];
    if (animated) {
        [UIView animateWithDuration:cornerColorAnimationDuration
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

/** Метод позволяет анимированно поменять размер всех "уголков", в зависимости от текущего значения переменной progress */
- (void)updateCornerLinesSize {
    CGFloat lineWidth = [self freeHorizontalSpace] * self.progress + cornerLineDefaultSize;
    CGFloat lineHeight = [self freeVerticalSpace] * self.progress + cornerLineDefaultSize;
    for (NSLayoutConstraint *widthConstraint in self.horizontalCornerLineWidths) {
        widthConstraint.constant = lineWidth;
    }
    for (NSLayoutConstraint *heightConstraint in self.verticalCornerLineHeights) {
        heightConstraint.constant = lineHeight;
    }
    [UIView animateWithDuration:cornerSizeAnimationDuration
                     animations:^{
                         [self layoutIfNeeded];
                     }];
}

/** Возвращает величину пустого пространства между двумя свернутыми "уголками" по горизонтали */
- (CGFloat)freeHorizontalSpace {
    return (self.bounds.size.width - overlayHorizontalOffset * 2 - cornerLineDefaultSize * 2) / 2;
}

/** Возвращает величину пустого пространства между двумя свернутыми "уголками" по вертикали */
- (CGFloat)freeVerticalSpace {
    return (self.bounds.size.height - overlayTopOffset - overlayBottomOffset - cornerLineDefaultSize * 2) / 2;
}

@end
