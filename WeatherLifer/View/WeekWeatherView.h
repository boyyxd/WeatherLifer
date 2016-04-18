//
//  WeekWeatherView.h
//  WeatherLifer
//
//  Created by ink on 15/6/4.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekCollectionViewCell.h"
#import "WeekLine.h"
#import "WeekWeatherModel.h"
#import "WeekAllModel.h"
#import "ReactiveCocoa.h"
#import "WeatherIconData.h"
#import "TimeOperation.h"
#import "WeekAirLine.h"
@protocol SelectDateDelegate
- (void)selectDate:(NSInteger)dateNum;
@end

@interface WeekWeatherView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView * _weekCollectionView;
    WeekLine * _weekLine;
    WeekAirLine * _weekAirLine;
    CGFloat lineHeight;
    CGFloat topToBottom;
    
}
/**
 *  七天数据数组
 */
@property (nonatomic, strong) NSMutableArray * weekDataArray;
@property (nonatomic, strong) WeekAllModel * model;
@property (nonatomic, assign) id<SelectDateDelegate>delegate;


@end
