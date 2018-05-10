//
//  PRSHistoryViewOutput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 04/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSHistoryViewOutput <NSObject>

/** Метод информирует презентера о том, что view загрузилась и готова к работе */
- (void)viewLoaded;

/** Метод информирует презентера о том, что view готова появиться на экране */
- (void)viewReadyToAppear;

/** Метод информирует презентера о том, что необходимо открыть модуль с результатами сканирования */
- (void)openScanResultModuleForModelId:(NSNumber *)modelId;

/** Метод информирует презентера о том, что необходимо начать сканирование ценника */
- (void)openCameraModule;

@end
