//
//  LocationManager.m
//  WeatherLifer
//
//  Created by ink on 15/5/26.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "LocationManager.h"



@interface LocationManager (){
    BMKLocationService * _locService;
    BMKGeoCodeSearch * _searcher;
}
@property (nonatomic, strong) LocationBlock locationBlock;

@end

@implementation LocationManager
+ (LocationManager *)shareLocationManager{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/**
 *  开始定位
 */
- (void)startLocation{

        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
        [_locService startUserLocationService];
        
}
/**
 *  地理位置坐标更新
 *
 *  @param userLocation 用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    [_locService stopUserLocationService];
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    [standard setObject:@(userLocation.location.coordinate.latitude) forKey:LastLatitude];
    [standard setObject:@(userLocation.location.coordinate.longitude) forKey:LastLongitude];
    [standard synchronize];

    _searcher = [[BMKGeoCodeSearch alloc] init];
    _searcher.delegate = self;
    BMKReverseGeoCodeOption * reverseGeoOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoOption];
    if (flag) {
        NSLog(@"haha");
    }
    
    
}
/**
 *  反地理位置编码成功回调
 *
 *  @param searcher 搜索索器
 *  @param result   搜索结果
 *  @param error    返回错误
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if (result.address.length !=0) {
            BMKAddressComponent * component = result.addressDetail;
            NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
            [standard setObject:component.province forKey:LastProvince];
            [standard setObject:component.city forKey:LastCity];
            [standard setObject:component.district forKey:LastCounty];
            NSString * addressString = [component.streetName stringByAppendingString:component.streetNumber];
            [standard setObject:addressString forKey:LastAddress];
             [standard synchronize];
            CLLocationCoordinate2D currentCoordinate = CLLocationCoordinate2DMake(result.location.latitude, result.location.longitude);
            if (_locationBlock) {
                _locationBlock(currentCoordinate,YES);
                _locationBlock = nil;
            }
            
        }else{
            NSLog(@"非中国");
        }
        
    }
}

/**
 *  用户定位失败
 *
 *  @param error 错误信息
 */
- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"%@",error);
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未连接网络,请打开网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alvertView show];
            
        }else{
//            [self startLocation];
            [self.delegate locationFail];
            
        }
    }];

}
/**
 *  获取经纬度
 *
 *  @param locationBlock 经纬度block
 */
- (void)getLocationCoordinate:(LocationBlock) locationBlock{
    self.locationBlock = [locationBlock copy];
    [self startLocation];
}
@end
