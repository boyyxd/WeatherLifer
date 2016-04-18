//
//  LocationManager.h
//  WeatherLifer
//
//  Created by ink on 15/5/26.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI/BMapKit.h>
#define LastLongitude @"LastLongitude"
#define LastLatitude @"LastLatitude"
#define LastProvince @"LastProvince"
#define LastCity @"LastCity"
#define LastCounty @"LastCounty"
#define LastAddress @"LastAddress"
#import "AFNetworkReachabilityManager.h"
@protocol LocationDelegate
- (void)locationFail;

@end

typedef void (^LocationBlock)(CLLocationCoordinate2D locationCoordinate,BOOL inChina);

@interface LocationManager : NSObject<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UIAlertViewDelegate>


+ (LocationManager *)shareLocationManager;
- (void)getLocationCoordinate:(LocationBlock) locationBlock;
@property (nonatomic, assign) id<LocationDelegate>delegate;
@end
