//
//  WeekCollectionViewCell.h
//  WeatherLifer
//
//  Created by ink on 15/6/4.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface WeekCollectionViewCell : UICollectionViewCell
/**
 *  星期
 */
@property (nonatomic, strong) UILabel * weekLabel;

/**
 *  顶部天气图标
 */
@property (nonatomic, strong) UIImageView * topWeatherImageView;
/**
 *  底部天气图标
 */
@property (nonatomic, strong) UIImageView * bottomWeatherImageView;
/**
 *  日期
 */
@property (nonatomic, strong) UILabel * dateLabel;
/**
 *  风力状况
 */
@property (nonatomic, strong) UILabel * windLabel;
/**
 *  风力等级
 */
@property (nonatomic, strong) UILabel * windClassLabel;
@end
