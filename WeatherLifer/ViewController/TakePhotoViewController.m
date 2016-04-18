//
//  TakePhotoViewController.m
//  WeatherLifer
//
//  Created by ink on 15/6/23.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "TakePhotoViewController.h"
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define BottomHeight 70
#define LastCity @"LastCity"

@interface TakePhotoViewController ()

@end

@implementation TakePhotoViewController
- (void)viewWillAppear:(BOOL)animated{
    [_camera start];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isBlack = NO;
    [self addCamera];
    [self addCameraTop];
    [self addCameraBottom];
    [self addCameraButton];
    [self initContent];
    [self addData];
    
}
/**
 *  添加界面相关信息
 */
- (void)addData{
    self.temperatureLaber.text = [NSString stringWithFormat:@"%i°",(int)round(self.model.temp)];
    WeatherIconModel * model = [WeatherIconData getWeatherIcon:self.model.imageName.integerValue];
    NSString * imageName;
    if ([TimeOperation judgeTheTime:[NSDate date]]) {
        imageName = [NSString stringWithFormat:@"%@w",model.dayImageName];
        
    }else{
        imageName = [NSString stringWithFormat:@"%@w",model.nightImageName];
        
    }
    self.weatherImageView.image =  [UIImage imageNamed:imageName];

       [self setCurrenText:self.model.textArray];
}
/**
 *  设置当前文字
 *
 *  @param textArray 文字数组
 */
- (void)setCurrenText:(NSArray *)textArray{
    self.textLabel.text = nil;
    self.textLabelS.text = nil;
    self.textLabelT.text = nil;
    
    switch (textArray.count) {
        case 1:{
            NSDictionary * dic = textArray[0];
            self.textLabelS.text = [[dic objectForKey:@"text"] description];
            [self setlabelWithString:[dic objectForKey:@"font"] AndBg:[dic objectForKey:@"bg"] WithLabel:self.textLabelS];
            break;
        }
        case 2:{
            NSDictionary * dic = textArray[0];
            self.textLabelS.text = [[dic objectForKey:@"text"] description];
            [self setlabelWithString:[dic objectForKey:@"font"] AndBg:[dic objectForKey:@"bg"] WithLabel:self.textLabelS];
            
            NSDictionary * dic1 = textArray[1];
            self.textLabelT.text = [[dic1 objectForKey:@"text"] description];
            [self setlabelWithString:[dic1 objectForKey:@"font"] AndBg:[dic1 objectForKey:@"bg"] WithLabel:self.textLabelT];
            
            
            break;
        }
        case 3:{
            NSDictionary * dic = textArray[0];
            self.textLabel.text = [[dic objectForKey:@"text"] description];
            [self setlabelWithString:[dic objectForKey:@"font"] AndBg:[dic objectForKey:@"bg"] WithLabel:self.textLabel];
            
            NSDictionary * dic1 = textArray[1];
            self.textLabelS.text = [[dic1 objectForKey:@"text"] description];
            [self setlabelWithString:[dic1 objectForKey:@"font"] AndBg:[dic1 objectForKey:@"bg"] WithLabel:self.textLabelS];
            
            NSDictionary * dic2 = textArray[2];
            self.textLabelT.text = [[dic2 objectForKey:@"text"] description];
            [self setlabelWithString:[dic2 objectForKey:@"font"] AndBg:[dic2 objectForKey:@"bg"] WithLabel:self.textLabelT];
            
            
            break;
        }
            
        default:
            break;
    }
}
/**
 *  设置label
 *
 *  @param size  字号
 *  @param bg    背景
 *  @param label 设置的Label
 */
- (void)setlabelWithString:(NSString *)size AndBg:(NSString *)bg WithLabel:(UILabel *)label{
    NSLog(@"%f",ScreenWidth);
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
            label.font =   [UIFont fontWithName:@"HelveticaNeue-Light" size:19];

            if ([bg isEqualToString:@"N"]) {
                label.backgroundColor = [UIColor clearColor];
            }else if([bg isEqualToString:@"Y"]){
                label.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
            }
            
            break;
        case Iphone5:
        case Iphone4:{
            label.font =   [UIFont fontWithName:@"HelveticaNeue-Light" size:19];
            if ([bg isEqualToString:@"N"]) {
                label.backgroundColor = [UIColor clearColor];
            }else if([bg isEqualToString:@"Y"]){
                label.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
            }
            
            break;
        }
        default:
            break;
    }
}

/**
 *  添加相机
 */
- (void)addCamera{
    _camera = [[LLSimpleCamera alloc] initWithQuality:CameraQualityHigh andPosition:CameraPositionBack];
    _camera.tapToFocus = NO;
    [self.view addSubview:_camera.view];
    _camera.view.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeigth - 44 - 70);

}
/**
 *  添加相机底部
 */

- (void)addCameraBottom{
    _bottomView = [[CameraBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeigth - BottomHeight, ScreenWidth, BottomHeight)];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
}
/**
 *  添加相机头部
 */
- (void)addCameraTop{
    _topView = [[CameraTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    _topView.delegate = self;
    CameraFlash flash = _camera.cameraFlash;
    if (flash == CameraFlashOn) {
        _topView.flashOn = YES;
    }else{
        _topView.flashOn = NO;
    }
    [self.view addSubview:_topView];
}
/**
 *  添加拍照按钮
 */

- (void)addCameraButton{
    UIButton * cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 70)];
    [cameraButton setImage:[UIImage imageNamed:@"photo_button.png"] forState:UIControlStateNormal];
    [self.view addSubview:cameraButton];
    cameraButton.center = _bottomView.center;
    [cameraButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  取消
 */
- (void)cancelButtonPress{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  切换摄像头
 */
- (void)frontOrBackButtonPress{
    [_camera togglePosition];

}
/**
 *  闪光灯操作
 *
 *  @param operation 是否打开
 */
- (void)opeartionFlashPower:(BOOL)operation{
    if (operation) {
        _camera.cameraFlash = CameraFlashOn;
    }else{
        _camera.cameraFlash = CameraFlashOff;
    }

}
/**
 *  更改文字颜色
 */
- (void)changeTextColor{
    if (!isBlack) {
        _temperatureLaber.textColor = [UIColor blackColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabelS.textColor = [UIColor blackColor];
        _textLabelT.textColor = [UIColor blackColor];
        _authLabel.textColor = [UIColor blackColor];
        WeatherIconModel * model = [WeatherIconData getWeatherIcon:self.model.imageName.integerValue];
        NSString * imageName;
        if ([TimeOperation judgeTheTime:[NSDate date]]) {
            imageName = [NSString stringWithFormat:@"%@b",model.dayImageName];
            
        }else{
            imageName = [NSString stringWithFormat:@"%@b",model.nightImageName];
            
        }
        self.weatherImageView.image =  [UIImage imageNamed:imageName];        isBlack = YES;
        
    }else{
        _authLabel.textColor = [UIColor whiteColor];
        _temperatureLaber.textColor = [UIColor whiteColor];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabelS.textColor = [UIColor whiteColor];
        _textLabelT.textColor = [UIColor whiteColor];
        WeatherIconModel * model = [WeatherIconData getWeatherIcon:self.model.imageName.integerValue];
        NSString * imageName;
        if ([TimeOperation judgeTheTime:[NSDate date]]) {
            imageName = [NSString stringWithFormat:@"%@w",model.dayImageName];
            
        }else{
            imageName = [NSString stringWithFormat:@"%@w",model.nightImageName];
            
        }
        self.weatherImageView.image =  [UIImage imageNamed:imageName];                isBlack = NO;
    }

}
/**
 *  选择照片
 */
- (void)selectAlbums{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = NO;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:^{
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage * cameraImage;
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        cameraImage = image;
        
    }
    [picker dismissViewControllerAnimated:NO completion:^{
        [UIApplication sharedApplication].statusBarHidden = YES;
    }];
    CutImageViewController * cutImageViewController = [[CutImageViewController alloc] initWithImage:cameraImage];
    cutImageViewController.iconImage = self.weatherImageView.image;
    cutImageViewController.temperatureText = self.temperatureLaber.text;
    cutImageViewController.isWhite = !isBlack;
    cutImageViewController.placeString = self.locationString;
    WeatherIconModel * model = [WeatherIconData getWeatherIcon:self.model.imageName.integerValue];
    NSString * imageName;
    if ([TimeOperation judgeTheTime:[NSDate date]]) {
        
        imageName = model.dayImageName;
        
    }else{
        imageName = model.nightImageName;
        
    }
    cutImageViewController.imageName =imageName;
    [cutImageViewController.textArray addObjectsFromArray:self.model.textArray];
    
    MMDrawerController * drawController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    UINavigationController * navController = (UINavigationController *)drawController.centerViewController;
    [navController pushViewController:cutImageViewController animated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [UIApplication sharedApplication].statusBarHidden = YES;
    }];
}
/**
 *  拍摄照片
 */
- (void)takePhoto{
    [_camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
        EditImageViewController * editImageViewController = [[EditImageViewController alloc] initWithImage:image];
        editImageViewController.degress = 90;
        editImageViewController.isWhite = !isBlack;
        editImageViewController.iconImage = self.weatherImageView.image;
        editImageViewController.temperatureText = self.temperatureLaber.text;
        editImageViewController.placeString = self.locationString;
        WeatherIconModel * model = [WeatherIconData getWeatherIcon:self.model.imageName.integerValue];
        NSString * imageName;
        if ([TimeOperation judgeTheTime:[NSDate date]]) {
            
            imageName = model.dayImageName;
            
        }else{
            imageName = model.nightImageName;
            
        }

        editImageViewController.imageName = imageName;
        [editImageViewController.textArray addObjectsFromArray:self.model.textArray];
        MMDrawerController * drawController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        UINavigationController * navController = (UINavigationController *)drawController.centerViewController;
        [navController pushViewController:editImageViewController animated:YES];

    } exactSeenImage:YES];
}
/**
 *  初始化内容
 */
- (void)initContent{
    
    self.weatherImageView = [[UIImageView alloc] init];;
    [self.view addSubview:self.weatherImageView];
        [self.weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(44);
            make.left.equalTo(self.view.mas_left).with.offset(10);
            make.width.mas_equalTo(@75);
            make.height.mas_equalTo(@70);
        }];
    
    [self setViewShowdow:self.weatherImageView];
    
    /**
     *  温度
     */
    self.temperatureLaber = [[UILabel alloc] init];
    [self.view addSubview:self.temperatureLaber];
    self.temperatureLaber.textColor = [UIColor whiteColor];
        [self.temperatureLaber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).with.offset(-10);
            make.width.greaterThanOrEqualTo(@0);
            make.height.greaterThanOrEqualTo(@0);
            make.centerY.equalTo(self.weatherImageView.mas_centerY);
        }];
      switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:{
            self.temperatureLaber.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:80];

            break;
        }
        case Iphone5:
        case Iphone4:{
            self.temperatureLaber.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:64];

            
            break;
        }
        default:
            break;
    }

    [self setViewShowdow:self.temperatureLaber];
    
    self.textLabelT = [UILabel new];
    [self.view addSubview:self.textLabelT];
    self.textLabelT.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.textLabelT.textColor = [UIColor whiteColor];
    [self.textLabelT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-90);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.mas_equalTo(@24);
        
    }];
    
    [self setViewShowdow:self.textLabelT];
    
    self.textLabelS = [UILabel new];
    [self.view addSubview:self.textLabelS];
    self.textLabelS.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.textLabelS.textColor = [UIColor whiteColor];
    [self.textLabelS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textLabelT.mas_top).with.offset(-10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.mas_equalTo(@24);
        
    }];
    
    [self setViewShowdow:self.textLabelS];
    /**
     *  文字
     */
    self.textLabel = [UILabel new];
    [self.view addSubview:self.textLabel];
    self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.textLabel.textColor = [UIColor whiteColor];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textLabelS.mas_top).with.offset(-10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.mas_equalTo(@24);
        
    }];
    
    
    [self setViewShowdow:self.textLabel];
    
    
    
    
    
    _authLabel = [UILabel new];
    [self.view addSubview:_authLabel];
    _authLabel.textColor = [UIColor whiteColor];
    _authLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [_authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-75);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
        
    }];

    
    _authLabel.text = self.locationString;
    
    
    
    
    
}
/**
 *  设置VIEW阴影
 *
 *  @param view 要设置的控件
 */
- (void)setViewShowdow:(UIView *)view{
    view.layer.shadowColor = [UIColor colorWithRed:170 / 255.0 green:170 / 255.0 blue:170 / 255.0 alpha:1.0].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 1;
    view.layer.shadowOpacity = 1.0;
    
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
