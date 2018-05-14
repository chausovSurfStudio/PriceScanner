//
//  UIViewController+ScanUtils.m
//  PriceScanner
//
//  Created by Александр Чаусов on 14.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "UIViewController+ScanUtils.h"
#import <Vision/Vision.h>


@implementation UIViewController (ScanUtils)

- (void)highlightWord:(VNTextObservation *)word inScene:(UIImageView *)scene {
    CALayer *border = [[CALayer alloc] init];
    border.frame = [self frameForWord:word sceneSize:scene.bounds.size];
    border.borderWidth = 2.f;
    border.borderColor = [UIColor redColor].CGColor;
    
    [scene.layer addSublayer:border];
}

- (void)highlightLetter:(VNRectangleObservation *)letter inScene:(UIImageView *)scene {
    CALayer *border = [[CALayer alloc] init];
    border.frame = [self frameForLetter:letter sceneSize:scene.bounds.size];
    border.borderWidth = 1.f;
    border.borderColor = [UIColor blueColor].CGColor;
    
    [scene.layer addSublayer:border];
}

- (UIImage *)cropLetter:(VNRectangleObservation *)letter fromImage:(UIImage *)image {
    CGRect letterFrame = [self frameForLetter:letter sceneSize:image.size];
    UIImage *letterImage = [self cutRect:letterFrame fromImage:image];
    return letterImage;
}

- (CGRect)frameForWord:(VNTextObservation *)word sceneSize:(CGSize)sceneSize {
    NSArray<VNRectangleObservation *> *boxes = word.characterBoxes;
    
    CGFloat minX = 9999.f;
    CGFloat maxX = 0.f;
    CGFloat minY = 9999.f;
    CGFloat maxY = 0.f;
    
    for (VNRectangleObservation *charBox in boxes) {
        if (charBox.bottomLeft.x < minX) {
            minX = charBox.bottomLeft.x;
        }
        if (charBox.bottomRight.x > maxX) {
            maxX = charBox.bottomRight.x;
        }
        if (charBox.bottomRight.y < minY) {
            minY = charBox.bottomRight.y;
        }
        if (charBox.topRight.y > maxY) {
            maxY = charBox.topRight.y;
        }
    }
    
    CGFloat originX = minX * sceneSize.width;
    CGFloat originY = (1 - maxY) * sceneSize.height;
    CGFloat width = (maxX - minX) * sceneSize.width;
    CGFloat height = (maxY - minY) * sceneSize.height;
    
    return CGRectMake(originX, originY, width, height);
}

- (CGRect)frameForLetter:(VNRectangleObservation *)letter sceneSize:(CGSize)sceneSize {
    CGFloat originX = letter.topLeft.x * sceneSize.width;
    CGFloat originY = (1 - letter.topLeft.y) * sceneSize.height;
    CGFloat width = (letter.topRight.x - letter.bottomLeft.x) * sceneSize.width;
    CGFloat height = (letter.topLeft.y - letter.bottomLeft.y) * sceneSize.height;
    
    return CGRectMake(originX, originY, width, height);
}

#pragma mark - Support Methods
- (UIImage *)cutRect:(CGRect)rect fromImage:(UIImage *)image {
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    
    return resultImage;
}

@end
