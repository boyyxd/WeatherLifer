//
//  HourDetailModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/17.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourDetailModel : NSObject
/**
 *  基础数据
 */
@property (nonatomic,strong) NSArray * contentDataArray;

/**
 *  底部风力分割
 */
@property (nonatomic, strong) NSArray *windBottomArray;


/**
 *  底部天气分割
 */
@property (nonatomic, strong) NSArray * weatherBottomArray;

/**
 *  底部体感温度分割
 */
@property (nonatomic, strong) NSArray * stBottomArray;

/**
 *  底部湿度分割
 */
@property (nonatomic, strong) NSArray * humBottomArray;
/**
 *  底部空气质量分割
 */
@property (nonatomic, strong) NSArray * aqiBottomArray;

/**
 *  底部气压分割
 */
@property (nonatomic, strong) NSArray * airpBottomArray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
