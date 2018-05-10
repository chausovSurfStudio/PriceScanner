//
//  PRSHistoryEmptyView.h
//  PriceScanner
//
//  Created by Александр Чаусов on 10.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSDesignableView.h"


@protocol PRSHistoryEmptyViewDelegate <NSObject>

/** Метод информирует делегата о том, что на emptyView была нажата кнопка */
- (void)emptyViewActionButtonDidTap;

@end


/** View для отображение пустого сотояния экрана истории */
@interface PRSHistoryEmptyView : PRSDesignableView

@property (nonatomic, weak) id<PRSHistoryEmptyViewDelegate> delegate;

@end
