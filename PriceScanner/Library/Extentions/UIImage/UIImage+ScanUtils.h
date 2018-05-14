//
//  UIImage+ScanUtils.h
//  PriceScanner
//
//  Created by Александр Чаусов on 14.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface UIImage (ScanUtils)

+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
