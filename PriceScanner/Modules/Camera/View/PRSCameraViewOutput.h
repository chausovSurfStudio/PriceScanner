//
//  PRSCameraViewOutput.h
//  PriceScanner
//
//  Created by Alexander Chausov on 28/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSCameraViewOutput <NSObject>

/** Метод информирует презентера о том, что view загрузилась и готова к работе */
- (void)viewLoaded;

@end
