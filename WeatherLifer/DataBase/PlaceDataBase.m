//
//  PlaceDataBase.m
//  WeatherLifer
//
//  Created by ink on 15/6/25.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "PlaceDataBase.h"
static FMDatabase * dbPointer;
@implementation PlaceDataBase
+ (FMDatabase *) setup{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [paths objectAtIndex:0];
    NSString * dbpath = [documentDirectory stringByAppendingPathComponent:@"PlaceList.db"];
    dbPointer = [FMDatabase databaseWithPath:dbpath];
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
