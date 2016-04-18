//
//  CurrentWeatherModel.m
//  WeatherLifer
//
//  Created by ink on 15/6/16.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CurrentWeatherModel.h"

@implementation CurrentWeatherModel
- (instancetype)initWithDataDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.tmp = [[dic objectForKey:@"tmp"] doubleValue];
        self.wind = [[dic objectForKey:@"wind"] description];
        self.aqi = [[dic objectForKey:@"aqi"] integerValue];
        self.bg = [[dic objectForKey:@"bg"] description];
        self.hum = [[dic objectForKey:@"hum"] integerValue];
        self.st = [[dic objectForKey:@"st"] integerValue];
        self.tip_aqi = [[dic objectForKey:@"tip_aqi"] description];
        self.tip_st = [[dic objectForKey:@"tip_st"] description];
        self.wcn = [[dic objectForKey:@"wcn"] description];
        self.wcode = [[dic objectForKey:@"wcode"] description];
        self.wen = [[dic objectForKey:@"wen"] description];
        self.wtxt = [dic objectForKey:@"wtxt"];
    }
    return self;
}
@end
