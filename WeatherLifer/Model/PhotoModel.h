//
//  PhotoModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/27.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject
@property (nonatomic, copy) NSString * imageName;

@property (assign) double  temp;

@property (nonatomic, strong) NSArray * textArray;


@end
