//
//  LeftViewController.m
//  WeatherLifer
//
//  Created by ink on 15/6/19.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "LeftViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define LastCity @"LastCity"
#define LastAddress @"LastAddress"
#define LastCounty @"LastCounty"
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.weatherDataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 /255.0 alpha:1.0];
      UIView * topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 40, 54)];
    [self.view addSubview:topBackView];
    placeListArray = [NSMutableArray arrayWithArray:[PlaceListData getPlaceList]];
    UIButton * tmp = [[UIButton alloc] initWithFrame:CGRectMake( ScreenWidth - 94, 0, 54, 54)];
    [self.view addSubview:tmp];
    [tmp setImage:[UIImage imageNamed:@"header_plus.png"] forState:UIControlStateNormal];
    [tmp addTarget:self action:@selector(addCity) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * settingButton = [[UIButton alloc] initWithFrame:CGRectMake( 0, 0, 54, 54)];
    [self.view addSubview:settingButton];
    [settingButton setImage:[UIImage imageNamed:@"header_set.png"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(jumpToSettingPage) forControlEvents:UIControlEventTouchUpInside];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 54, ScreenWidth - 40, 1)];
    [self.view addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithRed:195 / 255.0 green:195 / 255.0 blue:195 / 255.0 alpha:1.0];
    _placeListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth - 40, ScreenHeigth - 55)];
    _placeListTableView.delegate = self;
    _placeListTableView.dataSource = self;
    _placeListTableView.backgroundColor = [UIColor clearColor];
    _placeListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_placeListTableView];
}
/**
 *  跳转到设置界面
 */
- (void)jumpToSettingPage
{
    SettingViewController* settingView = [SettingViewController new];
    UINavigationController* settingNav = [[UINavigationController alloc]initWithRootViewController:settingView];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:settingNav animated:YES completion:nil];
}

/**
 *  添加城市
 */
- (void)addCity{
    [UIApplication sharedApplication].statusBarHidden = NO;

    AddCityViewController * addCityViewControlle = [AddCityViewController new];
    addCityViewControlle.delegate = self;
    UINavigationController * addNav = [[UINavigationController alloc] initWithRootViewController:addCityViewControlle];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:addNav animated:YES completion:nil];
}
#pragma mark tableviewDateSoure

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return placeListArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath * )indexPath{
    static NSString * cellIdentifier = @"cell";
    PlaceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PlaceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.locationImageView.image = nil;
    if (self.weatherDataArray.count != 0) {
        NSDictionary * dic = self.weatherDataArray[indexPath.row];
        cell.tempLabel.text =[NSString stringWithFormat:@"%i°",(int)round([[dic objectForKey:@"tmp"] doubleValue])];
        WeatherIconModel * model = [WeatherIconData getWeatherIcon:[[dic objectForKey:@"wcode"] integerValue]];
        NSString * imageName;
        if ([TimeOperation judgeTheTime:[NSDate date]]) {
            imageName = [NSString stringWithFormat:@"%@b",model.dayImageName];
            
        }else{
            imageName = [NSString stringWithFormat:@"%@b",model.nightImageName];
            
        }
        cell.weatherIconImageView.image =  [UIImage imageNamed:imageName];

        NSLog(@"%@",dic);
    }

    if (indexPath.row == 0) {
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        NSString * cityString = [userDefault objectForKey:LastCity];
        if (cityString.length <= 3) {
            cell.placeNameLabel.text = cityString;
        }else{
            
            cell.placeNameLabel.text = [NSString stringWithFormat:@"%@...",[cityString substringToIndex:3]];
        }
        cell.locationImageView.image = [UIImage imageNamed:@"pin.png"];
        NSString * addressString = [[userDefault objectForKey:LastCounty] stringByAppendingString:[userDefault objectForKey:LastAddress]];
        if (addressString.length <= 10) {
            
            cell.addressLabel.text = addressString;
        }else{
            cell.addressLabel.text = [NSString stringWithFormat:@"%@...",[addressString substringToIndex:10]];
        }
    }else{
        PlaceModel * model = placeListArray[indexPath.row - 1];
        if (model.nickName.length != 0) {
            if (model.city.length <= 3) {
                if (model.nickName.length <= 3) {
                    cell.placeNameLabel.text = [NSString stringWithFormat:@"%@(%@)", model.city,model.nickName];

                }else{
                    
                    cell.placeNameLabel.text = [NSString stringWithFormat:@"%@(%@...)", model.city,[model.nickName substringToIndex:3]];
                }
            }else{
                if (model.nickName.length <= 3) {
                    cell.placeNameLabel.text = [NSString stringWithFormat:@"%@...(%@)", [model.city substringToIndex:3],model.nickName];
                    
                }else{
                    
                    cell.placeNameLabel.text = [NSString stringWithFormat:@"%@...(%@...)", [model.city substringToIndex:3],[model.nickName substringToIndex:3]];

                }

                
            }
        }else{
            if (model.city.length <= 3) {
                
                cell.placeNameLabel.text = model.city;
            }else{
                cell.placeNameLabel.text = [NSString stringWithFormat:@"%@...", [model.city substringToIndex:3]];
                
            }
        }
        if (model.address.length <= 10) {
            
            cell.addressLabel.text = model.address;
        }else{
            cell.addressLabel.text = [NSString stringWithFormat:@"%@",[model.address substringToIndex:10]];

        }

    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self.delegate selectPlaceWithModel:nil andRow:indexPath.row];
    }else{
        [self.delegate selectPlaceWithModel:placeListArray[indexPath.row - 1] andRow:indexPath.row];
    }
}
/**
 *  根据添加城市
 *
 *  @param model 城市model
 */
- (void)addCityWithModel:(PlaceModel *)model{
    [self.delegate selectPlaceWithModel:model andRow:1];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
//        UIAlertController * alertContoller = [UIAlertController alertControllerWithTitle:@"当前位置,无法删除" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            }];
//        [alertContoller addAction:okAction];
//        [self presentViewController:alertContoller animated:YES completion:nil];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"当前位置,无法删除" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        PlaceModel * model = placeListArray[indexPath.row - 1];
        [PlaceListData deletePlaceWithLon:model.lon AndLat:model.lat];
        [placeListArray removeAllObjects];
        [placeListArray addObjectsFromArray:[PlaceListData getPlaceList]];
        [_placeListTableView reloadData];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  刷新城市数据
 */
- (void)refreshCityWeather{
    [placeListArray removeAllObjects];
    [placeListArray addObjectsFromArray:[PlaceListData getPlaceList]];

    [_placeListTableView reloadData];
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
