//
//  PRSNativeCameraViewOutput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSNativeCameraViewOutput <NSObject>

/** Метод информирует презентера о том, что view загрузилась и готова к работе */
- (void)viewLoaded;

/** Метод информирует презентера о том, что необходимо открыть модуль с предпросмотром результатов сканирования */
- (void)openScanPreviewModule;

@end
