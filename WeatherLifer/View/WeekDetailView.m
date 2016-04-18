//
//  WeekDetailView.m
//  WeatherLifer
//
//  Created by ink on 15/6/8.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekDetailView.h"
#import "Masonry.h"
#define ItemWith [UIScreen mainScreen].bounds.size.width / 7
#define ItemHeight 34
#define TableCellHeight 34
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define MiniteWidth [UIScreen mainScreen].bounds.size.width / 8.f
#define HourWidth [UIScreen mainScreen].bounds.size.width / 24.0f
#define EffectToTop 134

@implementation WeekDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initArray];
        [self addScrollView];
        [self addLineView];
        [self addHumidty];
        [self addWeekCollectionView];
        [self addEffectTableView];
        [self addEffectButton];
        [self addModelObserver];
        [_effectTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        UIView * lineViewT = [UIView new];
        [self addSubview:lineViewT];
        [lineViewT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top).with.offset(114);
            make.height.mas_equalTo(@0.5);
        }];
        lineViewT.alpha = 0.3;
        lineViewT.backgroundColor = [UIColor whiteColor];

    }
    return self;
}
- (void)addModelObserver{
    @weakify(self);
    [RACObserve(self, self.model) subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            NSLog(@"=============%@",self.model.humBottomArray);
            [self dealData];
        }
    }];
}
- (void)dealData{
    [aqiPointArray removeAllObjects];
    [aqiPointArray addObjectsFromArray:[self getAqiPointWithArray:self.model.contentDataArray]];
    [humPointArray removeAllObjects];
    [humPointArray addObjectsFromArray:[self getHumPointArray:self.model.contentDataArray]];
    [tempPointArray removeAllObjects];
    [tempPointArray addObjectsFromArray:[self getTempPointArray:self.model.contentDataArray]];
    [windPointArray removeAllObjects];
    [windPointArray addObjectsFromArray:[self getWindPointArray:self.model.contentDataArray]];
//    [pressurePointArray addObjectsFromArray:[ self getPressurePointArray:self.model.contentDataArray]];
    [humDivArray removeAllObjects];
    [humDivArray addObjectsFromArray:[self getBottomPointWithArray:self.model.humBottomArray]];
    [aqiDivArray removeAllObjects];
    [aqiDivArray addObjectsFromArray:[self  getBottomPointWithArray:self.model.aqiBottomArray]];
    [tempDivArray removeAllObjects];
    [tempDivArray addObjectsFromArray:[self getBottomPointWithArray:self.model.stBottomArray]];
    [windDivArray removeAllObjects];
    [windDivArray addObjectsFromArray:[self getBottomPointWithArray:self.model.windBottomArray]];
    [lineView.linePointArray removeAllObjects];
    [lineView.linePointArray addObjectsFromArray:humPointArray[0]];
    [lineView.weatherPointArray removeAllObjects];
    [lineView.weatherPointArray addObjectsFromArray: [self getWeatherPointWithArray:self.model.weatherBottomArray]];
    [lineView.divArray removeAllObjects];
    [lineView.divArray addObjectsFromArray: [self getBottomPointWithArray:self.model.humBottomArray]];
    if (currentView != _humidty) {
        _humButton.effectImageView.image = [UIImage imageNamed:effectTapArray[0]];
        _tempButton.effectImageView.image = [UIImage imageNamed:effectArray[2]];
        _windBtton.effectImageView.image = [UIImage imageNamed:effectArray[3]];
        if (!aqiHigh) {
            _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01.png"];
        }else{
            _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02.png"];
            
        }
        
        aqiTap = NO;
        [self addHumidty];
    }

    [lineView setNeedsDisplay];
    
    NSDate * currentDate = [NSDate date];
    NSDate * yesterday = [self getYesterday00Time];
    NSTimeInterval time = [currentDate timeIntervalSinceDate:yesterday];

    [_lineScrollView setContentOffset:CGPointMake(time / 24 / 60 / 60 * ScreenWidth, 0) animated:YES];
    [_weekCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    NSInteger arrayCount = _lineScrollView.contentOffset.x / (MiniteWidth) * 3;
    HourModel * model = [self.model.contentDataArray objectAtIndex:arrayCount];
    currentModel = model;
    [_humidty movehandleToValue:model.hum];
    _humidty.humLabel.text = [NSString stringWithFormat:@"%ld%%",(long)model.hum];

    if (model.aqi > 100) {
        aqiHigh = YES;
    }else{
        aqiHigh = NO;
    }
    if (aqiTap) {
        if (model.aqi > 100) {
            _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02_p2.png"];
            
        }else{
            _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01_p2.png"];
            
        }
        
    }else{
        if (model.aqi > 100) {
            _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02.png"];
            
        }else{
            _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01.png"];
            
        }
        
    }
    _aqiButton.effectLabel.text = model.tip_aqi;
    _humButton.effectLabel.text = model.tip_hum;
    if (![model.tip_hum isEqualToString:@"湿度适中"]) {
        _humButton.effectLabel.textColor = [UIColor yellowColor];
    }else{
        _humButton.effectLabel.textColor = [UIColor whiteColor];
        
    }
    if (![model.tip_aqi isEqualToString:@"空气清新"] && ![model.tip_aqi isEqualToString:@"空气良好"]) {
        _aqiButton.effectLabel.textColor = [UIColor yellowColor];
    }else{
        _aqiButton.effectLabel.textColor = [UIColor whiteColor];
        
    }
    _tempButton.effectLabel.text = model.tip_st;
    if (![model.tip_st isEqualToString:@"体感舒适"]) {
        _tempButton.effectLabel.textColor = [UIColor yellowColor];
    }else{
        _tempButton.effectLabel.textColor = [UIColor whiteColor];
        
    }
    
    _windBtton.effectLabel.text = model.tip_wind;
    if (![model.tip_wind isEqualToString:@"微风习习"] && ![model.tip_wind isEqualToString:@"无风状态"] ) {
        _windBtton.effectLabel.textColor = [UIColor yellowColor];
    }else{
        _windBtton.effectLabel.textColor = [UIColor whiteColor];
        
    }
    

}
- (NSArray *)getWeatherPointWithArray:(NSArray *)array{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSDate * startDate = [self getYesterday00Time];
    [inputFormatter setDateFormat:@"yyyyMMddHH"];
    NSLog(@"%@",startDate);
    NSInteger num = 0;
    for (NSDictionary * tmp  in array) {
        
        [valueArray addObject:[tmp objectForKey:@"wcode"]];
        NSString * time = [[tmp objectForKey:@"tend"] description];
        NSDate * pointdate = [inputFormatter dateFromString:time];
        CGFloat timeIner = [pointdate timeIntervalSinceDate:startDate];
        CGFloat xPoint = ScreenWidth   / 24.0f * (timeIner / 3600);
        [pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(xPoint, 0)]];
        num++;
    }
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];
    
}
/**
 *  获取昨天0点的时间
 *
 *  @return 昨天0点的时间
 */

- (NSDate *)getYesterday00Time{
    NSDate * futureDate = [NSDate dateWithTimeIntervalSinceNow:-1 * 24 * 60 * 60];
    NSTimeZone *gmt = [NSTimeZone localTimeZone];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    [gregorian setTimeZone:gmt];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: futureDate];
    [components setHour: 0];
    [components setMinute:0];
    [components setSecond: 0];
    [components setNanosecond:0];
    NSDate *newDate = [gregorian dateFromComponents: components];
    return newDate;
}

- (NSArray *)getAqiPointWithArray:(NSArray *)array{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    NSMutableArray * dataArray = [NSMutableArray array];

    HourModel * firstModel = array[0];
    double tmax = firstModel.aqi;
    double tmin = firstModel.aqi;
    for (HourModel * model in array) {
        if (model.aqi > tmax) {
            tmax =model.aqi;
        }
        if (model.aqi < tmin) {
            tmin = model.aqi;
            
        }
    }
    NSInteger num = 0;
    for (HourModel * model in array) {
        double aqi = model.aqi;
        CGFloat xPoint = num * MiniteWidth;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        valuePoint.y = (int)round(maxYpoint - maxYpoint / (tmax - tmin) * (aqi - tmin) + 30);
        num++;
        [dataArray addObject:[NSValue valueWithCGPoint:valuePoint]];
        [valueArray addObject:[NSNumber numberWithDouble:aqi]];
    }
    NSMutableArray * tmpArray = [NSMutableArray array];
    for (int i = 0; i < array.count - 3; i += 3) {
        [tmpArray addObject:[array objectAtIndex:i]];
        if (i == array.count - 4) {
            [tmpArray addObject:[array lastObject]];
        }

    }
    NSInteger section = 0;
    for (HourModel * model in tmpArray) {
        double aqi = model.aqi;
        CGFloat xPoint = section * MiniteWidth;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        valuePoint.y =  (int)round(maxYpoint - maxYpoint / (tmax - tmin) * (aqi - tmin)+ 30);
        section++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
    }

    return [NSArray arrayWithObjects:pointArray,valueArray,dataArray, nil];

}
    /**
     *  获取湿度坐标
     *
     *  @param array 数据数组
     *
     *  @return 湿度坐标
     */
- (NSArray *)getHumPointArray:(NSArray *)array{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];

    HourModel * firstModel = array[0];
    double tmax = firstModel.hum;
    double tmin = firstModel.hum;
    for (HourModel * model in array) {
        if (model.hum > tmax) {
            tmax =model.hum;
        }
        if (model.hum < tmin) {
            tmin = model.hum;
            
        }
    }
    for (HourModel * model in array) {
        double hum = model.aqi;
        [valueArray addObject:[NSNumber numberWithDouble:hum]];
    }
    NSMutableArray * tmpArray = [NSMutableArray array];
    for (int i = 0; i < array.count - 3; i += 3) {
        [tmpArray addObject:[array objectAtIndex:i]];
        if (i == array.count - 4) {
            [tmpArray addObject:[array lastObject]];
        }
        
    }
    NSInteger section = 0;
    for (HourModel * model in tmpArray) {
        double hum = model.hum;
        CGFloat xPoint = section * MiniteWidth;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        valuePoint.y = (int)round(maxYpoint - maxYpoint / (tmax - tmin) * (hum - tmin) + 30);
        section++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
    }
    
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];
}
    /**
     *  获取温度坐标
     *
     *  @param array 数据数组
     *
     *  @return 温度坐标数组
     */
- (NSArray *)getTempPointArray:(NSArray *)array{
         NSMutableArray * pointArray = [NSMutableArray array];
         NSMutableArray * valueArray = [NSMutableArray array];
         
         HourModel * firstModel = array[0];
         double tmax = firstModel.st;
         double tmin = firstModel.st;
         for (HourModel * model in array) {
             if (model.st > tmax) {
                 tmax =model.st;
             }
             if (model.st < tmin) {
                 tmin = model.st;
                 
             }
         }
         for (HourModel * model in array) {
             double st = model.st;
             [valueArray addObject:[NSNumber numberWithDouble:st]];
         }
         NSMutableArray * tmpArray = [NSMutableArray array];
         for (int i = 0; i < array.count - 3; i += 3) {
             [tmpArray addObject:[array objectAtIndex:i]];
             if (i == array.count - 4) {
                 [tmpArray addObject:[array lastObject]];
             }
             
         }
         NSInteger section = 0;
         for (HourModel * model in tmpArray) {
             double st = model.st;
             CGFloat xPoint = section * MiniteWidth;
             CGPoint valuePoint;
             valuePoint.x = xPoint;
             valuePoint.y = (int)round(maxYpoint - maxYpoint / (tmax - tmin) * (st - tmin) + 30);
             section++;
             [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
         }
         
         return [NSArray arrayWithObjects:pointArray,valueArray, nil];
     }
/**
 *  获取风力坐标
 *
 *  @param array 数据数组
 *
 *  @return 风力坐标
 */
- (NSArray *)getWindPointArray:(NSArray *)array{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    
    HourModel * firstModel = array[0];
    double tmax = firstModel. ws;
    double tmin = firstModel.ws;
    for (HourModel * model in array) {
        if (model.ws > tmax) {
            tmax =model.ws;
        }
        if (model.ws < tmin) {
            tmin = model.ws;
            
        }
    }
    for (HourModel * model in array) {
        double ws = model.ws;
        [valueArray addObject:[NSNumber numberWithDouble:ws]];
    }
    NSMutableArray * tmpArray = [NSMutableArray array];
    for (int i = 0; i < array.count - 3; i += 3) {
        [tmpArray addObject:[array objectAtIndex:i]];
        if (i == array.count - 4) {
            [tmpArray addObject:[array lastObject]];
        }
        
    }
    NSInteger section = 0;
    for (HourModel * model in tmpArray) {
        double ws = model.ws;
        CGFloat xPoint = section * MiniteWidth;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        valuePoint.y = (int)round(maxYpoint - maxYpoint / (tmax - tmin) * (ws - tmin) + 30);
        section++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
    }
    
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];
}
/**
 *  获取气压坐标数组
 *
 *  @param array 数据数组
 *
 *  @return 气压坐标
 */
- (NSArray *)getPressurePointArray:(NSArray *)array{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    
    HourModel * firstModel = array[0];
    double tmax = firstModel. airp;
    double tmin = firstModel.airp;
    for (HourModel * model in array) {
        if (model.airp > tmax) {
            tmax =model.airp;
        }
        if (model.airp < tmin) {
            tmin = model.airp;
            
        }
    }
    for (HourModel * model in array) {
        double airp = model.airp;
        [valueArray addObject:[NSNumber numberWithDouble:airp]];
    }
    NSMutableArray * tmpArray = [NSMutableArray array];
    for (int i = 0; i < array.count - 3; i += 3) {
        [tmpArray addObject:[array objectAtIndex:i]];
        if (i == array.count - 4) {
            [tmpArray addObject:[array lastObject]];
        }
        
    }
    NSInteger section = 0;
    for (HourModel * model in tmpArray) {
        double airp = model.airp;
        CGFloat xPoint = section * MiniteWidth;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        valuePoint.y = maxYpoint - maxYpoint / (tmax - tmin) * (airp - tmin)+ 20;
        section++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
    }
    
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];
}




- (void)addLineView{
    lineView = [[EveryDayLine alloc] initWithFrame:CGRectMake(ScreenWidth / 2, 30,ScreenWidth * 7, _lineScrollView.frame.size.height - 30)];
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 0.6,
        1.0, 1.0, 1.0, 0.0
    };
    lineView.lineGrandient = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    ;

    
    [_lineScrollView addSubview:lineView];
}
/**
 *  添加滚动视图
 */
- (void)addScrollView{
    _lineScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ScreenHeigth - ScrollHeight, ScreenWidth, ScrollHeight)];
    [self addSubview:_lineScrollView];
    _lineScrollView.backgroundColor = [UIColor clearColor];
    _lineScrollView.contentSize = CGSizeMake(ScreenWidth * 8, 0);
    _lineScrollView.showsHorizontalScrollIndicator = NO;
    _lineScrollView.showsVerticalScrollIndicator = NO;
    _lineScrollView.delegate = self;
    

}
/**
 *  初始化图片数组
 */

- (void)initArray{
    aqiTap = NO;
    aqiHigh = NO;
    effectArray = [NSArray arrayWithObjects:@"ico_humidity.png",@"",@"ico_temp.png",@"ico_wind.png",@"ico_pressure.png", nil];
        effectTapArray = [NSArray arrayWithObjects:@"ico_humidity_p2.png",@"",@"ico_temp_p2.png",@"ico_wind_p2.png",@"ico_pressure_p2.png", nil];
    viewArray = [NSArray arrayWithObjects:[Thermomter class],[AirPressure class],[CircleView class],[CircleRing class],[WindClass class], nil];
    humPointArray = [NSMutableArray array];
    aqiPointArray = [NSMutableArray array];
    tempPointArray = [NSMutableArray array];
    windPointArray = [NSMutableArray array];
    humDivArray = [NSMutableArray array];
    aqiDivArray = [NSMutableArray array];
    tempDivArray = [NSMutableArray array];
    windDivArray = [NSMutableArray array];
    pressurePointArray = [NSMutableArray array];
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6p:
        case Iphone6:{
            maxYpoint = 200;
            ScrollHeight = 380;
            break;
        }
        case Iphone5:{
            maxYpoint = 134;
            ScrollHeight = 300;
            break;
        }
        case Iphone4:{
            maxYpoint = 50;
            ScrollHeight = 232;
            break;
        }
            
            
        default:
            break;
    }
}
/**
 *  添加温度计
 */
- (void)addThermometer{
    UIImage * backImage = [UIImage imageNamed:@"dial_temp.png"];
    _thermomter = [Thermomter new];
    [self addSubview:_thermomter];
    [_thermomter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(EffectToTop);
        make.size.mas_equalTo(backImage.size);
    }];
    currentView = _thermomter;
    _thermomter.minValue = 0;
    _thermomter.maxValue = 100;
    [self removeOtherView:_thermomter];
    [_thermomter movehandleToValue:45 + 1.125 * currentModel.st];
    _thermomter.tempLabel.text = [NSString stringWithFormat:@"%i°",(int)round(currentModel.st)];

}
/**
 *  添加湿度计
 */
- (void)addHumidty{
    _humidty = [[CircleRing alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
    [self addSubview:_humidty];
    [_humidty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(EffectToTop);
        make.size.mas_equalTo(CGSizeMake(162, 162));

    }];
    _humidty.minValue = 0;
    _humidty.maxValue = 100;
    currentView = _humidty;
    [self removeOtherView:_humidty];
    [_humidty movehandleToValue:currentModel.hum];
    _humidty.humLabel.text = [NSString stringWithFormat:@"%ld%%",(long)currentModel.hum];


}
/**
 *  添加空气质量
 */
- (void)addAirQuality{
    _airQuality = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
    [self addSubview:_airQuality];
    [_airQuality mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(EffectToTop);
        make.size.mas_equalTo(CGSizeMake(160, 160));
        
    }];
    _airQuality.minValue = 0;
    _airQuality.maxValue = 100;
    [self removeOtherView:_airQuality];
    currentView = _airQuality;
    [_airQuality movehandleToValue:currentModel.aqi / 5];
    _airQuality.aqiLabel.text = [NSString stringWithFormat:@"%ld",(long)currentModel.aqi];
//    if (currentModel.aqi > 100) {
//        _airQuality.aqiImageView.image = [UIImage imageNamed:@"ico_aqi02.png"];
//        
//    }else{
//        _airQuality.aqiImageView.image = [UIImage imageNamed:@"ico_aqi01.png"];
//        
//    }

}
/**
 *  添加气压
 */
- (void)addAirPressure{
    _airPressure = [AirPressure new];
    [self addSubview:_airPressure];
    [_airPressure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(118);
        make.size.mas_equalTo(CGSizeMake(160, 160));
        
    }];
    _airPressure.minValue = 0;
    _airPressure.maxValue = 100;
    [_airPressure moveToValue:50];
    [self removeOtherView:_airPressure];
    currentView = _airPressure;
}
/**
 *  添加风向
 */
- (void)addWindClass{
    _windClass = [WindClass new];
    [self addSubview:_windClass];
    [_windClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(EffectToTop);
        make.size.mas_equalTo(CGSizeMake(160, 160));
        
    }];
    _windClass.minValue = 0;
    _windClass.maxValue = 20;
    [self removeOtherView:_windClass];
    currentView = _windClass;
    [_windClass moveToValue:[self judgeWindDir:currentModel.wdirdesc] andWindValue:currentModel.ws];
    _windClass.windLabel.text = [NSString stringWithFormat:@"%.1f",currentModel.ws];
    _windClass.windDir.text = currentModel.wdirdesc;

}
/**
 *  添加星期视图
 */
- (void)addWeekCollectionView{
    UICollectionViewFlowLayout * collectionLayout = [UICollectionViewFlowLayout new];
    [collectionLayout setItemSize:CGSizeMake(ItemWith, ItemHeight)];
    collectionLayout.sectionInset = UIEdgeInsetsZero;
    collectionLayout.minimumInteritemSpacing = 0;
    collectionLayout.minimumLineSpacing = 0;
    _weekCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 82, ScreenWidth, ItemHeight) collectionViewLayout:collectionLayout];
    _weekCollectionView.backgroundColor = [UIColor clearColor];
    _weekCollectionView.delegate = self;
    _weekCollectionView.dataSource = self;
    _weekCollectionView.scrollEnabled = NO;
    _weekCollectionView.showsHorizontalScrollIndicator = NO;
    _weekCollectionView.showsVerticalScrollIndicator = NO;
    [_weekCollectionView registerClass:[WeekDayCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_weekCollectionView];
}
- (void)addEffectTableView{
//    _effectTableView = [UITableView new];
//    _effectTableView.dataSource = self;
//    _effectTableView.delegate = self;
//    _effectTableView.backgroundColor = [UIColor clearColor];
//    _effectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _effectTableView.scrollEnabled = NO;
//    [self addSubview:_effectTableView];
//    [_effectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.top.equalTo(self.mas_top).with.offset(116);
//        make.width.mas_equalTo(@150);
//        make.height.mas_equalTo(TableCellHeight * 7);
//    }];
}
- (void)addEffectButton{
    _humButton = [[WeekDetailButton alloc] init];
    [self addSubview:_humButton];
    [_humButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top).with.offset(140);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(TableCellHeight);
    }];
    _humButton.tag = 0;
    [_humButton addTarget:self action:@selector(selectEffectButton:) forControlEvents:UIControlEventTouchUpInside];
    _aqiButton = [WeekDetailButton new];
    [self addSubview:_aqiButton];
    [_aqiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_humButton.mas_bottom).with.offset(6);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(TableCellHeight);
    }];
    _aqiButton.tag = 1;
    [_aqiButton addTarget:self action:@selector(selectEffectButton:) forControlEvents:UIControlEventTouchUpInside];

    _tempButton = [WeekDetailButton new];
    [self addSubview:_tempButton];
    [_tempButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_aqiButton.mas_bottom).with.offset(6);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(TableCellHeight);
    }];
    _tempButton.tag = 2;
    [_tempButton addTarget:self action:@selector(selectEffectButton:) forControlEvents:UIControlEventTouchUpInside];

    
    _windBtton = [WeekDetailButton new];
    [self addSubview:_windBtton];
    [_windBtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_tempButton.mas_bottom).with.offset(6);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(TableCellHeight);
    }];
    _windBtton.tag = 3;
    [_windBtton addTarget:self action:@selector(selectEffectButton:) forControlEvents:UIControlEventTouchUpInside];

    _humButton.effectImageView.image = [UIImage imageNamed:effectTapArray[0]];
    _tempButton.effectImageView.image = [UIImage imageNamed:effectArray[2]];
    _windBtton.effectImageView.image = [UIImage imageNamed:effectArray[3]];

    

    
    
}
- (void)selectEffectButton:(UIButton *)button{
    switch (button.tag) {
        case 0:{
            if (currentView != _humidty) {
                _humButton.effectImageView.image = [UIImage imageNamed:effectTapArray[0]];
                _tempButton.effectImageView.image = [UIImage imageNamed:effectArray[2]];
                _windBtton.effectImageView.image = [UIImage imageNamed:effectArray[3]];
                if (!aqiHigh) {
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01.png"];
                }else{
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02.png"];
                    
                }

                aqiTap = NO;
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:humPointArray[0]];
                [lineView.divArray removeAllObjects];
                [lineView.divArray addObjectsFromArray:humDivArray];
                [lineView setNeedsDisplay];
                [self addHumidty];
            }
            break;
        }
        case 1:{
            if (currentView != _airQuality) {
                _humButton.effectImageView.image = [UIImage imageNamed:effectArray[0]];
                _tempButton.effectImageView.image = [UIImage imageNamed:effectArray[2]];
                _windBtton.effectImageView.image = [UIImage imageNamed:effectArray[3]];
                aqiTap = YES;
                if (!aqiHigh) {
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01_p2.png"];
                }else{
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02_p2.png"];

                }
                [self addAirQuality];
                [lineView.divArray removeAllObjects];
                [lineView.divArray addObjectsFromArray:aqiDivArray];
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:aqiPointArray[0]];
                [lineView setNeedsDisplay];
                
            }
            break;
        }
        case 2:{
            if (currentView != _thermomter) {
                _humButton.effectImageView.image = [UIImage imageNamed:effectArray[0]];
                _tempButton.effectImageView.image = [UIImage imageNamed:effectTapArray[2]];
                _windBtton.effectImageView.image = [UIImage imageNamed:effectArray[3]];
                if (!aqiHigh) {
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01.png"];
                }else{
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02.png"];
                    
                }

                aqiTap = NO;
                [self addThermometer];
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:tempPointArray[0]];
                [lineView.divArray removeAllObjects];
                [lineView.divArray addObjectsFromArray:tempDivArray];
                [lineView setNeedsDisplay];
            }
            break;
        }
        case 3:{
            if (currentView != _windClass) {
                _humButton.effectImageView.image = [UIImage imageNamed:effectArray[0]];
                _tempButton.effectImageView.image = [UIImage imageNamed:effectArray[2]];
                _windBtton.effectImageView.image = [UIImage imageNamed:effectTapArray[3]];
                if (!aqiHigh) {
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01.png"];
                }else{
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02.png"];
                    
                }

                aqiTap = NO;
                [self addWindClass];
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:windPointArray[0]];
                [lineView.divArray removeAllObjects];
                [lineView.divArray addObjectsFromArray:windDivArray];
                [lineView setNeedsDisplay];
                
            }
            break;
        }
            
        default:
            break;
    }

}
#pragma mark- collectionviewDateSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cell";
    WeekDayCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.dayLabel.text = @"昨天";
    }else if (indexPath.row == 1){
        cell.dayLabel.text = @"今天";
        
    }else{

        cell.dayLabel.text = [self weekdayStringFromDate:[NSDate dateWithTimeInterval:(indexPath.row - 1)  * 3600 * 24 sinceDate:[NSDate date]]];
        NSLog(@"%@",[NSDate dateWithTimeInterval:indexPath.row  * 3600 sinceDate:[NSDate date]]);
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        [self setCurrentScroll];
    }else{
        [_lineScrollView setContentOffset:CGPointMake(ScreenWidth* indexPath.row + ScreenWidth / 2, 0) animated:YES];
    }
}
-(void)setCurrentScroll{
    NSDate * currentDate = [NSDate date];
    NSDate * yesterday = [self getYesterday00Time];
    NSTimeInterval time = [currentDate timeIntervalSinceDate:yesterday];
    
    [_lineScrollView setContentOffset:CGPointMake(time / 24 / 60 / 60 * ScreenWidth, 0) animated:YES];
    
    
    
}


#pragma mark- tableViewDateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString * cellIdentifier = @"cell";
    EffectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[EffectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectImageName = effectTapArray[indexPath.row];
    cell.unSelectImageName = effectArray[indexPath.row];
    if (indexPath.row == 1) {
        
        cell.effectImageView.image = [UIImage imageNamed:@"ico_aqi01.png"];
    }else{
        cell.effectImageView.image = [UIImage imageNamed:effectArray[indexPath.row]];
    }
    cell.effectLabel.text = @"温度舒适";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TableCellHeight;
}
#pragma mark- tableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            if (currentView != _humidty) {
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:humPointArray[0]];
                [lineView setNeedsDisplay];
                [self addHumidty];
            }
            break;
        }
        case 1:{
            if (currentView != _airQuality) {
                
                [self addAirQuality];
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:aqiPointArray[0]];
                [lineView setNeedsDisplay];

            }
            break;
        }
        case 2:{
            if (currentView != _thermomter) {
                
                [self addThermometer];
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:tempPointArray[0]];
                [lineView setNeedsDisplay];
            }
            break;
        }
        case 3:{
            if (currentView != _windClass) {
                
                [self addWindClass];
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:windPointArray[0]];
                [lineView setNeedsDisplay];

            }
            break;
        }
        case 4:{
            if (currentView != _airPressure) {
                
                [self addAirPressure];
                [lineView.linePointArray removeAllObjects];
                [lineView.linePointArray addObjectsFromArray:pressurePointArray[0]];
                [lineView setNeedsDisplay];
            }
            break;
        }
            
        default:
            break;
    }
}
- (void)removeOtherView:(UIView *)view{
    if (view == _thermomter) {
        [_humidty removeFromSuperview];
        [_airPressure removeFromSuperview];
        [_windClass removeFromSuperview];
        [_airQuality removeFromSuperview];
    }else if (view == _humidty){
        [_thermomter removeFromSuperview];
        [_airPressure removeFromSuperview];
        [_windClass removeFromSuperview];
        [_airQuality removeFromSuperview];

    }else if (view == _airPressure){
        [_humidty removeFromSuperview];
        [_thermomter removeFromSuperview];
        [_windClass removeFromSuperview];
        [_airQuality removeFromSuperview];

    }else if (view == _windClass){
        [_humidty removeFromSuperview];
        [_airPressure removeFromSuperview];
        [_thermomter removeFromSuperview];
        [_airQuality removeFromSuperview];

    }else if (view == _airQuality){
        [_humidty removeFromSuperview];
        [_airPressure removeFromSuperview];
        [_windClass removeFromSuperview];
        [_thermomter removeFromSuperview];

    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [lineView setCirclePoint:scrollView.contentOffset.x];
        if (scrollView.contentOffset.x < 7 * ScreenWidth && scrollView.contentOffset.x >= 0) {
                NSInteger arrayCount = scrollView.contentOffset.x / (MiniteWidth) * 3;
            HourModel * model = [self.model.contentDataArray objectAtIndex:arrayCount];
            currentModel = model;
            [_humidty movehandleToValue:model.hum];
            _humidty.humLabel.text = [NSString stringWithFormat:@"%ld%%",(long)model.hum];
            [_thermomter movehandleToValue:45 + 1.125 * model.st];
            _thermomter.tempLabel.text = [NSString stringWithFormat:@"%i°",(int)round(model.st)];
            if (model.aqi > 100) {
                aqiHigh = YES;
            }else{
                aqiHigh = NO;
            }
            if (aqiTap) {
                if (model.aqi > 100) {
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02_p2.png"];

                }else{
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01_p2.png"];

                }

            }else{
                if (model.aqi > 100) {
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi02.png"];
                    
                }else{
                    _aqiButton.effectImageView.image = [UIImage imageNamed:@"ico_aqi01.png"];
                    
                }
 
            }
            [_airQuality movehandleToValue:model.aqi / 3];
            _airQuality.aqiLabel.text = [NSString stringWithFormat:@"%ld",(long)model.aqi];

            [_windClass moveToValue:[self judgeWindDir:model.wdirdesc] andWindValue:model.ws];
            _windClass.windLabel.text = [NSString stringWithFormat:@"%.1f",model.ws];
            _aqiButton.effectLabel.text = model.tip_aqi;
            _humButton.effectLabel.text = model.tip_hum;
            if (![model.tip_hum isEqualToString:@"湿度适中"]) {
                _humButton.effectLabel.textColor = [UIColor yellowColor];
            }else{
                _humButton.effectLabel.textColor = [UIColor whiteColor];

            }
            if (![model.tip_aqi isEqualToString:@"空气清新"] && ![model.tip_aqi isEqualToString:@"空气良好"]) {
                _aqiButton.effectLabel.textColor = [UIColor yellowColor];
            }else{
                _aqiButton.effectLabel.textColor = [UIColor whiteColor];
                
            }
            _tempButton.effectLabel.text = model.tip_st;
            if (![model.tip_st isEqualToString:@"体感舒适"]) {
                _tempButton.effectLabel.textColor = [UIColor yellowColor];
            }else{
                _tempButton.effectLabel.textColor = [UIColor whiteColor];
                
            }

            _windBtton.effectLabel.text = model.tip_wind;
            if (![model.tip_wind isEqualToString:@"微风习习"] && ![model.tip_wind isEqualToString:@"无风状态"] ) {
                _windBtton.effectLabel.textColor = [UIColor yellowColor];
            }else{
                _windBtton.effectLabel.textColor = [UIColor whiteColor];
                
            }
            _windClass.windDir.text = model.wdirdesc;

            NSLog(@"%@",model.wdirdesc);
            [_weekCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:scrollView.contentOffset.x / ScreenWidth inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];

            
        }
}
- (void)selectDateWith:(NSInteger)dateNum{
    [_weekCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:dateNum inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    if (dateNum== 1) {
        [self setCurrentScroll];
    }else{
        [_lineScrollView setContentOffset:CGPointMake(ScreenWidth* dateNum + ScreenWidth / 2, 0) animated:YES];
    }

}
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
- (NSArray *)getBottomPointWithArray:(NSArray *)array{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
      NSDictionary * startDic = array[0];
    NSString * startTime = [[startDic objectForKey:@"tbegin"] description];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateFormat:@"yyyyMMddHH"];
    NSDate * startDate = [inputFormatter dateFromString:startTime];
    NSInteger num = 0;
    for (NSDictionary * dic in array) {
        NSLog(@"%@",dic);
        [valueArray addObject:[dic objectForKey:@"tip"]];
        NSString * time = [[dic objectForKey:@"tend"] description];
        NSDate * pointdate = [inputFormatter dateFromString:time];
        CGFloat timeIner = [pointdate timeIntervalSinceDate:startDate];
        CGFloat pointX = timeIner / 3600 * HourWidth;
        [pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(pointX, 0)]];
        num++;
        
    }
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];
}
- (CGFloat)judgeWindDir:(NSString *)dirString{
    CGFloat dir;
    if ([dirString isEqualToString:@"南风"]) {
        dir = 0;
    }else if ([dirString isEqualToString:@"西南风"]){
        dir = M_PI_4;
    }else if ([dirString isEqualToString:@"西风"]){
        dir = M_PI_2;
    }else if ([dirString isEqualToString:@"西北风"]){
        dir = M_PI_4 + M_PI_2;
    }else if ([dirString isEqualToString:@"北风"]){
        dir = M_PI;
    }else if ([dirString isEqualToString:@"东北风"]){
        dir = M_PI + M_PI_4;
    }else if ([dirString isEqualToString:@"东风"]){
        dir = M_PI + M_PI_2;
    }else if ([dirString isEqualToString:@"东南风"]){
        dir = M_PI + M_PI_2 + M_PI_4;
    }
    
    return dir;
}
/*R
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
