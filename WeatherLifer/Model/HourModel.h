//
//  HourModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/17.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourModel : NSObject
/**
 *  气压
 */
@property (assign) NSInteger airp;
/**
 *  空气质量
 */
@property (assign) NSInteger aqi;
/**
 *  相对湿度
 */
@property (assign) NSInteger hum;
/**
 *  体感温度
 */
@property (assign) double st;
/**
 *  时间
 */
@property (nonatomic, copy) NSString * time;
/**
 *  气压提示
 */
@property (nonatomic, copy) NSString * tip_airp;
/**
 *  空气质量提示
 */
@property (nonatomic, copy) NSString * tip_aqi;
/**
 *  相对湿度提示
 */
@property (nonatomic, copy) NSString * tip_hum;

/**
 *  体感温度提示
 */
@property (nonatomic, copy) NSString * tip_st;

/**
 *  风力提示
 */
@property (nonatomic, copy) NSString * tip_wind;
/**
 *  风力描述
 */
@property (nonatomic, copy) NSString * wclass;
/**
 *  天气中文描述
 */

@property (nonatomic, copy) NSString * wcn;

/**
 *  天气编码
 */
@property (nonatomic, copy) NSString * wcode;

/**
 *  风向角度
 */
@property (assign) NSInteger wdir;
/**
 *  风向描述
 */
@property (nonatomic, copy) NSString * wdirdesc;

/**
 *  天气英文描述
 */
@property (nonatomic, copy) NSString * wen;
/**
 *  风速
 */
@property (assign) double ws;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
