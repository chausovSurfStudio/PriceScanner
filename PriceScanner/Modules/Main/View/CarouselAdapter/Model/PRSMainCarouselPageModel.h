//
//  PRSMainCarouselPageModel.h
//  PriceScanner
//
//  Created by Александр Чаусов on 06.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>


/** Класс, на основе объектов которого будет выполнено построение ячеек для карусели на главной */
@interface PRSMainCarouselPageModel : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subtitle;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, strong, readonly) NSString *actionButtonTitle;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image actionButtonTitle:(NSString *)actionButtonTitle;

@end
