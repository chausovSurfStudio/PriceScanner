//
//  PRSSyntaxAnalyzer.h
//  PriceScanner
//
//  Created by Александр Чаусов on 21.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PRSSyntaxAnalyzer : NSObject

/**  */
- (NSString *)analyzeProductName:(NSString *)productName;

/**  */
- (NSString *)analyzeProductPrice:(NSString *)productPrice;

@end
