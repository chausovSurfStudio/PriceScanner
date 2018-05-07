//
//  PRSHistoryTableViewCell.m
//  PriceScanner
//
//  Created by Александр Чаусов on 07.05.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

#import "PRSHistoryTableViewCell.h"
#import "PRSHistoryTableCellModel.h"



@interface PRSHistoryTableViewCell()

@property (nonatomic, strong) IBOutlet UIView *mainContainerView;
@property (nonatomic, strong) IBOutlet UIImageView *photoImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;

@end


@implementation PRSHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureStyle];
}

#pragma mark - Interface Methods
- (void)configureWithModel:(PRSHistoryTableCellModel *)model {
    self.photoImageView.image = model.photo;
    self.nameLabel.text = model.name;
    self.priceLabel.text = model.price;
}

#pragma mark - Configure
- (void)configureStyle {
    self.mainContainerView.layer.cornerRadius = 4.f;
    self.mainContainerView.layer.masksToBounds = YES;
    
    self.nameLabel.font = [UIFont systemFontOfSize:12.f weight:UIFontWeightMedium];
    self.nameLabel.textColor = [UIColor prsDarkBlueTextColor];
    
    self.priceLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightBlack];
    self.priceLabel.textColor = [UIColor prsBlackTextColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
