//
//  WeekCollectionViewCell.m
//  WeatherLifer
//
//  Created by ink on 15/6/4.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekCollectionViewCell.h"
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation WeekCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initContent];

    }
    return self;
}
/**
 *  初始化控件
 */
- (void)initContent{
    {
    _weekLabel = [UILabel new];
    _weekLabel.textAlignment = NSTextAlignmentCenter;
        _weekLabel.textColor = [UIColor whiteColor];
    [self addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.greaterThanOrEqualTo(@0);
    }];
        
    }
    
    {
        _topWeatherImageView = [UIImageView new];
        [self addSubview:_topWeatherImageView];
        [_topWeatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            switch ((NSInteger)ScreenHeigth) {
                case Iphone6:
                case Iphone6p:
                    make.top.equalTo(_weekLabel.mas_bottom).with.offset(24);
                    make.width.mas_equalTo(@28);
                    make.height.mas_equalTo(@28);

                    
                    break;
                case Iphone5:
                case Iphone4:{
                    make.top.equalTo(_weekLabel.mas_bottom).with.offset(14);
                    make.width.mas_equalTo(@26);
                    make.height.mas_equalTo(@26);

                    break;
                }
                default:
                    break;
            }

            
        }];
    
    
    }
    
    {
        _bottomWeatherImageView = [UIImageView new];
        [self addSubview:_bottomWeatherImageView];
        [_bottomWeatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);

            switch ((NSInteger)ScreenHeigth) {
                case Iphone6:
                case Iphone6p:
                    make.top.equalTo(_topWeatherImageView.mas_bottom).with.offset(226);
                    make.width.mas_equalTo(@28);
                    make.height.mas_equalTo(@28);
                    
                    
                    break;
                case Iphone5:
                    make.top.equalTo(_topWeatherImageView.mas_bottom).with.offset(160);
                    make.width.mas_equalTo(@26);
                    make.height.mas_equalTo(@26);
                    break;
                case Iphone4:{
                    make.top.equalTo(_topWeatherImageView.mas_bottom).with.offset(130);
                    make.width.mas_equalTo(@26);
                    make.height.mas_equalTo(@26);

                    break;
                }
                default:
                    break;
            }


        }];
    }
    
    {
        _dateLabel = [UILabel new];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor whiteColor];
        [self addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.greaterThanOrEqualTo(@0);
            switch ((NSInteger)ScreenHeigth) {
                case Iphone6:
                case Iphone6p:
                    make.top.equalTo(_bottomWeatherImageView.mas_bottom).with.offset(48);
                    
                    
                    break;
                case Iphone5:
                    make.top.equalTo(_bottomWeatherImageView.mas_bottom).with.offset(34);
                    break;
                case Iphone4:{
                    make.top.equalTo(_bottomWeatherImageView.mas_bottom).with.offset(24);

                    break;
                }
                default:
                    break;
            }


        }];
    }
    

    {
        _windLabel = [UILabel new];
        _windLabel.textAlignment = NSTextAlignmentCenter;
        _windLabel.textColor = [UIColor whiteColor];
        [self addSubview:_windLabel];
        [_windLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.greaterThanOrEqualTo(@0);
            switch ((NSInteger)ScreenHeigth) {
                case Iphone6:{
                    make.top.equalTo(_bottomWeatherImageView.mas_bottom).with.offset(190);

                    break;
                }
                case Iphone6p:
                    make.top.equalTo(_bottomWeatherImageView.mas_bottom).with.offset(218);
                    
                    
                    break;
                case Iphone5:
                    make.top.equalTo(_bottomWeatherImageView.mas_bottom).with.offset(160);
                    break;
                case Iphone4:{
                    make.top.equalTo(_bottomWeatherImageView.mas_bottom).with.offset(134);

                    break;
                }
                default:
                    break;
            }


        }];
    }
    
    {
        _windClassLabel = [UILabel new];
        _windClassLabel.textAlignment = NSTextAlignmentCenter;
        _windClassLabel.textColor = [UIColor whiteColor];
        [self addSubview:_windClassLabel];
        [_windClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_windLabel.mas_bottom).with.offset(6);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.greaterThanOrEqualTo(@0);
            
        }];
        
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                _windLabel.font = [UIFont systemFontOfSize:14];
                _windClassLabel.font = [UIFont systemFontOfSize:14];
                _weekLabel.font = [UIFont systemFontOfSize:14];
                _dateLabel.font = [UIFont systemFontOfSize:14];
                
                break;
            case Iphone5:
            case Iphone4:{
                _windLabel.font = [UIFont systemFontOfSize:14];
                _windClassLabel.font = [UIFont systemFontOfSize:14];
                _weekLabel.font = [UIFont systemFontOfSize:14];
                _dateLabel.font = [UIFont systemFontOfSize:14];
                break;
            }
            default:
                break;
        }

        
    }
    
    
}
- (void)setSelected:(BOOL)selected{
    if (selected) {
        
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}
@end
