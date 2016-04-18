//
//  DataComeFromViewController.m
//  WeatherLifer
//
//  Created by ink on 15/4/29.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "DataComeFromViewController.h"
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define ImageWith 300
#define ImageHeigth 232

@interface DataComeFromViewController ()

@end

@implementation DataComeFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.layer.shadowColor = [UIColor clearColor].CGColor;
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6p:{
            self.view.frame = CGRectMake(0, 0, ImageWith * 1.29f, ImageHeigth * 1.29f);
            
            break;
        }
        case Iphone6:{
            self.view.frame = CGRectMake(0, 0, ImageWith * 1.17f, ImageHeigth * 1.17f);
            
            break;
        }
        case Iphone5:{
            self.view.frame = CGRectMake(0, 0, ImageWith , ImageHeigth );
            
        }
        case Iphone4:{
            self.view.frame = CGRectMake(0, 0, ImageWith , ImageHeigth);
            
        }
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
