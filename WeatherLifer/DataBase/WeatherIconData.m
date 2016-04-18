//
//  WeatherIconData.m
//  WeatherLifer
//
//  Created by ink on 15/3/24.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeatherIconData.h"
@implementation WeatherIconData

+ (WeatherIconModel *)getWeatherIcon:(NSInteger)weatherCode{
    FMDatabase * dataBase = [WeatherSqlData setup];
    
    NSString * selectString = [NSString stringWithFormat:@"select * from weatheriocn where weathercode = '%ld'",(long)weatherCode];
    FMResultSet * set = [dataBase executeQuery:selectString];
    WeatherIconModel * model = [WeatherIconModel new];

    while ([set next]) {
        model.weatherCode = [set stringForColumn:@"weathercode"].integerValue;
        model.dayImageName = [set stringForColumn:@"day"];
        model.nightImageName = [set stringForColumn:@"night"];
        model.dayBg = [set stringForColumn:@"daybg"];
        model.nightBg = [set stringForColumn:@"nightbg"];
    }
    return model;
    
}

@end
