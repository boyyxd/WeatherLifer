//
//  WeekAllModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/17.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekAllModel : NSObject
@property (nonatomic, strong) NSArray * dataArray;
- (instancetype)initWithArray:(NSArray *)darray;
@end
