//
//  WeatherIconModel.h
//  WeatherLifer
//
//  Created by ink on 15/3/24.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherIconModel : NSObject
@property (assign) NSInteger weatherCode;
/**
 *  白天的天气图标
 */
@property (nonatomic,copy) NSString * dayImageName;
/**
 *  晚上的天气图标
 */
@property (nonatomic,copy) NSString * nightImageName;
/**
 *  白天天气背景图片
 */

@property (nonatomic,copy) NSString * dayBg;
/**
 *  夜晚天气背景图片
 */
@property (nonatomic,copy) NSString * nightBg;

@end
