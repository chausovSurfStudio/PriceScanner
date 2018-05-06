//
//  PRSScanResultModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSScanResultModuleInput <NSObject>

- (void)configureAsModalWithCloseAction:(void(^)(void))closeAction;

@end
