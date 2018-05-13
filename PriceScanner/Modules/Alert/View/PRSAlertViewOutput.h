//
//  PRSAlertViewOutput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSAlertViewOutput <NSObject>

/** Метод информирует презентера о том, что view загрузилась и готова к работе */
- (void)viewLoaded;

/** Метод информирует презентера о том, что произошло нажатие на кнопку согласия */
- (void)agreeButtonDidTap;

/** Метод информирует презентера о том, что произошло нажатие на кнопку отмены */
- (void)cancelButtonDidTap;

@end
