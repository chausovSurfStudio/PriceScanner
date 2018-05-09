//
//  UILabel+Additions.m
//  PriceScanner
//
//  Created by Александр Чаусов on 09.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "UILabel+Additions.h"


@implementation UILabel (Additions)

- (void)setText:(NSString *)text withLineSpacing:(NSNumber *)lineSpacing letterSpacing:(NSNumber *)letterSpacing {
    if (!text) {
        text = @"";
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange textRange = NSMakeRange(0, text.length);
    
    if (lineSpacing) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = [lineSpacing floatValue];
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    }
    
    if (letterSpacing) {
        [attributedString addAttribute:NSKernAttributeName value:letterSpacing range:textRange];
    }
    
    self.attributedText = attributedString;
}

@end

