//
//  WeekWeatherModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/17.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekWeatherModel : NSObject
/**
 *  空气质量
 */
@property (assign) NSInteger aqi;
/**
 *  时间
 */
@property (nonatomic, copy) NSString * time;
/**
 *  气压提示
 */
@property (nonatomic, copy) NSString * tip_aqi;
/**
 *  最高气温
 */
@property (assign) double tmax;
/**
 *  最低气温
 */
@property (assign) double tmin;
/**
 *  上午天气
 */
@property (nonatomic, copy) NSString * w_am;
/**
 *  下午天气
 */
@property (nonatomic, copy) NSString * w_pm;
/**
 *  风力级别描述
 */
@property (nonatomic, copy) NSString * wclass;

/**
 *  上午天气编码
 */
@property (nonatomic, copy) NSString * wcode_am;

/**
 *  下午天气编码
 */
@property (nonatomic, copy) NSString * wcode_pm;
/**
 *  风向
 */
@property (assign) NSInteger wdir;
/**
 *  风向描述
 */
@property (nonatomic, copy) NSString * wdirdesc;
/**
 *  风速
 */
@property (assign) NSInteger ws;


- (instancetype)initWithDic:(NSDictionary *)dic;



@end
