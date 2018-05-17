//
//  PRSManualCameraPresenter.m
//  PriceScanner
//
//  Created by Chausov Alexander on 14/05/2018.
//  Copyright © 2018 ChausovCompany. All rights reserved.
//

#import "PRSManualCameraPresenter.h"
#import "PRSManualCameraViewInput.h"

#import "PRSScanResultEntity.h"


@interface PRSManualCameraPresenter()

@property (nonatomic, copy) void (^openPreviewAction)(PRSScanResultEntity *scanResultEntity);

@end


@implementation PRSManualCameraPresenter

#pragma mark - PRSManualCameraModuleInput
- (void)configureWithOpenPreviewAction:(void(^)(PRSScanResultEntity *scanResultEntity))openPreviewAction {
    self.openPreviewAction = openPreviewAction;
}

#pragma mark - PRSManualCameraViewOutput
- (void)viewLoaded {
    [self.view setupInitialState];
}

- (void)openScanPreviewModule {
    if (self.openPreviewAction) {
        // TODO: тестовый код, удалить позднее
        UIImage *photo = [UIImage imageNamed:@"launchScreenBackground"];
        PRSScanResultEntity *result = [[PRSScanResultEntity alloc] initWithName:@"Шоколадка Аленка" price:@"87 ₽" photoData:UIImagePNGRepresentation(photo)];
        self.openPreviewAction(result);
    }
}

@end
