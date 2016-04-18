//
//  TimeOperation.m
//  WeatherLifer
//
//  Created by ink on 15/4/23.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "TimeOperation.h"

@implementation TimeOperation
+ (BOOL)judgeTheTime:(NSDate *)date{
    BOOL isMoring;
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.locale = locale;
    [formatter setDateFormat:@"aa"];
    NSString * judgeString =[formatter stringFromDate:date];
    [formatter setDateFormat:@"h"];
    NSInteger hourTime = [formatter stringFromDate:date].integerValue;
    [formatter setDateFormat:@"h:mm"];
    if ([judgeString isEqualToString:@"上午"]) {
        if (hourTime >= 7 && hourTime < 12) {
            isMoring = YES;
        }else{
            isMoring = NO;
        }
    }else{
        if (hourTime >= 7 && hourTime <12) {
            isMoring = NO;
        }else{
            isMoring = YES;
        }
    }
    return isMoring;
    
}

@end
