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
    
    NSArray<NSString *> *words = [productName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    words = [words filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    NSMutableArray<NSString *> *newWords = [@[] mutableCopy];
    
    for (NSString *word in words) {
        __block NSUInteger englishCharsCount = 0;
        __block NSUInteger russianCharsCount = 0;
        __block NSUInteger digitsCharsCount = 0;
        __block NSUInteger undefinedCharsCount = 0;
        [word enumerateSubstringsInRange:NSMakeRange(0, word.length)
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                                  if ([self isEnglishChar:substring]) {
                                      englishCharsCount += 1;
                                  } else if ([self isRussianChar:substring]) {
                                      russianCharsCount += 1;
                                  } else if ([self isDigit:substring]) {
                                      digitsCharsCount += 1;
                                  } else {
                                      undefinedCharsCount += 1;
                                  }
                              }];
        if (undefinedCharsCount == 0) {
            [newWords addObject:[word capitalizedString]];
        } else if (russianCharsCount >= englishCharsCount) {
            NSString *russianString = [self convertToRussian:word];
            [newWords addObject:[russianString capitalizedString]];
        } else {
            NSString *englishString = [self convertToEnglish:word];
            [newWords addObject:[englishString capitalizedString]];
        }
    }
    
    return [newWords componentsJoinedByString:@" "];
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
        if ([firstLetterInLastWord isEqualToString:@"P"]) {
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
    NSCharacterSet *russianLettersSet = [NSCharacterSet characterSetWithCharactersInString:@"БГДЖИЙЛПФЦЧШЩЪЫЬЭЮЯ"];
    NSRange russianCharRange = [character rangeOfCharacterFromSet:russianLettersSet];
    return russianCharRange.location != NSNotFound;
}

- (BOOL)isEnglishChar:(NSString *)character {
    NSCharacterSet *englishLettersSet = [NSCharacterSet characterSetWithCharactersInString:@"DFGIJLNQRSUVWZ"];
    NSRange englishCharRange = [character rangeOfCharacterFromSet:englishLettersSet];
    return englishCharRange.location != NSNotFound;
}

- (BOOL)isDigit:(NSString *)character {
    NSCharacterSet *digitsSet = [NSCharacterSet decimalDigitCharacterSet];
    NSRange digitRange = [character rangeOfCharacterFromSet:digitsSet];
    return digitRange.location != NSNotFound;
}

- (NSString *)convertToRussian:(NSString *)word {
    NSMutableString *correctedWord = [@"" mutableCopy];
    NSDictionary *russianDict = @{
                                  @"3": @"З",
                                  @"Y": @"У",
                                  @"K": @"К",
                                  @"E": @"Е",
                                  @"H": @"Н",
                                  @"X": @"Х",
                                  @"B": @"В",
                                  @"A": @"А",
                                  @"P": @"Р",
                                  @"O": @"О",
                                  @"C": @"С",
                                  @"M": @"М",
                                  @"T": @"Т",
                                  @"0": @"О"
                                  };
    [word enumerateSubstringsInRange:NSMakeRange(0, word.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                              if ([[russianDict allKeys] containsObject:substring]) {
                                  [correctedWord appendString:russianDict[substring]];
                              } else {
                                  [correctedWord appendString:substring];
                              }
                          }];
    return [correctedWord copy];
}

- (NSString *)convertToEnglish:(NSString *)word {
    NSMutableString *correctedWord = [@"" mutableCopy];
    [word enumerateSubstringsInRange:NSMakeRange(0, word.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                              if ([substring isEqualToString:@"0"]) {
                                  [correctedWord appendString:@"O"];
                              } else {
                                  [correctedWord appendString:substring];
                              }
                          }];
    return [correctedWord copy];
}

@end
