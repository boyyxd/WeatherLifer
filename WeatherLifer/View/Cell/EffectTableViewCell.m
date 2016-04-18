//
//  EffectTableViewCell.m
//  WeatherLifer
//
//  Created by ink on 15/6/15.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "EffectTableViewCell.h"

@implementation EffectTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView removeFromSuperview];
        self.backgroundColor = [UIColor clearColor];
        
        [self addContent];
        }
    return self;
}
- (void)addContent{
    self.effectImageView = [UIImageView new];
    [self addSubview:self.effectImageView];
    [self.effectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.greaterThanOrEqualTo(@0);
        make.width.greaterThanOrEqualTo(@0);
    }];
    self.effectLabel = [UILabel new];
    [self addSubview:self.effectLabel];
    [self.effectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(50);
        make.centerY.equalTo(self.mas_centerY);
        make.height.greaterThanOrEqualTo(@0);
        make.width.greaterThanOrEqualTo(@0);

    }];
    self.effectLabel.textColor = [UIColor whiteColor];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.effectImageView.image = [UIImage imageNamed:self.selectImageName];
    }else{
        self.effectImageView.image = [UIImage imageNamed:self.unSelectImageName];

    }
    // Configure the view for the selected state
}

@end
