//
//  WeatherSqlData.h
//  WeatherLifer
//
//  Created by ink on 15/3/24.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface WeatherSqlData : NSObject
+ (FMDatabase *) setup;
+ (void) close;
@end
