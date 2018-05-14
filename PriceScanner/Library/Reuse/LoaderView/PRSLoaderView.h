//
//  PRSLoaderView.h
//  PriceScanner
//
//  Created by Александр Чаусов on 12.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSDesignableView.h"


/** Переиспользуемое view, отображается во время загрузки чего-либо */
@interface PRSLoaderView : PRSDesignableView

/** Метод запускает анимацию activity indicator'а на view */
- (void)startAnimating;
/** Метод останавливает анимацию activity indicator'а на view */
- (void)stopAnimating;
    
@end
