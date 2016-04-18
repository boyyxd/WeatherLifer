//
//  CutImageViewController.h
//  WeatherLifer
//
//  Created by ink on 15/5/12.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CutImageViewController : UIViewController
- (instancetype)initWithImage:(UIImage *)image;
@property (nonatomic, strong) UIImage * iconImage;//天气图标
@property (nonatomic, copy) NSString * temperatureText;//温度文字
@property (nonatomic, strong) NSMutableArray * textArray;//文字数组
@property (nonatomic, assign) BOOL isWhite;//文字颜色
@property (nonatomic, copy) NSString * imageName;//图片名字
@property (nonatomic, copy) NSString * placeString;//地址名字

@end
