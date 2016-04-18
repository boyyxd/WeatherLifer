//
//  HourModel.m
//  WeatherLifer
//
//  Created by ink on 15/6/17.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "HourModel.h"

@implementation HourModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.aqi = [[dic objectForKey:@"aqi"] integerValue];
        self.airp = [[dic objectForKey:@"airp"] integerValue];
        self.hum = [[dic objectForKey:@"hum"] integerValue];
        self.st = [[dic objectForKey:@"st"] doubleValue];
        self.time = [[dic objectForKey:@"time"] description];
        self.tip_airp = [[dic objectForKey:@"tip_airp"] description];
        self.tip_aqi = [[dic objectForKey:@"tip_aqi"] description];
        self.tip_hum = [[dic objectForKey:@"tip_hum"] description];
        self.tip_st = [[dic objectForKey:@"tip_st"] description];
        self.tip_wind = [[dic objectForKey:@"tip_wind"] description];
        self.wclass = [[dic objectForKey:@"wclass"] description];
        self.wcn = [[dic objectForKey:@"wcn"] description];
        self.wcode = [[dic objectForKey:@"wcode"] description];
        self.wdir = [[dic objectForKey:@"wdir"] integerValue];
        self.wdirdesc = [[dic objectForKey:@"wdirdesc"] description];
        self.wen = [[dic objectForKey:@"wen"] description];
        self.ws = [[dic objectForKey:@"ws"] doubleValue];
        
    }
    return self;
}
@end
