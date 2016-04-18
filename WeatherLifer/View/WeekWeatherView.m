//
//  WeekWeatherView.m
//  WeatherLifer
//
//  Created by ink on 15/6/4.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekWeatherView.h"
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ItemWith [UIScreen mainScreen].bounds.size.width / 7
#define ItemHeight 600
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480

@implementation WeekWeatherView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.weekDataArray = [NSMutableArray array];
        [self initCollectionView];
        [self initWeekLine];
        [self initWeekAirLine];
        [self addModelObserver];
        UIView * lineView = [UIView new];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(@0.5);
            switch ((NSInteger)ScreenHeigth) {
                case Iphone6:
                case Iphone6p:
                    make.top.equalTo(self.mas_top).with.offset(445);
                    break;
                    
                case Iphone5:
                    make.top.equalTo(self.mas_top).with.offset(360);
                    break;
                    
                case Iphone4:{
                    make.top.equalTo(self.mas_top).with.offset(312);
                    break;
                    
                }
                default:
                    break;
            }

        }];
        
        lineView.alpha = 0.1;
        lineView.backgroundColor = [UIColor whiteColor];

        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                lineHeight = 44;
                topToBottom = 92;
                
                break;
            case Iphone5:
                lineHeight = 34;
                topToBottom = 50;
                break;
            case Iphone4:{
                lineHeight = 28;
                topToBottom = 30;

                break;
            }
            default:
                break;
        }

    }
    return self;
}
- (void)addModelObserver{
    @weakify(self);
    [RACObserve(self, self.model) subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            NSLog(@"%@",self.model.dataArray);
            NSArray * upArray = [self getTopLineData];
            [_weekLine.upLineArray removeAllObjects];
            [_weekLine.upLineArray addObjectsFromArray:[upArray objectAtIndex:0]];
            [_weekLine.upValueArray removeAllObjects];
            [_weekLine.upValueArray addObjectsFromArray:[upArray objectAtIndex:1]];
            NSArray * bottomArray = [self getBottomLineData];
            [_weekLine.bottomArray removeAllObjects];
            [_weekLine.bottomArray addObjectsFromArray:[bottomArray objectAtIndex:0]];
            [_weekLine.bottomValueArray removeAllObjects];
            [_weekLine.bottomValueArray addObjectsFromArray:bottomArray[1]];
            [_weekLine setNeedsDisplay];
            NSArray * aqiLineArray = [self getAqiArray];
            [_weekAirLine.linePointArray removeAllObjects];
            [_weekAirLine.linePointArray addObjectsFromArray:[aqiLineArray objectAtIndex:0]];
            [_weekAirLine.valueArray removeAllObjects];
            [_weekAirLine.valueArray addObjectsFromArray:[aqiLineArray objectAtIndex:1]];
            [_weekAirLine setNeedsDisplay];
            [_weekCollectionView reloadData];
        }
    }];
}
/**
 *  获取空气曲线相关数据数组
 *
 *  @return 相关数据数组
 */
- (NSArray *)getAqiArray{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    WeekWeatherModel * firstModel = self.model.dataArray[0];
    double tmax = firstModel.aqi;
    double tmin = firstModel.aqi;
    for (WeekWeatherModel * model in self.model.dataArray) {
        if (model.aqi > tmax) {
            tmax =model.aqi;
        }
        if (model.aqi < tmin) {
            tmin = model.aqi;
            
        }
    }
    NSInteger num = 0;
    for (WeekWeatherModel * model in self.model.dataArray) {
        double aqi = model.aqi;
        CGFloat xPoint = ScreenWidth / 7 * num + ItemWith/ 2;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        valuePoint.y = 24 - 24 / (tmax - tmin) * (aqi - tmin);
        num++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:aqi],@"aqi",model.tip_aqi,@"tip", nil];
        [valueArray addObject:dic];
    }
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];


}
/**
 *  获取上部曲线坐标点
 *
 *  @return 坐标点数组
 */
- (NSArray *)getTopLineData{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    WeekWeatherModel * firstModel = self.model.dataArray[0];
    double tmax = firstModel.tmax;
    double tmin = firstModel.tmax;
    for (WeekWeatherModel * model in self.model.dataArray) {
        if (model.tmax > tmax) {
            tmax =model.tmax;
        }
        if (model.tmax < tmin) {
            tmin = model.tmax;
            
        }
    }
    NSInteger num = 0;
    for (WeekWeatherModel * model in self.model.dataArray) {
        double temp = model.tmax;
        CGFloat xPoint = ScreenWidth / 7 * num + ItemWith/ 2;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        valuePoint.y = lineHeight - lineHeight / (tmax - tmin) * (temp - tmin);
        num++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
        [valueArray addObject:[NSNumber numberWithDouble:temp]];
    }
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];



}
/**
 *  获取底部曲线数组
 *
 *  @return 底部相关曲线数组
 */
- (NSArray *)getBottomLineData{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    WeekWeatherModel * firstModel = self.model.dataArray[0];
    double tmax = firstModel.tmin;
    double tmin = firstModel.tmin;
    for (WeekWeatherModel * model in self.model.dataArray) {
        if (model.tmin > tmax) {
            tmax =model.tmin;
        }
        if (model.tmin < tmin) {
            tmin = model.tmin;
            
        }
    }
    NSInteger num = 0;
    for (WeekWeatherModel * model in self.model.dataArray) {
        double temp = model.tmin;
        CGFloat xPoint = ScreenWidth / 7 * num + ItemWith/ 2;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        valuePoint.y = lineHeight - lineHeight / (tmax - tmin) * (temp - tmin) + topToBottom;
        num++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
        [valueArray addObject:[NSNumber numberWithDouble:temp]];
    }
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];
    
    
    
}

/**
 *  初始化控件
 */
- (void)initCollectionView{
    UIView * backView = [UIView new];
    [self addSubview:backView];
    backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top);
    }];

    UICollectionViewFlowLayout * collectionLayout = [UICollectionViewFlowLayout new];
    [collectionLayout setItemSize:CGSizeMake(ItemWith, ItemHeight)];
    collectionLayout.sectionInset = UIEdgeInsetsZero;
    collectionLayout.minimumInteritemSpacing = 0;
    collectionLayout.minimumLineSpacing = 0;
    CGFloat collectionTotop;
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
        case Iphone5:
            collectionTotop = 100;
            
            break;
        case Iphone4:{
            collectionTotop = 88;
            break;
        }
        default:
            break;
    }

    _weekCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionTotop, ScreenWidth, ScreenHeigth - collectionTotop) collectionViewLayout:collectionLayout];
    _weekCollectionView.backgroundColor = [UIColor clearColor];
    _weekCollectionView.delegate = self;
    _weekCollectionView.dataSource = self;
    _weekCollectionView.scrollEnabled = NO;
    [_weekCollectionView registerClass:[WeekCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_weekCollectionView];

}
/**
 *  初始化温度曲线
 */
- (void)initWeekLine{
    _weekLine = [WeekLine new];
    [self addSubview:_weekLine];
    [_weekLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@136);
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(self.mas_top).with.offset(214);

                break;
            case Iphone5:
                make.top.equalTo(self.mas_top).with.offset(200);
                break;
            case Iphone4:{
                make.top.equalTo(self.mas_top).with.offset(186);

                break;
            }
            default:
                break;
        }

    }];
    _weekLine.userInteractionEnabled = NO;
}
/**
 *  添加空气曲线
 */
- (void)initWeekAirLine{
    _weekAirLine = [WeekAirLine new];
    [self addSubview:_weekAirLine];
    [_weekAirLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@44);
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:{
                make.top.equalTo(self.mas_top).with.offset(540);

                break;
            }
            case Iphone6p:
                make.top.equalTo(self.mas_top).with.offset(560);
                
                break;
            case Iphone5:
                make.top.equalTo(self.mas_top).with.offset(430);
                break;
            case Iphone4:{
                make.top.equalTo(self.mas_top).with.offset(380);

                break;
            }
            default:
                break;
        }

    }];
    _weekAirLine.userInteractionEnabled = NO;
}
#pragma mark - collectionViewDateSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cell";
    WeekCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    WeekWeatherModel * model = self.model.dataArray[indexPath.row];
    WeatherIconModel * iconModel = [WeatherIconData getWeatherIcon:model.wcode_am.integerValue];
    WeatherIconModel * nightIconModel =[WeatherIconData getWeatherIcon:model.wcode_pm.integerValue];
    cell.topWeatherImageView.image = [UIImage imageNamed:iconModel.dayImageName];
    cell.bottomWeatherImageView.image = [UIImage imageNamed:nightIconModel.nightImageName];
    cell.windLabel.text = model.wdirdesc;
    cell.windClassLabel.text = model.wclass;
    if (indexPath.row == 0) {
        cell.weekLabel.text = @"昨天";
        cell.dateLabel.text = @"昨天";
    }else if (indexPath.row == 1){
        cell.weekLabel.text = @"今天";
        cell.dateLabel.text = @"今天";
        
    }else{
        NSDateFormatter * formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate * date = [formatter dateFromString:model.time];
        [formatter setDateFormat:@"M/d"];
        cell.dateLabel.text = [formatter stringFromDate:date];
        cell.weekLabel.text = [self weekdayStringFromDate:date];

    }
    
    return cell;
}
#pragma mark - collcetionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.delegate selectDate:indexPath.row];
}
/**
 *  根据日期获取星期
 *
 *  @param inputDate 输入日期
 *
 *  @return 星期字符串
 */
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
