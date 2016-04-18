//
//  CutImageViewController.m
//  WeatherLifer
//
//  Created by ink on 15/5/12.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CutImageViewController.h"
#import "TWImageScrollView.h"
#define NavHeight 44
#define BottomHeight 70
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import "EditImageViewController.h"
@interface CutImageViewController (){
    UIImage * currenImage;
}
@property (strong, nonatomic) TWImageScrollView *imageScrollView;

@end

@implementation CutImageViewController
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        currenImage = image;
        self.textArray = [NSMutableArray array];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self initControls];
    
}
/**
 *  初始化控件
 */
- (void)initControls{
    self.imageScrollView = [[TWImageScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - NavHeight - BottomHeight)];
    [self.view addSubview:self.imageScrollView];
    
    [self.imageScrollView displayImage:currenImage];
    UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:self.imageScrollView.frame];
    lineImageView.center = self.imageScrollView.center;
    lineImageView.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:lineImageView];
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavHeight)];
    navView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:navView];
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, NavHeight)];
    titleLable.text = @"裁剪";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.center = navView.center;
    [self.view addSubview:titleLable];
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, NavHeight)];
    [backButton setImage:[UIImage imageNamed:@"all_arrow_left_w.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeigth - BottomHeight, ScreenWidth, BottomHeight)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    UIButton * makeSureButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [makeSureButton setImage:[UIImage imageNamed:@"photo_button_pressed.png"] forState:UIControlStateNormal];
    [makeSureButton addTarget:self action:@selector(cropAction) forControlEvents:UIControlEventTouchUpInside];
    makeSureButton.center = bottomView.center;
    [self.view addSubview:makeSureButton];
    
}
/**
 *  返回按钮
 */

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  编辑图片
 */
- (void)cropAction {
    EditImageViewController * editImageViewController = [[EditImageViewController alloc] initWithImage:self.imageScrollView.capture];
    editImageViewController.isWhite = self.isWhite;
//    editImageViewController.degress = 0;
    editImageViewController.iconImage = self.iconImage;
    editImageViewController.imageName = self.imageName;
    editImageViewController.placeString = self.placeString;
    editImageViewController.temperatureText = self.temperatureText;
    [editImageViewController.textArray addObjectsFromArray:self.textArray];
//
    [self.navigationController pushViewController:editImageViewController animated:YES];
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
