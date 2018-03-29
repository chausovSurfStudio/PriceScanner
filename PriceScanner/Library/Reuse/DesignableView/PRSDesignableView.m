//
//  PRSDesignableView.m
//  PriceScanner
//
//  Created by Александр Чаусов on 29.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSDesignableView.h"


@interface PRSDesignableView()

@property (nonatomic, weak) UIView *view;

@end


@implementation PRSDesignableView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    NSString *className = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIView *view = [[bundle loadNibNamed:className owner:self options:nil] firstObject];
    if (view) {
        view.frame = self.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:view];
    }
}

- (UIView *)view {
    return self.subviews.firstObject;
}

@end
