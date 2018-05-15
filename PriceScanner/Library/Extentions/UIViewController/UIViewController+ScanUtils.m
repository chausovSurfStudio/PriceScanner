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
    border.frame = [self frameForRectObservation:letter sceneSize:scene.bounds.size];
    border.borderWidth = 1.f;
    border.borderColor = [UIColor blueColor].CGColor;
    
    [scene.layer addSublayer:border];
}

- (void)highlightRect:(VNRectangleObservation *)rect inScene:(UIImageView *)scene {
    CALayer *border = [[CALayer alloc] init];
    border.frame = [self frameForRectObservation:rect sceneSize:scene.bounds.size];
    border.borderWidth = 2.f;
    border.borderColor = [UIColor greenColor].CGColor;
    
    [scene.layer addSublayer:border];
}

- (UIImage *)cropLetter:(VNRectangleObservation *)letter fromImage:(UIImage *)image {
    CGRect letterFrame = [self frameForRectObservation:letter sceneSize:image.size];
    UIImage *letterImage = [self cutRect:letterFrame fromImage:image];
    return letterImage;
}

- (CGRect)regionOfInterestFromRectObservation:(VNRectangleObservation *)rectObservation {
    NSArray<NSValue *> *points = @[
                                   [NSValue valueWithCGPoint:rectObservation.topLeft],
                                   [NSValue valueWithCGPoint:rectObservation.topRight],
                                   [NSValue valueWithCGPoint:rectObservation.bottomLeft],
                                   [NSValue valueWithCGPoint:rectObservation.bottomRight]
                                   ];
    CGFloat minX = 1.f;
    CGFloat maxX = 0.f;
    CGFloat minY = 1.f;
    CGFloat maxY = 0.f;
    for (NSValue *pointValue in points) {
        CGPoint point = [pointValue CGPointValue];
        minX = point.x < minX ? point.x : minX;
        maxX = point.x > maxX ? point.x : maxX;
        minY = point.y < minY ? point.y : minY;
        maxY = point.y > maxY ? point.y : maxY;
    }
    CGRect region = CGRectMake(minX, minY, maxX - minX, maxY - minY);
    if ([self isValidRegionOfInterest:region]) {
        return region;
    } else {
        // вернем значение, которое используется в качестве параметра regionOfInterest по умолчанию
        return CGRectMake(0, 0, 1, 1);
    }
}

#pragma mark - Support Methods
/** Метод возращает фрейм слова относительно изображения, на котором оно расположено, и его размера */
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

/** Метод возращает фрейм для некоего распознанного прямоугольника (символа или границы ценника) относительно изображения, на котором он расположен, и его размера */
- (CGRect)frameForRectObservation:(VNRectangleObservation *)rectObservation sceneSize:(CGSize)sceneSize {
    CGFloat originX = rectObservation.topLeft.x * sceneSize.width;
    CGFloat originY = (1 - rectObservation.topLeft.y) * sceneSize.height;
    CGFloat width = (rectObservation.topRight.x - rectObservation.bottomLeft.x) * sceneSize.width;
    CGFloat height = (rectObservation.topLeft.y - rectObservation.bottomLeft.y) * sceneSize.height;
    
    return CGRectMake(originX, originY, width, height);
}

/** Метод позволяет вырезать изображение по его фрейму (rect) из исходного изображения */
- (UIImage *)cutRect:(CGRect)rect fromImage:(UIImage *)image {
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    
    return resultImage;
}

/** Возвращает YES в случае, если переданный прямоугольник подходит для установки в качестве параметра regionOfInterest к запросу VNRequest */
- (BOOL)isValidRegionOfInterest:(CGRect)region {
    return region.origin.x > 0 && region.origin.y > 0 && (region.origin.x + region.size.width) <= 1 && (region.origin.y + region.size.height) <= 1;
}

@end
