//
//  PRSStartDetectionModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSStartDetectionModuleInput <NSObject>

- (void)setOpenCameraModuleHandler:(void(^)(void))openCameraModuleHandler;

@end
