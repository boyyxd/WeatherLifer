//
//  PlaceListData.h
//  WeatherLifer
//
//  Created by ink on 15/6/26.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceDataBase.h"
#import "PlaceModel.h"
@interface PlaceListData : NSObject
+ (BOOL)addPlaceData:(PlaceModel *)model;
+ (NSArray *)getPlaceList;
+ (BOOL)deletePlaceWithLon:(double) lon AndLat:(double)lat;
@end
