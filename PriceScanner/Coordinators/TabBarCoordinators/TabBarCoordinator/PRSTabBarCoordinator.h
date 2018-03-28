//
//  PRSTabBarCoordinator.h
//  PriceScanner
//
//  Created by Chausov Alexander on 28.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>


/** Класс, инкапсулирующий в себе логику создания главных координаторов приложения. Держит сильные ссылки на эти координаторы */
@interface PRSTabBarCoordinator : NSObject

/** Возвращает View для начального экрана во flow камеры */
- (UINavigationController *)cameraInitialView;

/** Возвращает View для начального экрана во flow информации о приложении */
- (UINavigationController *)infoInitialView;

@end
