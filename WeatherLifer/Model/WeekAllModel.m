//
//  WeekAllModel.m
//  WeatherLifer
//
//  Created by ink on 15/6/17.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekAllModel.h"

@implementation WeekAllModel
- (instancetype)initWithArray:(NSArray *)darray
{
    self = [super init];
    if (self) {
        self.dataArray = darray;
    }
    return self;
}
@end
