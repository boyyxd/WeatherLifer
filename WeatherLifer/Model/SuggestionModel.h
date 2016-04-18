//
//  SuggestionModel.h
//  WeatherLifer
//
//  Created by ink on 15/6/25.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuggestionModel : NSObject
@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * city;

@property (nonatomic, copy) NSString * district;

@property (nonatomic, strong) NSValue * ptValue;
@end
