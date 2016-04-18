//
//  WeatherIconData.h
//  WeatherLifer
//
//  Created by ink on 15/3/24.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherSqlData.h"
#import "WeatherIconModel.h"
@interface WeatherIconData : NSObject
+ (WeatherIconModel *)getWeatherIcon:(NSInteger)weatherCode;
@end
