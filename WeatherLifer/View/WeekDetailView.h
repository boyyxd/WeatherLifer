//
//  WeekDetailView.h
//  WeatherLifer
//
//  Created by ink on 15/6/8.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thermomter.h"
#import "CircleRing.h"
#import "CircleView.h"
#import "AirPressure.h"
#import "WindClass.h"
#import "WeekDayCollectionViewCell.h"
#import "EffectTableViewCell.h"
#import "HourDetailModel.h"
#import "ReactiveCocoa.h"
#import "HourModel.h"
#import "EveryDayLine.h"
#import "WeekDetailButton.h"
@interface WeekDetailView : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>{
    Thermomter * _thermomter;
    CircleRing * _humidty;
    CircleView * _airQuality;
    AirPressure * _airPressure;
    WindClass * _windClass;
    UICollectionView * _weekCollectionView;
    UITableView * _effectTableView;
    NSArray * effectArray;
    NSArray * effectTapArray;
    NSArray * viewArray;
    UIView * currentView;
    UIScrollView * _lineScrollView;
    NSInteger maxYpoint;
    NSMutableArray * aqiPointArray;
    NSMutableArray * humPointArray;
    NSMutableArray * tempPointArray;
    NSMutableArray * windPointArray;
    NSMutableArray * aqiDivArray;
    NSMutableArray * humDivArray;
    NSMutableArray * tempDivArray;
    NSMutableArray * windDivArray;
    NSMutableArray * pressurePointArray;
    NSInteger ScrollHeight;
    EveryDayLine * lineView;
    HourModel * currentModel;
    WeekDetailButton * _humButton;
    WeekDetailButton * _aqiButton;
    WeekDetailButton * _tempButton;
    WeekDetailButton * _windBtton;
    BOOL aqiTap;
    BOOL aqiHigh;
}

@property (nonatomic, strong) HourDetailModel * model;
- (void)selectDateWith:(NSInteger)dateNum;
@end
