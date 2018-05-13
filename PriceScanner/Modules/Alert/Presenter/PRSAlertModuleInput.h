//
//  PRSAlertModuleInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 13/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRSAlertModuleInput <NSObject>

/** Метод позволяет сконфигурировать модуль, определив логику действий после нажатия на кнопки
 *
 * @param message Сообщение, которое будет отображаться в диалоге
 * @param agreeAction Блок кода, будет вызываться при нажатии на кнопку согласия
 * @param cancelAction Блок кода, будет вызываться при нажатии на кнопку отмены
 *
 */
- (void)configureWithMessage:(NSString *)message agreeAction:(void(^)(void))agreeAction cancelAction:(void(^)(void))cancelAction;

@end
