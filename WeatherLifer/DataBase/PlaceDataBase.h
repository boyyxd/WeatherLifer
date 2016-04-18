//
//  PlaceDataBase.h
//  WeatherLifer
//
//  Created by ink on 15/6/25.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface PlaceDataBase : NSObject
+ (FMDatabase *) setup;
+ (void) close;

@end
