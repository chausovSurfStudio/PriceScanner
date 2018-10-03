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

- (void)openScanPreviewModuleWithName:(NSString *)name price:(NSString *)price photo:(UIImage *)photo {
    if (self.openPreviewAction) {
        self.openPreviewAction([[PRSScanResultEntity alloc] initWithName:name price:price photoData:UIImagePNGRepresentation(photo)]);
    }
}

@end
