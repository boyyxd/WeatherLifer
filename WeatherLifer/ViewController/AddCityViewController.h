//
//  AddCityViewController.h
//  WeatherLifer
//
//  Created by ink on 15/6/19.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
#import "SuggestionModel.h"
#import "PlaceListData.h"
#import "Masonry.h"
#import "AddPlaceTableViewCell.h"
@protocol AddPlaceDelegate
@required
- (void)addCityWithModel:(PlaceModel*)model;
@end

@interface AddCityViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,UITextFieldDelegate,BMKPoiSearchDelegate,BMKSuggestionSearchDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,BMKGeoCodeSearchDelegate,UIGestureRecognizerDelegate,UISearchDisplayDelegate,UISearchControllerDelegate,UIAlertViewDelegate>{
    BMKMapView * _mapView;//百度地图
    BMKLocationService * _locService;//位置搜索
    BMKSuggestionSearch * _searcher;//建议搜索
    UITableView * _placeTableView;//地点列表
    UIView * backView;//灰色背景视图
    NSMutableArray * placeArray;//城市列表数组
    BMKGeoCodeSearch * _geoSearcher;//反地理位置编码
    BMKPoiSearch * _poiSearch;//poi搜索
    UISearchDisplayController *searchDisplayController;
//    UISearchController * searchController;
    UITableView * _searchCityTabelView;
    NSMutableArray * searchCityArray;
    BOOL beginSearch;
    UISearchBar * _searchBar;

    
}
@property (nonatomic, strong)        UISearchController * searchController;
;

@property (assign, nonatomic ) id<AddPlaceDelegate>delegate;
@end
