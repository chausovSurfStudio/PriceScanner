//
//  PRSSyntaxAnalyzer.m
//  PriceScanner
//
//  Created by Александр Чаусов on 21.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSSyntaxAnalyzer.h"


@implementation PRSSyntaxAnalyzer

- (NSString *)analyzeProductName:(NSString *)productName {
    if (![NSString notEmpty:productName]) {
        return productName;
    }
    
    NSArray *words = [productName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    words = [words filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    
    return nil;
}

- (NSString *)analyzeProductPrice:(NSString *)productPrice {
    if (![NSString notEmpty:productPrice]) {
        return productPrice;
    }
    
    NSArray<NSString *> *words = [productPrice componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    words = [words filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    
    NSString *lastWord = words.lastObject;
    if (lastWord.length > 0) {
        NSString *firstLetterInLastWord = [words.lastObject substringWithRange:NSMakeRange(0, 1)];
        if ([firstLetterInLastWord isEqualToString:@"P"] || [firstLetterInLastWord isEqualToString:@"Р"]) {
            lastWord = @"₽";
            
            NSMutableArray<NSString *> *newWords = [NSMutableArray arrayWithArray:words];
            [newWords removeLastObject];
            [newWords addObject:lastWord];
            words = [newWords copy];
        }
    }

    return [words componentsJoinedByString:@" "];
}

#pragma mark - Private Methods
- (BOOL)isRussianChar:(NSString *)character {
    return NO;
}

- (BOOL)isEnglishChar:(NSString *)character {
    return NO;
}

- (BOOL)isDigit:(NSString *)character {
    return NO;
}

@end
