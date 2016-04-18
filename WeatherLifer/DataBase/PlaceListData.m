//
//  PlaceListData.m
//  WeatherLifer
//
//  Created by ink on 15/6/26.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "PlaceListData.h"

@implementation PlaceListData
+ (BOOL)addPlaceData:(PlaceModel *)model{
    FMDatabase * db = [PlaceDataBase setup];
    NSString * creatString = @"create table if not exists placeList(city,address,lon,lat,nickName)";
    BOOL creatFlag = [db executeUpdate:creatString];
    if (creatFlag) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
        
    }
    NSString * insertString = [NSString stringWithFormat:@"insert into placeList(city,address,lon,lat,nickName) values('%@','%@','%f','%f','%@')",model.city,model.address,model.lon,model.lat,model.nickName];
    BOOL insertFlag = [db executeUpdate:insertString];
    [PlaceDataBase close];
    return insertFlag;
}
+ (NSArray *)getPlaceList{
    FMDatabase * db = [PlaceDataBase setup];
    NSString * selectString = @"select * from placeList";
    NSMutableArray * placeArray = [NSMutableArray array];
    FMResultSet * rs = [db executeQuery:selectString];
    while ([rs next]) {
        PlaceModel * model = [PlaceModel new];
        model.city = [rs stringForColumn:@"city"];
        model.address = [rs stringForColumn:@"address"];
        model.lon = [[rs stringForColumn:@"lon"] doubleValue];
        model.lat = [[rs stringForColumn:@"lat"] doubleValue];
        model.nickName = [rs stringForColumn:@"nickName"];
        [placeArray addObject:model];
    }
    return placeArray;
}
+ (BOOL)deletePlaceWithLon:(double) lon AndLat:(double)lat{
    FMDatabase * db = [PlaceDataBase setup];
    NSString * deleteString = [NSString stringWithFormat:@"delete from placeList where lon = '%f' and lat = '%f'",lon,lat];
    BOOL deleteFlag = [db executeUpdate:deleteString];
    return deleteFlag;
}
@end
