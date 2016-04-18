//
//  WindClass.h
//  WeatherLifer
//
//  Created by ink on 15/6/12.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface WindClass : UIView{
    UIImageView * _classImageView;
    UIImageView * _pointerImageView;

}
@property (nonatomic) float maxValue;
@property (nonatomic) float minValue;
- (void)moveToValue:(CGFloat)value andWindValue:(CGFloat)windValue;
/**
 *  风力
 */
@property (nonatomic, strong) UILabel * windLabel;
/**
 *  风向
 */
@property (nonatomic, strong) UILabel * windDir;


@end
