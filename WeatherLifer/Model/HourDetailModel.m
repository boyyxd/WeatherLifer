//
//  HourDetailModel.m
//  WeatherLifer
//
//  Created by ink on 15/6/17.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "HourDetailModel.h"
#import "HourModel.h"
@implementation HourDetailModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        NSMutableArray * array = [NSMutableArray array];

        NSArray * dataArray = [dic objectForKey:@"W_24h"];
        for (int i = 0; i < dataArray.count; i++) {
            HourModel * model = [[HourModel alloc] initWithDic:dataArray[i]];
            if (i > 0) {
                NSDictionary * otherDic = dataArray[i - 1];
                HourModel * judgeModel = [[HourModel alloc] initWithDic:otherDic];
                if (![[model.time substringToIndex:10] isEqualToString:[judgeModel.time substringToIndex:10  ]]) {
                    [array addObject:model];
                }

                
            }else{
                [array addObject:model];
            }
            self.contentDataArray = array;
            
        }
        self.windBottomArray = [dic objectForKey:@"sum_wind"];
        self.weatherBottomArray = [dic objectForKey:@"sum_w"];
        self.stBottomArray = [dic objectForKey:@"sum_st"];
        self.humBottomArray = [dic objectForKey:@"sum_hum"];
        self.aqiBottomArray = [dic objectForKey:@"sum_aqi"];
        self.airpBottomArray = [dic objectForKey:@"sum_airp"];

    
    }
    return self;
}
@end
