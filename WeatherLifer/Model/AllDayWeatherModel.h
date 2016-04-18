//
//  AllDayWeatherModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/16.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllDayWeatherModel : NSObject
/**
 *  天气中文描述
 */
@property (nonatomic, copy) NSString * wcn;
/**
 *  温度
 */
@property (assign) double tmp;
/**
 *  风力级别描述
 */
@property (nonatomic, copy) NSString * wind;
/**
 *  相对湿度
 */
@property (assign) NSInteger hum;
/**
 *  空气质量
 */
@property (assign) NSInteger aqi;
/**
 *  空气质量描述
 */
@property (nonatomic, copy) NSString * tip_aqi;
/**
 *  空气数组
 */
@property (nonatomic, strong) NSArray * aqiArray;

/**
 *  空气数值数组
 */
@property (nonatomic,strong) NSArray * aqiValueArray;
/**
 *  温度数组
 */
@property (nonatomic, strong) NSArray * tempArray;
/**
 *  温度数值数组
 */
@property (nonatomic,strong) NSArray * tempValueArray;


/**
 *  底部分割曲线
 */
@property (nonatomic, strong) NSArray * bottomArray;
/**
 *  底部数据数组
 */
@property (nonatomic, strong) NSArray * bottomValueArray;
/**
*  空气质量语言
*/
@property (nonatomic, copy) NSString * text_aqi;

/**
 *  温度语言
 */
@property (nonatomic, copy) NSString * text_st;

/**
 *  下雨语言
 */
@property (nonatomic, copy) NSString *  rain_text;
/**
 *  下雨数据数组
 */

@property (nonatomic, strong) NSMutableArray * rainArray;
/**
 *  开始时间
 */
@property (nonatomic, copy) NSString * startTime;



- (instancetype)initWithDic:(NSDictionary *)dic;
@end
