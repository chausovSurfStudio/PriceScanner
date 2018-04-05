//
//  PRSDesignableView.h
//  PriceScanner
//
//  Created by Александр Чаусов on 29.03.18.
//  Copyright © 2018 Surf. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * Базовый класс для всех UIView в приложении, дизайн которых содержится в xib-файле.
 * Имеет возможность подгрузить дизайн View из xib-файла.
 * При указании файла как IB_DESIGNABLE - view будет рендерится в IB (в xib-файле наследуемого view указать file's owner, не переопределять класс View)
 */
@interface PRSDesignableView : UIView

@end
