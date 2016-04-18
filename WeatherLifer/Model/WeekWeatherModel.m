//
//  WeekWeatherModel.m
//  WeatherLifer
//
//  Created by ink on 15/6/17.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekWeatherModel.h"

@implementation WeekWeatherModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.aqi = [[dic objectForKey:@"aqi"] integerValue];
        self.time = [[dic objectForKey:@"time"] description];
        self.tip_aqi = [[dic objectForKey:@"tip_aqi"] description];
        self.tmax = [[dic objectForKey:@"tmax"] doubleValue];
        self.tmin = [[dic objectForKey:@"tmin"] doubleValue];
        self.w_am = [[dic objectForKey:@"w_am"] description];
        self.w_pm = [[dic objectForKey:@"w_pm"] description];
        self.wclass = [[dic objectForKey:@"wclass"] description];
        self.wcode_am = [[dic objectForKey:@"wcode_am"] description];
        self.wcode_pm = [[dic objectForKey:@"wcode_pm"] description];
        self.wdir = [[dic objectForKey:@"wdir"] integerValue];
        self.wdirdesc = [[dic objectForKey:@"wdirdesc"] description];
        self.ws = [[dic objectForKey:@"ws"] integerValue];
    }
    return self;
}
@end
