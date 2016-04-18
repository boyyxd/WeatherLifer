//
//  RootViewController.h
//  WeatherLifer
//
//  Created by ink on 15/5/27.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "LocationManager.h"
#import "CustomNavgationBar.h"
#import "GPUImage.h"
#import "TextAndTemperatureView.h"
#import "CurrentTemperatureView.h"
#import "AFHTTPRequestOperationManager.h"
#import "WeekWeatherView.h"
#import "WeekDetailView.h"
#import "EffectTableViewCell.h"
#import "UrlDefine.h"
#import "JSONKit.h"
#import "WeatherNetWork.h"
#import "CurrentWeatherModel.h"
#import "AllDayWeatherModel.h"
#import "WeekAllModel.h"
#import "WeekWeatherModel.h"
#import "HourDetailModel.h"
#import "UIViewController+MMDrawerController.h"
#import "MJRefresh.h"
#import "PlaceModel.h"
#import "LeftViewController.h"
#import "UIImage+ImageEffects.h"
#import "PlaceListData.h"
#import "ShareView.h"
#import "AFNetworkReachabilityManager.h"
#import "LoadingView.h"
#import "PlaceListData.h"
typedef enum :NSInteger {
    
    kCameraMoveDirectionNone,
    
    kCameraMoveDirectionUp,
    
    kCameraMoveDirectionDown,
    
    kCameraMoveDirectionRight,
    
    kCameraMoveDirectionLeft
    
} CameraMoveDirection;


@interface RootViewController : UIViewController<CustomNavgationBarDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,SelePlaceDelegate,ShareDelegate,SelectDateDelegate,ShareButtonDelegate,HeartDelegate,UIAlertViewDelegate,LocationDelegate>{
    UIScrollView * _basicScrollView;//滚动试图
    UIImageView * _backImageView;//背景图片
    TextAndTemperatureView * _textView;//文字和温度视图
    CurrentTemperatureView * _currentTempView;//短临以及当前温度
    WeekWeatherView * _weekWeatherView;//七天情况视图
    WeekDetailView * _weekDeatilView;//温度详细视图
    AFHTTPRequestOperationManager * netWorkManager;//网络数据请求管理器
    NSInteger cureentSelect;//当前城市选择位置
    PlaceModel * otherPlaceModel;//当前城市model
    ShareView * _shareView;//分享视图
    BOOL isShare;//当前分享状态
    NSDate * enterDate;//进入后台日期
    UITapGestureRecognizer * mainTap;//主页面点击手势
    CGFloat shareHeigth;//分享视图的高度
    CameraMoveDirection direction;//手势方向
    LoadingView * loadingView;//加载视图
    NSString * currenCity;//当前城市
    PhotoModel * photoModel;//照片当前model
}

@end
