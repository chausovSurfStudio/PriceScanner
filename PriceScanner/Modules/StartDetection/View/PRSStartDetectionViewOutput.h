//
//  PRSStartDetectionViewOutput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 24/03/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSStartDetectionViewOutput <NSObject>

/** Метод информирует презентера о том, что view загрузилась и готова к работе */
- (void)viewLoaded;

@end
