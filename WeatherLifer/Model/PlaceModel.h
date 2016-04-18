//
//  PlaceModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/25.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject

@property (nonatomic, copy) NSString * city;

@property (nonatomic, copy) NSString * address;

@property (assign) double lon;

@property (assign) double lat;

@property (nonatomic, copy) NSString * nickName;

@end
