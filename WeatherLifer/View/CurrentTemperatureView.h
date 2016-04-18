//
//  CurrentTemperatureView.h
//  WeatherLifer
//
//  Created by ink on 15/5/30.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllDayWeatherModel.h"
#import "ReactiveCocoa.h"
#import "RainView.h"
@protocol HeartDelegate
- (void)heartPress;
@end

@interface CurrentTemperatureView : UIView{
    UILabel * _temperatureLabel;//当前温度
    UILabel * _windClassLabel;//风速等级
    UILabel * _humidityClassLabel;//湿度等级
    UILabel * _airLabel;//空气指数
    UILabel * _airDes;//空气描述
    UILabel * _weatherLabel;//天气
    UIButton * rainButton;//下雨按钮
    UIButton * tempButton;//温度按钮
    UIButton * airButton;//空气按钮
    RainView * _rainView;//下雨视图
    UILabel * funcationLabel;//功能按钮
    UIScrollView * scrollView;//底部滚动试图
    UILabel * smallRainLabel;
    UILabel * middleRainLabel;
    UILabel * largeRainLabel;
    UILabel * stromRainLabel;
    
}

@property (nonatomic, strong) UILabel * describeLabel;//状况描述
//@property (nonatomic, strong) UILabel * windClassLabel;
//@property (nonatomic, strong) UILabel * humL
@property (nonatomic, strong) AllDayWeatherModel * model;
@property (nonatomic, assign) id<HeartDelegate>delegate;

@end
