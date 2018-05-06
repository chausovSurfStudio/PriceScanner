//
//  PRSCameraModuleInput.h
//  PriceScanner
//
//  Created by Alexander Chausov on 28/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSCameraModuleInput <NSObject>

- (void)configureWithOpenResultAction:(void(^)(void))openResultAction;

@end
