//
//  RootViewController.m
//  WeatherLifer
//
//  Created by ink on 15/5/27.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "RootViewController.h"
#import "FXBlurView.h"


#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//default blur settings
#define DEFAULT_BLUR_RADIUS 5
#define DEFAULT_BLUR_TINT_COLOR [UIColor colorWithWhite:0.5 alpha:.3]
#define DEFAULT_BLUR_DELTA_FACTOR 1.4
#define PhotoLocation @"PhotoLocation"
#import "UMSocialDataService.h"
#import "UMSocialSnsPlatformManager.h"
#define LastCity @"LastCity"
#define PhotoLocation @"PhotoLocation"
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
CGFloat const gestureMinimumTranslation = 50.0;


@interface RootViewController (){
    CustomNavgationBar * _customNavBar;
    UIImage * clearImage;
    UIImage * blurImage;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initBasicData];
    [self initBackImageView];
    [self initBasicScrollView];
    [self initTextView];
    [self initCurrentTempView];
    [self initWeekWeatherView];
    [self initWeekDeatilView];
    [self getUserLocation];
    [self makeScrenUI];
    [self addGuestuer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToFrontRefresh) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beBackApp) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}
/**
 *  初始基本变量
 */
- (void)initBasicData{
    self.view.backgroundColor = [UIColor whiteColor];
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
            shareHeigth = 370;
            break;
        case Iphone5:
        case Iphone4:{
            shareHeigth = 287;

            break;
        }
        default:
            break;
    }
    photoModel = [PhotoModel new];
    netWorkManager = [AFHTTPRequestOperationManager manager];
    cureentSelect = 0;
    LeftViewController * controller = (LeftViewController *)self.mm_drawerController.leftDrawerViewController;
    controller.delegate = self;
    [LocationManager shareLocationManager].delegate = self;
}
/**
 *  添加手势
 */
- (void)addGuestuer{
    mainTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeViewToBack:)];
    mainTap.delegate = self;
    mainTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:mainTap];
}
/**
 *  点击切换界面
 *
 *  @param tap 点击手势
 */
- (void)changeViewToBack:(UITapGestureRecognizer *)tap{
    if (!isShare) {
        
        if (_basicScrollView.contentOffset.y == 0) {
            
            
//            if (_textView.hidden) {
//                _backImageView.image = clearImage;
//                _currentTempView.hidden = YES;
//                _customNavBar.hidden = YES;
//                [_textView changeToFront];
//            }else{
                [_textView changeToBack];
                _currentTempView.hidden = NO;
                _customNavBar.hidden = NO;
                _backImageView.image = blurImage;
            tap.enabled = NO;
                
//            }
        }else{
            
        }
    }else{
        [self closeShareView];
    }
}
/**
 *  判断手势是否可用
 *
 *  @param gestureRecognizer 要判断的手势
 *
 *  @return 是否继续执行
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (_basicScrollView.contentOffset.y >= ScreenHeigth) {
        if (isShare) {
            return YES;
        }else{
        return NO;
        }
    }
    return YES;
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return YES;
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if ([touch.view isKindOfClass:[EffectTableViewCell class]]) {
//        return NO;
//    }
//    return YES;
//}

/**
 *  获取用户当前位置
 */
- (void)getUserLocation{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [_basicScrollView.header endRefreshing];
            UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未连接网络,请打开网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            alvertView.tag = 1;
            [alvertView show];
            
        }else{
            
            if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
            {
                [[LocationManager shareLocationManager] getLocationCoordinate:^(CLLocationCoordinate2D locationCoordinate, BOOL inChina) {
                    NSLog(@"%f,%f",locationCoordinate.longitude,locationCoordinate.latitude);
                    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
                    currenCity = [userDefault objectForKey:LastCounty];
                    _customNavBar.countyLabel.text = [userDefault objectForKey:LastCounty];
                    _customNavBar.addressLabel.text = [userDefault objectForKey:LastAddress];
                    float longitude = [userDefault floatForKey:LastLongitude];
                    float latitude = [userDefault floatForKey:LastLatitude];
                    [[NSUserDefaults standardUserDefaults] setObject:[userDefault objectForKey:LastCity] forKey:PhotoLocation];
                    
                    [self getNetWorkData:longitude andLatitude:latitude];
                }];
                
                
            }else{
                NSArray * placeListArray = [NSArray arrayWithArray:[PlaceListData getPlaceList]];
                if (placeListArray.count == 0) {
                    
                    UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:self cancelButtonTitle:@"添加城市" otherButtonTitles:@"打开定位设置", nil];
                    alvertView.tag = 2;
                    [alvertView show];
                }else{
                    PlaceModel * model = placeListArray[0];
                    _customNavBar.countyLabel.text = model.city;
                    _customNavBar.addressLabel.text = model.address;
                    currenCity = model.city;
                    [self getNetWorkData:model.lon andLatitude:model.lat];

                }
                
            }
        }
    }];



}
/**
 *  alert弹出视图
 *
 *  @param alertView
 *  @param buttonIndex 点击的按钮
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1:{
           
            [loadingView stopAm];

            break;
        }
        case 2:{
            [loadingView stopAm];
            if (buttonIndex == 0) {

                LeftViewController * controller = (LeftViewController *)self.mm_drawerController.leftDrawerViewController;
                [UIApplication sharedApplication].statusBarHidden = NO;
                
                AddCityViewController * addCityViewControlle = [AddCityViewController new];
                addCityViewControlle.delegate = controller;
                UINavigationController * addNav = [[UINavigationController alloc] initWithRootViewController:addCityViewControlle];
                [self presentViewController:addNav animated:YES completion:nil];
            }else{
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }else{
                    
                }
            }
            break;
        }
        case 3:{
            LeftViewController * controller = (LeftViewController *)self.mm_drawerController.leftDrawerViewController;
            [UIApplication sharedApplication].statusBarHidden = NO;
            
            AddCityViewController * addCityViewControlle = [AddCityViewController new];
            addCityViewControlle.delegate = controller;
            UINavigationController * addNav = [[UINavigationController alloc] initWithRootViewController:addCityViewControlle];
            [self presentViewController:addNav animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark 初始化控件
/**
 *  设置界面系统内容
 */
- (void)makeScrenUI{
    self.navigationController.navigationBarHidden = YES;
    //navigation bar work
    
//    NSShadow *shadow = [[NSShadow alloc] init];
//    [shadow setShadowOffset:CGSizeMake(1, 1)];
//    [shadow setShadowColor:[UIColor blackColor]];
//    [shadow setShadowBlurRadius:1];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSShadowAttributeName: shadow};
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    _customNavBar = [CustomNavgationBar new];
    _customNavBar.delegate = self;
    [self.view addSubview:_customNavBar];
    [_customNavBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@44);
    }];
    _customNavBar.hidden = YES;
    _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, ScreenHeigth, ScreenWidth, 370)];
    _shareView.delegate = self;
    [self.view addSubview:_shareView];
    loadingView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:loadingView];
    [loadingView startAm];
}
/**
 *  初始化背景图片
 */
- (void)initBackImageView{
    UIImageView * holdImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:holdImageView];
    [holdImageView setImage:[UIImage imageNamed:@"loading_bg.png"]];
    _backImageView = [UIImageView new];
    [self.view addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
  }
/**
 *  初始化滚动试图
 */
- (void)initBasicScrollView{
    _basicScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
    [self.view addSubview:_basicScrollView];
    _basicScrollView.showsHorizontalScrollIndicator = NO;
    _basicScrollView.showsVerticalScrollIndicator = NO;
    _basicScrollView.delegate = self;
//    _basicScrollView.pagingEnabled = YES;
    [_basicScrollView.panGestureRecognizer addTarget:self action:@selector(panToChangeView:)];
    [_basicScrollView setContentSize:CGSizeMake(0, 3 * ScreenHeigth)];
//    _basicScrollView.delaysContentTouches = NO;
    _basicScrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (cureentSelect == 0) {
            
            [self getUserLocation];
        }else{
            [self getOtherCity];
        }
    }];
    
}
/**
 *  滑动切换视图
 *
 *  @param gesture 滑动手势
 */
- (void)panToChangeView:(UIPanGestureRecognizer *)gesture{
    CGPoint translation = [gesture translationInView:self.view];

    if (gesture.state ==UIGestureRecognizerStateBegan)
        
    {
        
        direction = kCameraMoveDirectionNone;
        
    }
    
    else if (gesture.state == UIGestureRecognizerStateChanged && direction == kCameraMoveDirectionNone)
        
    {
        
        direction = [self determineCameraDirectionIfNeeded:translation];
        
        
        // ok, now initiate movement in the direction indicated by the user's gesture
        
        switch (direction) {
                
            case kCameraMoveDirectionDown:
                
                NSLog(@"Start moving down");
                break;
                
            case kCameraMoveDirectionUp:
                
                NSLog(@"Start moving up");
                if (!_textView.hidden) {
                    
                    [_textView changeToBack];
                    _currentTempView.hidden = NO;
                    _customNavBar.hidden = NO;
                    _backImageView.image = blurImage;
                    mainTap.enabled = NO;
                }

                
                break;
                
            case kCameraMoveDirectionRight:
                
                NSLog(@"Start moving right");
                
                break;
                
            case kCameraMoveDirectionLeft:
                
                NSLog(@"Start moving left");
                
                break;
                
            default:
                
                break;
                
        }
        
    }
    
    else if (gesture.state == UIGestureRecognizerStateEnded)
    
    {
        
        // now tell the camera to stop
        
        NSLog(@"Stop");
        
    }

    

}
- (CameraMoveDirection)determineCameraDirectionIfNeeded:(CGPoint)translation

{
    
    if (direction != kCameraMoveDirectionNone)
        
        return direction;
    
    // determine if horizontal swipe only if you meet some minimum velocity
    
    if (fabs(translation.x) > gestureMinimumTranslation)
        
    {
        
        BOOL gestureHorizontal = NO;
        
        if (translation.y ==0.0)
            
            gestureHorizontal = YES;
        
        else
            
            gestureHorizontal = (fabs(translation.x / translation.y) >5.0);
        
        if (gestureHorizontal)
            
        {
            
            if (translation.x >0.0)
                
                return kCameraMoveDirectionRight;
            
            else
                
                return kCameraMoveDirectionLeft;
            
        }
        
    }
    
    // determine if vertical swipe only if you meet some minimum velocity
    
    else if (fabs(translation.y) > gestureMinimumTranslation)
        
    {
        
        BOOL gestureVertical = NO;
        
        if (translation.x ==0.0)
            
            gestureVertical = YES;
        
        else
            
            gestureVertical = (fabs(translation.y / translation.x) >5.0);
        
        if (gestureVertical)
            
        {
            
            if (translation.y >0.0)
                
                return kCameraMoveDirectionDown;
            
            else
                
                return kCameraMoveDirectionUp;
        }
        
    }
    
    return direction;
    
}
/**
 *  选择城市
 *
 *  @param model 城市model
 *  @param row   城市序号
 */

- (void)selectPlaceWithModel:(PlaceModel *)model andRow:(NSInteger)row{
    [loadingView startAm];
    cureentSelect = row;
    otherPlaceModel = model;
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    [_basicScrollView setContentOffset:CGPointMake(0, 0)];
    _backImageView.image = clearImage;
    _currentTempView.hidden = YES;
    _customNavBar.hidden = YES;
    [_textView chageCity];
    mainTap.enabled = YES;
    if (row == 0) {
        
        [self getUserLocation];
    }else{
        [self getOtherCity];
    }

}
/**
 *  获取选择城市数据
 */
- (void)getOtherCity{
    _customNavBar.countyLabel.text = otherPlaceModel.city;
    _customNavBar.addressLabel.text = otherPlaceModel.address;
    currenCity = otherPlaceModel.city;
    [[NSUserDefaults standardUserDefaults] setObject:otherPlaceModel.city forKey:PhotoLocation];

    [self getNetWorkData:otherPlaceModel.lon andLatitude:otherPlaceModel.lat];

}
/**
 *  添加文字视图
 */
- (void)initTextView{
    _textView = [[TextAndTemperatureView alloc] initWithFrame:self.view.frame];
    _textView.delegate = self;
    [_basicScrollView addSubview:_textView];
//    _textView.hidden = YES;
    
}
/**
 *  添加当前短临视图
 */
- (void)initCurrentTempView{
    _currentTempView = [[CurrentTemperatureView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
    [_basicScrollView addSubview:_currentTempView];
    _currentTempView.delegate =self;
    _currentTempView.hidden = YES;
}
/**
 *  添加七天概略图
 */
- (void)initWeekWeatherView{
    _weekWeatherView = [[WeekWeatherView alloc] initWithFrame:CGRectMake(0, ScreenHeigth, ScreenWidth, ScreenHeigth)];
    [_basicScrollView addSubview:_weekWeatherView];
    _weekWeatherView.delegate = self;
}
/**
 *  添加七天详细视图
 */
- (void)initWeekDeatilView{
    _weekDeatilView = [[WeekDetailView alloc] initWithFrame:CGRectMake(0, ScreenHeigth * 2, ScreenWidth, ScreenHeigth)];
    [_basicScrollView addSubview:_weekDeatilView];
}
/**
 *  自定义navgationbar代理方法
 *
 *  @param tag 按钮编号
 */
- (void)selectNavButtonWithTag:(NSInteger)tag{
    NSLog(@"%i",tag);
    switch (tag) {
        case 1:{
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

            break;
        }
        case 2:{
            [self openShareView];
            break;
        }
            
        default:
            break;
    }
}
/**
 *  滚动视图代理方法
 *
 *  @param scrollView 滚动视图
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
        if (!_textView.hidden) {
        if (scrollView.contentOffset.y > 0) {
            
                    scrollView.contentOffset = CGPointMake(0, 0);
        }
    }else{
//        if (scrollView.contentOffset.y >= ScreenHeigth) {
//            tap
//        }
        if (scrollView.contentOffset.y > ScreenHeigth * 2) {
            
            scrollView.contentOffset = CGPointMake(0, ScreenHeigth * 2);
        }

    }
}
/**
 *  经纬度网络请求
 */
- (void)getNetWorkData:(CGFloat)longitude andLatitude:(CGFloat)latitude{


    NSMutableDictionary * weatherDic = [NSMutableDictionary dictionary];
    NSMutableDictionary * currenWeatherDic = [NSMutableDictionary dictionary];
    NSMutableArray * changeArray = [NSMutableArray array];
    NSMutableDictionary * hourDic = [NSMutableDictionary dictionary];
    NSMutableArray * leftArray = [NSMutableArray array];
      NSString * currentWeatherUrlString = [BasicUrl stringByAppendingString:CurrentWeather([NSNumber numberWithFloat:longitude], [NSNumber numberWithFloat:latitude])];
    AFHTTPRequestOperation * currentWeatherOperation = [WeatherNetWork NetRequestGETWithRequestURL:currentWeatherUrlString WithReturnValeuBlock:^(id responseObject) {
        NSDictionary * resultDic = [responseObject objectFromJSONData];
        [currenWeatherDic setDictionary:resultDic];
        NSArray * allKeys = [resultDic allKeys];
        NSArray * allValues = [resultDic allValues];
        for (int i = 0; i < allKeys.count; i++) {
            NSString * key = allKeys[i];
            id value = allValues[i];
            [weatherDic setValue:value forKey:key];
        }
        NSLog(@"%@",weatherDic);
           } WithFailureBlock:^(id error) {
        NSLog(@"%@",error);
    }];
    
    NSString * allDayUrlString = [BasicUrl stringByAppendingString:AllDayWeather([NSNumber numberWithFloat:longitude], [NSNumber numberWithFloat:latitude])];
    AFHTTPRequestOperation * allDayWeatherOperation = [WeatherNetWork NetRequestGETWithRequestURL:allDayUrlString WithReturnValeuBlock:^(id responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary * resultDic = [responseObject objectFromJSONData];
            NSArray * dataArray = [resultDic objectForKey:@"W_24h"];
            [weatherDic setValue:[dataArray[0] objectForKey:@"time"]  forKey:@"startTime"];
            NSArray * aqiTmpArray = [self getAQIpointArrayWithDic:resultDic];
            [weatherDic setValue:[aqiTmpArray objectAtIndex:0] forKey:@"aqiLine"];
            [weatherDic setValue:[aqiTmpArray objectAtIndex:1] forKey:@"aqiValue"];
            NSArray * tempTmpArray = [self getTemppointArrayWithDic:resultDic];
            
            [weatherDic setValue:[tempTmpArray objectAtIndex:0] forKey:@"tempLine"];
            [weatherDic setValue:[tempTmpArray objectAtIndex:1] forKey:@"tempValue"];
            NSArray * bottomArray = [self getBottomPointWithDic:resultDic];
            [weatherDic setValue:[bottomArray objectAtIndex:0] forKey:@"bottomLine"];
            [weatherDic setValue:[bottomArray objectAtIndex:1] forKey:@"bottomValue"];
        });
    } WithFailureBlock:^(id error) {
        NSLog(@"%@",error);

    }];
    
    NSString * currentRainUrlString = [BasicUrl stringByAppendingString:CurrentRain([NSNumber numberWithFloat:longitude], [NSNumber numberWithFloat:latitude])];
    AFHTTPRequestOperation * currentRainOperation = [WeatherNetWork NetRequestGETWithRequestURL:currentRainUrlString WithReturnValeuBlock:^(id responseObject) {
        NSDictionary * resultDic = [responseObject objectFromJSONData];
        [weatherDic setValue:[resultDic objectForKey:@"msg"] forKey:@"msg"];
        [weatherDic setValue:[resultDic objectForKey:@"series"] forKey:@"series"];
       
        
    } WithFailureBlock:^(id error) {
        NSLog(@"%@",error);

    }];
    
    NSString * weekUrlString = [BasicUrl stringByAppendingString:WeekWeather([NSNumber numberWithFloat:longitude], [NSNumber numberWithFloat:latitude])];
    
    AFHTTPRequestOperation * weekWeatherOperation = [WeatherNetWork NetRequestGETWithRequestURL:weekUrlString WithReturnValeuBlock:^(id responseObject) {
        NSArray * resultArray = [responseObject objectFromJSONData];
        for (NSDictionary * dic in resultArray) {
            WeekWeatherModel * model = [[WeekWeatherModel alloc] initWithDic:dic];
            [changeArray addObject:model];
        }
        NSLog(@"%@",resultArray);

    } WithFailureBlock:^(id error) {
        NSLog(@"%@",error);

    }];
    
    
    NSString * weekDeatilUrlString = [BasicUrl stringByAppendingString:WeekDetailWeather([NSNumber numberWithFloat:longitude], [NSNumber numberWithFloat:latitude])];
    AFHTTPRequestOperation * weekDetailWeatherOpertaion = [WeatherNetWork NetRequestGETWithRequestURL:weekDeatilUrlString WithReturnValeuBlock:^(id responseObject) {
        NSDictionary * resultDic = [responseObject objectFromJSONData];
        [hourDic setDictionary:resultDic];
    } WithFailureBlock:^(id error) {
                NSLog(@"%@",error);
    }];
    
    
    
    NSArray * placeArray = [NSArray arrayWithArray:[PlaceListData getPlaceList]];
    NSString * placeListString = [BasicUrl stringByAppendingString:BatchGetWeather];
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    float locationlongitude = [userDefault floatForKey:LastLongitude];
    float locationlatitude = [userDefault floatForKey:LastLatitude];
    NSString * loctationString = Coor([NSNumber numberWithFloat:locationlongitude], [NSNumber numberWithFloat:locationlatitude], 0);
  placeListString =   [placeListString stringByAppendingString:loctationString];

    for (int i = 0; i < placeArray.count; i++) {
        PlaceModel * model = placeArray[i];
        NSString * listString = Coor([NSNumber numberWithFloat:model.lon], [NSNumber numberWithFloat:model.lat], i+1);
           placeListString =  [NSString stringWithFormat:@"%@&%@",placeListString,listString];
    }
    AFHTTPRequestOperation * batchOperation  = [WeatherNetWork NetRequestGETWithRequestURL:placeListString WithReturnValeuBlock:^(id responseObject) {
        NSArray * resultArray = [responseObject objectFromJSONData];
        for (NSDictionary * dic in resultArray) {
            [leftArray addObject:[dic objectForKey:@"w"]];
        }
        
    } WithFailureBlock:^(id error) {
        NSLog(@"%@",error);
    }];
    NSLog(@"%@",placeListString);
    
    NSArray * operationArray = [NSArray arrayWithObjects:currentWeatherOperation,allDayWeatherOperation,weekWeatherOperation,weekDetailWeatherOpertaion,currentRainOperation,batchOperation, nil];
    NSArray * operations = [AFURLConnectionOperation batchOfRequestOperations:operationArray progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        NSLog(@"%lu of %lu complete", numberOfFinishedOperations, totalNumberOfOperations);
        
    } completionBlock:^(NSArray *operations) {
        CurrentWeatherModel * model = [[CurrentWeatherModel alloc] initWithDataDic:currenWeatherDic];
        photoModel.temp = model.tmp ;
        photoModel.textArray = model.wtxt;
        photoModel.imageName = model.wcode;

        _textView.model = model;
        [_backImageView sd_setImageWithURL:[NSURL URLWithString:model.bg] placeholderImage:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            clearImage = image;
            blurImage =  [image applyBlurWithRadius:DEFAULT_BLUR_RADIUS tintColor:DEFAULT_BLUR_TINT_COLOR saturationDeltaFactor:DEFAULT_BLUR_DELTA_FACTOR maskImage:nil];
            if (_textView.hidden) {
                _backImageView.image = blurImage;
            }
        }];

        AllDayWeatherModel * allDayModel = [[AllDayWeatherModel alloc] initWithDic:weatherDic];
        _currentTempView.model = allDayModel;
        
        WeekAllModel * weekModel = [[WeekAllModel alloc] initWithArray:changeArray];
        _weekWeatherView.model = weekModel;
        
        HourDetailModel * hourModel = [[HourDetailModel alloc] initWithDic:hourDic];
        _weekDeatilView.model = hourModel;
        
        LeftViewController * controller = (LeftViewController *)self.mm_drawerController.leftDrawerViewController;
        [controller.weatherDataArray removeAllObjects];
        [controller.weatherDataArray addObjectsFromArray:leftArray];
        [controller refreshCityWeather];
        
        [_basicScrollView.header endRefreshing];
        [_textView startAnimation];
        [loadingView stopAm];

    }];
    [netWorkManager.operationQueue addOperations:operations waitUntilFinished:YES];
}
/**
 *  计算 AQI 坐标
 *
 *  @param dic 数据字典
 *
 *  @return 坐标数组
 */
- (NSArray *)getAQIpointArrayWithDic:(NSDictionary *)dic{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    NSArray * dataArray = [dic objectForKey:@"W_24h"];
    NSDictionary * firstDataDic = dataArray[0];
    double maxAqi = [[firstDataDic objectForKey:@"aqi"] doubleValue];
    double minAqi = [[firstDataDic objectForKey:@"aqi"] doubleValue];
    for (NSDictionary * dicTmp in dataArray) {
        if ([[dicTmp objectForKey:@"aqi"] doubleValue] > maxAqi) {
            maxAqi = [[dicTmp objectForKey:@"aqi"] doubleValue];
        }
        if ([[dicTmp objectForKey:@"aqi"] doubleValue] < minAqi) {
            minAqi = [[dicTmp objectForKey:@"aqi"] doubleValue];

        }
    }
    NSInteger num = 0;
    for (NSDictionary * dicTmp in dataArray) {
        double aqi = [[dicTmp objectForKey:@"aqi"] doubleValue];
        CGFloat xPoint = (ScreenWidth - 20) * 2  / 24.0f * num;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:
                valuePoint.y = 50 - 50 / (maxAqi - minAqi) * (aqi - minAqi);

                break;
            case Iphone4:{
                valuePoint.y = 40 - 40 / (maxAqi - minAqi) * (aqi - minAqi);

                break;
            }
            default:
                break;
        }

      
        num++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
        [valueArray addObject:[NSNumber numberWithDouble:aqi]];
    }
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];
}
/**
 *  获取温度曲线坐标
 *
 *  @param dic 数据字典
 *
 *  @return 坐标数组
 */
- (NSArray *)getTemppointArrayWithDic:(NSDictionary *)dic{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];
    NSArray * dataArray = [dic objectForKey:@"W_24h"];
    NSDictionary * firstDataDic = dataArray[0];
    double maxAqi = [[firstDataDic objectForKey:@"st"] doubleValue];
    double minAqi = [[firstDataDic objectForKey:@"st"] doubleValue];
    for (NSDictionary * dicTmp in dataArray) {
        if ([[dicTmp objectForKey:@"st"] doubleValue] > maxAqi) {
            maxAqi = [[dicTmp objectForKey:@"st"] doubleValue];
        }
        if ([[dicTmp objectForKey:@"st"] doubleValue] < minAqi) {
            minAqi = [[dicTmp objectForKey:@"st"] doubleValue];
            
        }
    }
    NSInteger num = 0;
    for (NSDictionary * dicTmp in dataArray) {
        double aqi = [[dicTmp objectForKey:@"st"] doubleValue];
        CGFloat xPoint = (ScreenWidth - 20) * 2  / 24.0f * num;
        CGPoint valuePoint;
        valuePoint.x = xPoint;
        
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:
                valuePoint.y = 50 - 50 / (maxAqi - minAqi) * (aqi - minAqi);
                
                break;
            case Iphone4:{
                valuePoint.y = 40 - 40 / (maxAqi - minAqi) * (aqi - minAqi);
                
                break;
            }
            default:
                break;
        }
        num++;
        [pointArray addObject:[NSValue valueWithCGPoint:valuePoint]];
        [valueArray addObject:[NSNumber numberWithDouble:aqi]];
    }
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];


}
/**
 *  获取底部坐标
 *
 *  @param dic 数据字典
 *
 *  @return 坐标数组
 */
- (NSArray *)getBottomPointWithDic:(NSDictionary *)dic{
    NSMutableArray * pointArray = [NSMutableArray array];
    NSMutableArray * valueArray = [NSMutableArray array];

    NSArray * dataArray = [dic objectForKey:@"sum_seg"];
    NSDictionary * startDic = dataArray[0];
    NSString * startTime = [[startDic objectForKey:@"tbegin"] description];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateFormat:@"yyyyMMddHH"];
    NSDate * startDate = [inputFormatter dateFromString:startTime];
    NSInteger num = 0;
    for (NSDictionary * tmp  in dataArray) {
        [valueArray addObject:[tmp objectForKey:@"wcode"]];
        NSString * time = [[tmp objectForKey:@"tend"] description];
        NSDate * pointdate = [inputFormatter dateFromString:time];
       CGFloat timeIner = [pointdate timeIntervalSinceDate:startDate];
        
        CGFloat xPoint = (ScreenWidth - 40) * 2  / 24.0f * ((timeIner / 3600) + 1);
        if (num == dataArray.count - 1) {
            xPoint = (ScreenWidth - 40) * 2  / 24.0f * (timeIner / 3600);

        }
        [pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(xPoint, 0)]];

        num++;
    }
    return [NSArray arrayWithObjects:pointArray,valueArray, nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (_textView.hidden) {
        
        CGPoint  point = *targetContentOffset;
//        NSLog(@"%@",NSStringFromCGPoint(point));
        if (point.y < ScreenHeigth / 2) {
            targetContentOffset->y = 0;
        }else if (point.y >= ScreenHeigth / 2 && point.y < ScreenHeigth + ScreenHeigth / 2){
            targetContentOffset->y = ScreenHeigth;
        }else{
            targetContentOffset->y = ScreenHeigth * 2;
            
        }
    }
}


/**
 *  保存图片到相册
 */
- (void)savePhotoToPhone{
    UIImageWriteToSavedPhotosAlbum([self snapShot], self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                          
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    
    [alert show];
    
}
/**
 *  分享图片至微信好友
 */
- (void)sharePhotoToFriend{
    NSData * data =    UIImageJPEGRepresentation([self snapShot], 0.5);
    UIImage * sendImage = [UIImage imageWithData:data];
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [UMSocialData defaultData].extConfig.wechatSessionData.title =  [[NSUserDefaults standardUserDefaults] objectForKey:PhotoLocation];;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:nil image:sendImage location:nil urlResource:nil presentedController:  [UIApplication sharedApplication].keyWindow.rootViewController completion:^(UMSocialResponseEntity * response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        } else if(response.responseCode != UMSResponseCodeCancel) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    
    
}
/**
 *  分享图片至朋友圈
 */
- (void)sharePhototoTimeLine{
    NSData * data =    UIImageJPEGRepresentation([self snapShot], 0.5);
    UIImage * sendImage = [UIImage imageWithData:data];
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:nil image:sendImage location:nil urlResource:nil presentedController:  [UIApplication sharedApplication].keyWindow.rootViewController completion:^(UMSocialResponseEntity * response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        } else if(response.responseCode != UMSResponseCodeCancel) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    
    
    
}
/**
 *  分享图片至微博
 */
- (void)sharePhotoToWeibo{
    NSData * data =    UIImageJPEGRepresentation([self snapShot], 0.5);
    UIImage * sendImage = [UIImage imageWithData:data];
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:nil image:sendImage location:nil urlResource:nil presentedController:  [UIApplication sharedApplication].keyWindow.rootViewController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        }
    }];
    
}
/**
 *  更多按钮
 */
- (void)moreButtonPress{
    UIImage * image = [self snapShot];
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];
    activityController.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToWeibo, UIActivityTypeAssignToContact,nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:activityController animated:YES completion:nil];
    
}
/**
 *  截图
 *
 *  @return 截取的图片
 */
- (UIImage *)snapShot{
    _shareView.hidden = YES;
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [_textView closeShare];
    [_customNavBar alreadyShare];
    _shareView.hidden = NO;
    isShare = NO;
     _shareView.frame = CGRectMake(0, ScreenHeigth, ScreenWidth, shareHeigth);
    UIGraphicsEndImageContext();
    return image;
    
}
/**
 *  分享
 */
- (void)share{

    [self openShareView];
}
/**
 *  打开分享按钮
 */
- (void)openShareView{
    isShare = YES;
    [UIView animateWithDuration:0.7 animations:^{
        _shareView.frame = CGRectMake(0, ScreenHeigth - shareHeigth, ScreenWidth, shareHeigth);
    }];
}
/**
 *  关闭分享按钮
 */
- (void)closeShareView{
        [_textView closeShare];
    [_customNavBar alreadyShare];

    isShare = NO;
    [UIView animateWithDuration:0.7 animations:^{
        _shareView.frame = CGRectMake(0, ScreenHeigth, ScreenWidth, shareHeigth);
    }];

}
/**
 *  选择日期
 *
 *  @param dateNum 日期编号
 */
- (void)selectDate:(NSInteger)dateNum{
    NSLog(@"%d",dateNum);
    [_basicScrollView setContentOffset:CGPointMake(0, ScreenHeigth * 2) animated:YES];
    [_weekDeatilView selectDateWith:dateNum];
}
- (void)selectShareStyle:(NSInteger)tag{
    switch (tag) {
        case 1:{
            [self sharePhotoToFriend];
            break;
        }
        case 2:{
            [self sharePhototoTimeLine];
            break;
        }
        case 3:{
            [self sharePhotoToWeibo];
            break;
        }
        case 4:{
            [self savePhotoToPhone];
            break;
        }
        case 5:{
            [self moreButtonPress];
            break;
        }
        case 6:{
            [self closeShareView];
        }
            
        default:
            break;
    }
}
/**
 *  进入后台允许刷新
 */
- (void)beBackApp{
    enterDate = [NSDate date];
}
/**
 *  从后台进入前台刷新
 */
- (void)backToFrontRefresh{
    if ([self shouldRefres:enterDate]) {
        if (!isShare) {
            
            [_basicScrollView.header beginRefreshing];
        }
    }
}
/**
 *  判断是否刷新UI
 *
 *  @param date 判断的时间
 *
 *  @return 判断结果
 */
- (BOOL)shouldRefres:(NSDate *)date{
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    return time / 60 >= 5;
    
}
/**
 *  红心按钮
 */

- (void)heartPress{
    _backImageView.image = clearImage;
    _currentTempView.hidden = YES;
    _customNavBar.hidden = YES;
    [_textView changeToFront];
    mainTap.enabled = YES;

}
/**
 *  进入拍照界面
 */
- (void)takePhotoWithPlace{
    TakePhotoViewController * takePhotoController = [TakePhotoViewController new];
    takePhotoController.model = photoModel;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/M/d"];
    takePhotoController.locationString =[NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:[NSDate date]],currenCity];
    [self.navigationController pushViewController:takePhotoController animated:YES];


}
/**
 *  定位失败
 */
- (void)locationFail{
    [loadingView stopAm];

    [_basicScrollView.header endRefreshing];
    UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前位置定位失败,请您添加城市" delegate:self cancelButtonTitle:@"添加城市" otherButtonTitles:nil, nil];
    alvertView.tag = 3;
    [alvertView show];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
