//
//  AllDayWeatherModel.m
//  WeatherLifer
//
//  Created by ink on 15/6/16.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "AllDayWeatherModel.h"

@implementation AllDayWeatherModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.wcn = [[dic objectForKey:@"wcn"] description];
        self.tmp = [[dic objectForKey:@"tmp"] doubleValue];
        self.wind = [[dic objectForKey:@"wind"] description];
        self.hum = [[dic objectForKey:@"hum"] integerValue];
        self.aqi = [[dic objectForKey:@"aqi"] integerValue];
        self.tip_aqi = [[dic objectForKey:@"tip_aqi"] description];
        self.text_aqi = [[dic objectForKey:@"txt_aqi"] description];
        self.text_st = [[dic objectForKey:@"txt_st"] description];
        self.rain_text = [[dic objectForKey:@"msg"] description];
        self.aqiArray = [dic objectForKey:@"aqiLine"];
        self.tempArray = [dic objectForKey:@"tempLine"];
        self.bottomArray = [dic objectForKey:@"bottomLine"];
        self.aqiValueArray = [dic objectForKey:@"aqiValue"];
        self.tempValueArray = [dic objectForKey:@"tempValue"];
        self.bottomValueArray = [dic objectForKey:@"bottomValue"];
        self.rainArray = [dic objectForKey:@"series"];
        self.startTime = [[dic objectForKey:@"startTime"] description];
    }
    return self;
}
@end
