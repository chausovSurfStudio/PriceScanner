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

/** Метод информирует презентера о том, что необходимо обновить данные */
- (void)refreshData;

/** Метод информирует презентера о том, что необходимо открыть модуль с результатами сканирования */
- (void)openScanResultModuleForModelId:(NSNumber *)modelId;

/** Метод информирует презентера о том, что необходимо начать сканирование ценника */
- (void)openCameraModule;

/** Метод информирует презентера о том, что была нажата кнопка очистки истории */
- (void)tapOnClearHistoryButton;

@end
