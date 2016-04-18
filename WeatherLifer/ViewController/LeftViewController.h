//
//  LeftViewController.h
//  WeatherLifer
//
//  Created by ink on 15/6/19.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityViewController.h"
#import "PlaceListData.h"
#import "SettingViewController.h"
#import "PlaceTableViewCell.h"
#import "WeatherIconData.h"
#import "TimeOperation.h"
@protocol SelePlaceDelegate
@required
- (void)selectPlaceWithModel:(PlaceModel*)model andRow:(NSInteger)row;
@end

@interface LeftViewController : UIViewController<AddPlaceDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView * _placeListTableView;//城市列表
    NSMutableArray * placeListArray;//城市列表数组
}
@property (assign, nonatomic ) id<SelePlaceDelegate>delegate;

@property (nonatomic, strong) NSMutableArray * weatherDataArray;//天气数据
- (void)refreshCityWeather;//刷新城市
- (void)addCity;//添加城市
@end
