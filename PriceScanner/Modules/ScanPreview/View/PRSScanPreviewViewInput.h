//
//  PRSScanPreviewViewInput.h
//  PriceScanner
//
//  Created by Chausov Alexander on 17/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PRSScanPreviewModel;


@protocol PRSScanPreviewViewInput <NSObject>

/** Установка начального состояния view
 *
 * @param model Сущность результата сканирования, которую необходимо отобразить на экране.
 *
 */
- (void)setupInitialStateWithModel:(PRSScanPreviewModel *)model;

@end
