//
//  TextAndTemperatureView.h
//  WeatherLifer
//
//  Created by ink on 15/5/28.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentWeatherModel.h"
#import "ReactiveCocoa.h"
#import "WeatherIconData.h"
#import "TimeOperation.h"
#import "TakePhotoViewController.h"
#import "MMDrawerController.h"
#import "PhotoModel.h"

@protocol ShareDelegate
- (void)share;
- (void)takePhotoWithPlace;
@end

@interface TextAndTemperatureView : UIView{
    /**
     *  拍照按钮
     */
    UIButton * _cameraButton;
    UILabel * _authLabel;
    PhotoModel * photoModel;
    CGFloat toTop;

}
/**
 *  温度
 */
@property (nonatomic, strong)UILabel * temperatureLaber;
/**
 *  地点
 */
@property (nonatomic, strong)UILabel * locationLabel;
/**
 *  文字
 */
@property (nonatomic, strong)UILabel * textLabel;

@property (nonatomic, strong)UILabel * textLabelS;

@property (nonatomic, strong)UILabel * textLabelT;
/**
 *  天气图标
 */
@property (nonatomic, strong) UIImageView * weatherImageView;
/**
 *  分享按钮
 */
@property (nonatomic, strong) UIButton * shareButton;
@property (nonatomic, strong) CurrentWeatherModel * model;
@property (nonatomic, assign) id<ShareDelegate>delegate;

- (void)startAnimation;
- (void)changeToBack;
- (void)changeToFront;
- (void)closeShare;
- (void)chageCity;
@end
