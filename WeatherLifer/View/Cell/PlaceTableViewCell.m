//
//  PlaceTableViewCell.m
//  WeatherLifer
//
//  Created by ink on 15/6/30.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "PlaceTableViewCell.h"
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height

@implementation PlaceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView removeFromSuperview];
        self.backgroundColor = [UIColor whiteColor];
        UIView * lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithRed:201 / 255.0 green:201 / 255.0 blue:201 / 255.0 alpha:1];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).with.offset(-0.5f);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(@0.5f);
        }];
        [self addContent];
    }
    return self;
}
- (void)addContent{
    _placeNameLabel = [UILabel new];
    [self addSubview:_placeNameLabel];
    [_placeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(12);
        make.top.equalTo(self.mas_top).with.offset(26);
        make.width.mas_greaterThanOrEqualTo(@0);
        make.height.mas_greaterThanOrEqualTo(@0);
    }];
    _placeNameLabel.textColor = [UIColor colorWithRed:103 / 255.0 green:110 /255.0 blue:138 /255.0 alpha:1];
    _placeNameLabel.font = [UIFont boldSystemFontOfSize:18];
    _locationImageView = [UIImageView new];
    [self addSubview:_locationImageView];
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_placeNameLabel.mas_right).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(20, 25));
        
    }];
    _addressLabel = [UILabel new];
    [self addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_placeNameLabel.mas_left);
        make.top.equalTo(_placeNameLabel.mas_bottom).with.offset(5);
        make.width.mas_greaterThanOrEqualTo(@0);
        make.height.mas_greaterThanOrEqualTo(@0);
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.width.mas_lessThanOrEqualTo(@250);
                break;
            case Iphone5:
            case Iphone4:{
                make.width.mas_lessThanOrEqualTo(@160);
                
                break;
            }
            default:
                break;
        }

    }];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor colorWithRed:187 / 255.0 green:187/ 255.0 blue:187 / 255.0 alpha:1.0];
    _weatherIconImageView = [UIImageView new];
    [self addSubview:_weatherIconImageView];
    [_weatherIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(-14);
        make.size.mas_equalTo(CGSizeMake(48, 45));
    }];
    _weatherIconImageView.alpha = 0.5;
    _tempLabel = [UILabel new];
    [self addSubview:_tempLabel];
    _tempLabel.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:28];
    [_tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(_weatherIconImageView.mas_left).with.offset(-6);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
    }];
    _tempLabel.textColor = [UIColor colorWithRed:103 / 255.0 green:110 /255.0 blue:138 /255.0 alpha:1];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
