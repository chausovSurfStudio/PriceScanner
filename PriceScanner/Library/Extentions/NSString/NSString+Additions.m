//
//  NSString+Additions.m
//  PriceScanner
//
//  Created by Александр Чаусов on 04.05.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "NSString+Additions.h"


@implementation NSString (Additions)

- (NSString *)localized {
    return NSLocalizedString(self, nil);
}

+ (BOOL)notEmpty:(NSString *)string {
    return string && string.length > 0;
}

@end
