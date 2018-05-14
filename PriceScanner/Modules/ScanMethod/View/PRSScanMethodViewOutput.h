//
//  PRSScanMethodViewOutput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSScanMethodViewOutput <NSObject>

/** Метод информирует презентера о том, что view загрузилась и готова к работе */
- (void)viewLoaded;

/** Метод информирует презентера о том, что пользователь решил сканировать ценник и определять границы средствами iOS */
- (void)tapOnScanWithIosMethod;

/** Метод информирует презентера о том, что пользователь решил сканировать ценник и определять границы средствами ML */
- (void)tapOnScanWithMachineLearningMethod;

/** Метод информирует презентера о том, что пользователь решил сканировать ценник и вручную определять его границы */
- (void)tapOnScanWithManualMethod;

@end
