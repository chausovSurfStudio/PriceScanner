//
//  PRSScanPreviewViewOutput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSScanPreviewViewOutput <NSObject>

/** Метод информирует презентера о том, что view загрузилась и готова к работе */
- (void)viewLoaded;

/** Метод вызывается, если пользователь решил сохранить результаты сканирования */
- (void)saveScanResult;

/** Метод вызывается при нажатии пользователем кнопки закрытия модуля */
- (void)closeModule;

@end
