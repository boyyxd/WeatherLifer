//
//  TemperatureStraightLine.h
//  WeatherLifer
//
//  Created by ink on 15/6/1.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "TimeOperation.h"
#import "WeatherIconData.h"

@interface TemperatureStraightLine : UIView{
    CAShapeLayer * lineLayer;
    NSMutableArray * labelArray;
    CGGradientRef gradient;
    NSMutableArray * imageArray;
    NSMutableArray * timeLabelArray;
    
}
/**
 *  坐标点数组
 */
@property (nonatomic, strong) NSMutableArray * pointArray;
/**
 *  数据数组
 */
@property (nonatomic, strong) NSMutableArray * valueArray;
/**
 *  底部坐标数组
 */
@property (nonatomic, strong) NSMutableArray * bottomPointArray;
/**
 *  底部图表数组
 */
@property (nonatomic, strong) NSMutableArray * bottomValueArray;

@property (nonatomic, copy) NSString * startTime;
- (void)initTemperatureLable;

- (void)startAnimation;

@property (assign) BOOL Aqi;

@end
