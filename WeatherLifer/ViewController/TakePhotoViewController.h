//
//  TakePhotoViewController.h
//  WeatherLifer
//
//  Created by ink on 15/6/23.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSimpleCamera.h"
#import "CameraTopView.h"
#import "CameraBottomView.h"
#import "CutImageViewController.h"
#import "MMDrawerController.h"
#import "EditImageViewController.h"
#import "PhotoModel.h"
#import "Masonry.h"
#import "WeatherIconData.h"
#import "TimeOperation.h"
@interface TakePhotoViewController : UIViewController<CameraBottomDelegate,CameraTopDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    LLSimpleCamera * _camera;
    UILabel * _authLabel;
    BOOL isBlack;


}
/**
 *  相机头部
 */

@property (nonatomic, strong)     CameraTopView * topView;
/**
 *  相机底部
 */

@property (nonatomic, strong)     CameraBottomView * bottomView;
/**
 *  照片相关数据
 */

@property (nonatomic, strong) PhotoModel * model;

/**
 *  温度
 */
@property (nonatomic, strong)UILabel * temperatureLaber;
/**
 *  地点
 */
@property (nonatomic, strong)UILabel * locationLabel;
/**
 *  文字
 */
@property (nonatomic, strong)UILabel * textLabel;

@property (nonatomic, strong)UILabel * textLabelS;

@property (nonatomic, strong)UILabel * textLabelT;
/**
 *  天气图标
 */
@property (nonatomic, strong) UIImageView * weatherImageView;
/**
 *  位置信息
 */

@property (nonatomic, copy) NSString * locationString;

@end
