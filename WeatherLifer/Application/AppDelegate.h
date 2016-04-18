//
//  AppDelegate.h
//  WeatherLifer
//
//  Created by ink on 15/5/26.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BMKMapManager * _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

