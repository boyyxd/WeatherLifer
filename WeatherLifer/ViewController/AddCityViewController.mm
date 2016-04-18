//
//  AddCityViewController.m
//  WeatherLifer
//
//  Created by ink on 15/6/19.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "AddCityViewController.h"
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define LastCity @"LastCity"
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480

@interface AddCityViewController ()

@end

@implementation AddCityViewController
-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
}
-(void)viewWillDisappear:(BOOL)animated
{

    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _searcher.delegate = nil;
    _geoSearcher.delegate = nil;
    _poiSearch.delegate = nil;
    [UIApplication sharedApplication].statusBarHidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarHidden = YES;
    beginSearch = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 /255.0 alpha:1.0];
    UIButton * cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:47 / 255.0 green:120 / 255.0 blue:208 /255.0 alpha:1.0] forState:UIControlStateNormal];
    cancelButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 60);
    [self.view addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 100, 0, 100, 40)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor colorWithRed:47 / 255.0 green:120 / 255.0 blue:208 /255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:sureButton];
    sureButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    [sureButton addTarget:self action:@selector(addPlace) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:sureButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    titleLabel.text = @"添加地点";
    titleLabel.textColor = [UIColor colorWithRed:47 / 255.0 green:120 / 255.0 blue:208 /255.0 alpha:1.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    placeArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat mapHeight;
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
            mapHeight = 300;
            break;
        case Iphone5:
        case Iphone4:{
            mapHeight = 200;
            break;
        }
        default:
            break;
    }

    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 60, ScreenWidth,mapHeight)];
    BMKLocationViewDisplayParam * myObject = [[BMKLocationViewDisplayParam alloc] init];
    myObject.isAccuracyCircleShow = NO;
    [_mapView updateLocationViewWithParam:myObject];
   
    [self.view addSubview:_mapView];
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin_large.png"]];
    imageView.frame = CGRectMake(0, 0, 34, 34);
    [self.view addSubview:imageView];
    imageView.center = _mapView.center;
    
    UIButton * goBackButton  = [[UIButton alloc] initWithFrame:CGRectMake(10, self.navigationController.navigationBar.frame.size.height + mapHeight - 6, 36, 36)];
    [self.view addSubview:goBackButton];
    [goBackButton setImage:[UIImage imageNamed:@"pin3.png"] forState:UIControlStateNormal];
    [goBackButton addTarget:self action:@selector(goBackToMyLocation) forControlEvents:UIControlEventTouchUpInside];
//    imageView.center = _mapView.center;
    
//    UITextField * textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
//    [self.view addSubview:textFiled];
//    textFiled.returnKeyType = UIReturnKeySearch;

//    textFiled.delegate = self;
    
//    backView = [[UIView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:backView];
//    backView.backgroundColor = [UIColor grayColor];
//    backView.alpha = 0.5;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,  self.navigationController.navigationBar.frame.size.height + 20, ScreenWidth, 40)];
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.tintColor = [UIColor blackColor];
    _searchBar.placeholder = @"搜索城市";
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
//    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset( self.navigationController.navigationBar.frame.size.height + 20);
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//    }];
//    UIView * view = [searchBar.subviews firstObject];
//    for (UIView * viewT in view.subviews) {
//        if ([viewT isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            viewT.backgroundColor = [UIColor whiteColor];
//            break;
//        }else if ([viewT isKindOfClass:NSClassFromString(@"UISearchBarTextField")]){
//            NSLog(@"haha");
//        }
//    }

//    [[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    
    
//    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//    searchDisplayController.delegate = self;
//    searchDisplayController.searchResultsDataSource = self;
//    searchDisplayController.searchResultsDelegate = self;

    
    
    //    NSLog(@"%@",[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] );
//     UITextField *text = [[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0];
//    NSLog(@"%@",text);
    _searcher = [[BMKSuggestionSearch alloc] init];
    _searcher.delegate = self;
    _geoSearcher = [[BMKGeoCodeSearch alloc] init];
    _geoSearcher.delegate = self;
    _poiSearch = [[BMKPoiSearch alloc] init];
    _poiSearch.delegate = self;
    _placeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, mapHeight + 60 +  self.navigationController.navigationBar.frame.size.height, ScreenWidth, ScreenHeigth - self.navigationController.navigationBar.frame.size.height - mapHeight - 60)];
    [self.view addSubview:_placeTableView];
    _placeTableView.delegate = self;
    _placeTableView.dataSource = self;
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0,  self.navigationController.navigationBar.frame.size.height + 60, ScreenWidth, ScreenHeigth -  self.navigationController.navigationBar.frame.size.height - 60)];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor grayColor];
    backView.alpha = 0.5;
    backView.hidden = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [backView addGestureRecognizer:tap];
    
    searchCityArray = [NSMutableArray array];
    _searchCityTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 60, ScreenWidth, ScreenHeigth - self.navigationController.navigationBar.frame.size.height - 60)];
    [self.view addSubview:_searchCityTabelView];
    _searchCityTabelView.delegate = self;
    _searchCityTabelView.dataSource = self;
    _searchCityTabelView.hidden = YES;
}
- (void)goBackToMyLocation{
    [_locService startUserLocationService];

}
- (void)addPlace{
//    UIAlertController * alertContoller = [UIAlertController alertControllerWithTitle:@"TA在这个城市" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertContoller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"你最关心的人";
//    }];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"跳过" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
//
//        
//        NSIndexPath * indexPath = [_placeTableView indexPathForSelectedRow];
//        BMKPoiInfo * info = placeArray[indexPath.row];
//        PlaceModel * model = [PlaceModel new];
//        model.city = info.city;
//        model.address = info.address;
//        model.lon = info.pt.longitude;
//        model.lat = info.pt.latitude;
//        model.nickName = @"";
//        NSLog(@"%d",[PlaceListData addPlaceData:model]);
//        [self dismissViewControllerAnimated:YES completion:^{
//            [self.delegate addCityWithModel:model];
//            
//        }];
//
//    }];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        NSIndexPath * indexPath = [_placeTableView indexPathForSelectedRow];
//        UITextField * textField = alertContoller.textFields.firstObject;
//
//        BMKPoiInfo * info = placeArray[indexPath.row];
//        PlaceModel * model = [PlaceModel new];
//        model.city = info.city;
//        model.address = info.address;
//        model.lon = info.pt.longitude;
//        model.lat = info.pt.latitude;
//        model.nickName = textField.text;
//        NSLog(@"%d",[PlaceListData addPlaceData:model]);
//        [self dismissViewControllerAnimated:YES completion:^{
//            [self.delegate addCityWithModel:model];
//            
//        }];
//
//
//    }];
//    [alertContoller addAction:cancelAction];
//    [alertContoller addAction:okAction];
//    [self presentViewController:alertContoller animated:YES completion:nil];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"TA在这个城市" message:nil delegate:self cancelButtonTitle:@"跳过" otherButtonTitles:@"好的", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    UITextField * alertText=[alertView textFieldAtIndex:0];
    alertText.placeholder=@"你最关心的人";
    alertText.keyboardType = UIKeyboardTypeDefault;

    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            NSIndexPath * indexPath = [_placeTableView indexPathForSelectedRow];
            BMKPoiInfo * info = placeArray[indexPath.row];
            PlaceModel * model = [PlaceModel new];
            model.city = info.city;
            model.address = info.address;
            model.lon = info.pt.longitude;
            model.lat = info.pt.latitude;
            model.nickName = @"";
            NSLog(@"%d",[PlaceListData addPlaceData:model]);
            [self dismissViewControllerAnimated:YES completion:^{
                [self.delegate addCityWithModel:model];
                
            }];

            break;
        }
        case 1:{
            NSIndexPath * indexPath = [_placeTableView indexPathForSelectedRow];

            BMKPoiInfo * info = placeArray[indexPath.row];
            PlaceModel * model = [PlaceModel new];
            model.city = info.city;
            model.address = info.address;
            model.lon = info.pt.longitude;
            model.lat = info.pt.latitude;
            model.nickName = [alertView textFieldAtIndex:0].text;
            NSLog(@"%d",[PlaceListData addPlaceData:model]);
            [self dismissViewControllerAnimated:YES completion:^{
                [self.delegate addCityWithModel:model];
                
            }];

            
            break;
        }
            
        default:
            break;
    }
}
- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _placeTableView) {
        
        return placeArray.count;
    }else{
        return searchCityArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _placeTableView) {
    static NSString * cellIdentifer = @"cell";
    AddPlaceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[AddPlaceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifer];
    }
        
        BMKPoiInfo * info = placeArray[indexPath.row];
        cell.textLabel.text = info.name;
        cell.detailTextLabel.text = [info.city stringByAppendingString:info.address];
                return cell;
    }else{
        static NSString * cellIdentifer = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifer];
        }

        SuggestionModel * model = searchCityArray[indexPath.row];
        cell.textLabel.text = model.name;
        cell.detailTextLabel.text = [model.city stringByAppendingString:model.district];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (tableView == _placeTableView) {
        
        BMKPoiInfo * info = placeArray[indexPath.row];
        BMKCoordinateRegion region;
        region = BMKCoordinateRegionMake(info.pt, BMKCoordinateSpanMake(0.02, 0.02));//越小地图显示越详细
        
        
        [_mapView setRegion:region animated:YES];//执行设定显示范围
    }else{
        _searchCityTabelView.hidden = YES;
        SuggestionModel * model = searchCityArray[indexPath.row];
        CLLocationCoordinate2D coord;
        [model.ptValue getValue:&coord];
        BMKCoordinateRegion region;
        region = BMKCoordinateRegionMake(coord, BMKCoordinateSpanMake(0.02, 0.02));//越小地图显示越详细
        
        
        [_mapView setRegion:region animated:YES];//执行设定显示范围
             beginSearch = NO;
        CGRect viewRect = self.view.frame;
        viewRect.origin.y += self.navigationController.navigationBar.frame.size.height ;
        CGRect navRect = self.navigationController.navigationBar.frame;
        navRect.origin.y += self.navigationController.navigationBar.frame.size.height + 20;
        _searchBar.showsCancelButton = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = viewRect;
            self.navigationController.navigationBar.frame = navRect;
        }];
        
        backView.hidden = YES;
        


    }

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    BMKPoiSearch
    BMKSuggestionSearchOption * option = [[BMKSuggestionSearchOption alloc] init];
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * cityString = [userDefault objectForKey:LastCity];
    if (cityString.length == 0) {
        cityString = @"中国";
    }
    option.cityname =cityString;
    option.keyword = searchText;
    BOOL flag = [_searcher suggestionSearch:option];
    NSLog(@"%@",searchText);
}
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"%@,%@,%@",result.keyList,result.cityList,result.poiIdList);
    [searchCityArray removeAllObjects];
    for (int i = 0; i < result.keyList.count; i++) {
        SuggestionModel * model = [SuggestionModel new];
        model.name = result.keyList[i];
        model.city = result.cityList[i];
        model.district = result.districtList[i];
        model.ptValue = result.ptList[i];
        CLLocationCoordinate2D coord;
        [model.ptValue getValue:&coord];
        if (coord.longitude != 0 && coord.latitude !=0) {
            
            [searchCityArray addObject:model];
        }
    }
    [_searchCityTabelView reloadData];
    for (NSValue * value in result.ptList) {
        CLLocationCoordinate2D coord;
        [value getValue:&coord];
        NSLog(@"%f,%f",coord.latitude,coord.longitude);
    }

    

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [_locService stopUserLocationService];
    [_mapView updateLocationData:userLocation];
    BMKCoordinateRegion region;
    region = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.02, 0.02));//越小地图显示越详细
    
    
    [_mapView setRegion:region animated:YES];//执行设定显示范围

}
- (void)mapStatusDidChanged:(BMKMapView *)mapView{
    [self.view endEditing:YES];
    [mapView getMapStatus];
}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"%f,%f",mapView.region.center.longitude,mapView.region.center.longitude);
    BMKReverseGeoCodeOption * reverseGeoOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoOption.reverseGeoPoint = mapView.region.center;
    BOOL flag = [_geoSearcher reverseGeoCode:reverseGeoOption];
    if (flag) {
        NSLog(@"haha");
    }
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    option.location = mapView.region.center;
//    option.keyword = @"地区";
//    BOOL flag = [_poiSearch poiSearchNearBy:option];
//    if(flag)
//    {
//        NSLog(@"周边检索发送成功");
//    }
//    else
//    {
//        NSLog(@"周边检索发送失败");
//    }
}
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        for (BMKPoiInfo * info in poiResultList.poiInfoList) {
            NSLog(@"%@",info.name);
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
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
        [placeArray removeAllObjects];
        BMKPoiInfo * tmpInfo = [[BMKPoiInfo alloc] init];
        tmpInfo.name = [result.addressDetail.streetName stringByAppendingString:result.addressDetail.streetNumber];
        tmpInfo.city = result.addressDetail.city;
        NSString * address = [result.addressDetail.district stringByAppendingString:result.addressDetail.streetName];
        tmpInfo.address = [address stringByAppendingString:result.addressDetail.streetNumber];
        tmpInfo.pt = result.location;
        [placeArray addObject:tmpInfo];
        if (result.address.length !=0) {
            for (BMKPoiInfo * info in result.poiList) {
                NSLog(@"%@",info.name);
                [placeArray addObject:info];

            }
            [_placeTableView reloadData];
            [_placeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }else{
            NSLog(@"非中国");
        }
        
    }
}
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    NSLog(@"哈哈");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",event);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    NSLog(@"%@",touch.view);
    return YES;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"haha");
    if (!beginSearch) {
        
    
    CGRect viewRect = self.view.frame;
    viewRect.origin.y -= self.navigationController.navigationBar.frame.size.height ;
    CGRect navRect = self.navigationController.navigationBar.frame;
    navRect.origin.y -= self.navigationController.navigationBar.frame.size.height + 20;
    searchBar.showsCancelButton = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = viewRect;
        self.navigationController.navigationBar.frame = navRect;
    }];
    _searchCityTabelView.hidden = NO;
    backView.hidden = NO;
        beginSearch = YES;
    }
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    CGRect viewRect = self.view.frame;
//    viewRect.origin.y += self.navigationController.navigationBar.frame.size.height ;
//    CGRect navRect = self.navigationController.navigationBar.frame;
//    navRect.origin.y += self.navigationController.navigationBar.frame.size.height + 20;
//    searchBar.showsCancelButton = NO;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.view.frame = viewRect;
//        self.navigationController.navigationBar.frame = navRect;
//    }];
////    _searchCityTabelView.hidden = YES;
//    backView.hidden = YES;
    return YES;
}
- (void)endEdit{
    [self.view endEditing:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    beginSearch = NO;
    CGRect viewRect = self.view.frame;
    viewRect.origin.y += self.navigationController.navigationBar.frame.size.height ;
    CGRect navRect = self.navigationController.navigationBar.frame;
    navRect.origin.y += self.navigationController.navigationBar.frame.size.height + 20;
    searchBar.showsCancelButton = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = viewRect;
        self.navigationController.navigationBar.frame = navRect;
    }];
    
    backView.hidden = YES;
    
    _searchCityTabelView.hidden = YES;
    [self.view endEditing:YES];

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
