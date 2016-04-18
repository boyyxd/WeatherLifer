//
//  CurrentWeatherModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/16.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentWeatherModel : NSObject
/**
 *  温度
 */
@property (assign) double tmp;
/**
 *  风力级别描述
 */
@property (nonatomic, copy) NSString * wind;
/**
 *  空气质量
 */
@property (assign) NSInteger aqi;
/**
 *  背景图片
 */
@property (nonatomic, copy) NSString * bg;
/**
 *  相对湿度
 */
@property (assign) NSInteger hum;
/**
 *  体感温度
 */
@property (assign) NSInteger st;
/**
 *  aqi 描述
 */
@property (nonatomic, copy) NSString * tip_aqi;
/**
 *  体感温度描述
 */
@property (nonatomic, copy) NSString * tip_st;
/**
 *  天气中文描述
 */
@property (nonatomic, copy) NSString * wcn;
/**
 *  天气编码
 */
@property (nonatomic, copy) NSString * wcode;
/**
 *  天气英文描述
 */
@property (nonatomic, copy) NSString * wen;
/**
 *  文字数组
 */

@property (nonatomic, strong) NSArray * wtxt;

- (instancetype)initWithDataDic:(NSDictionary *)dic;
@end
