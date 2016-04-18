//
//  WeatherSqlData.m
//  WeatherLifer
//
//  Created by ink on 15/3/24.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeatherSqlData.h"
static FMDatabase * dbPointer;

@implementation WeatherSqlData
+ (FMDatabase *) setup{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Weather" ofType:@"db"];
    
    dbPointer = [FMDatabase databaseWithPath:path];
    if (![dbPointer open]) {
        NSLog(@"打开失败");
        return 0;
    }
    
    
    
    
    return dbPointer;
}
+ (void) close{
    if (dbPointer) {
        [dbPointer close];
        dbPointer = NULL;
    }
}


@end
