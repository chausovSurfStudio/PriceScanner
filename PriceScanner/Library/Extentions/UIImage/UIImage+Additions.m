//
//  UIImage+Additions.m
//  PriceScanner
//
//  Created by Александр Чаусов on 20.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "UIImage+Additions.h"


@implementation UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
