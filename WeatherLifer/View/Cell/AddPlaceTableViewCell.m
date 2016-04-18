//
//  AddPlaceTableViewCell.m
//  WeatherLifer
//
//  Created by ink on 15/7/3.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "AddPlaceTableViewCell.h"

@implementation AddPlaceTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        selectImageView = [UIImageView new];
        [self addSubview:selectImageView];
        UIImage * image = [UIImage imageNamed:@"check2.png"];
        selectImageView.image = image;
        [selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(image.size);
        }];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        selectImageView.hidden =   NO;
    }else{
        selectImageView.hidden = YES;
    }
    // Configure the view for the selected state
}

@end
