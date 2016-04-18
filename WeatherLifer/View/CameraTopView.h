//
//  CameraTopView.h
//  WeatherLifer
//
//  Created by ink on 15/3/13.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CameraTopDelegate
- (void)cancelButtonPress;
- (void)frontOrBackButtonPress;
- (void)opeartionFlashPower:(BOOL)operation;
@end

@interface CameraTopView : UIView

/**
 *  闪光灯开关
 */
@property (assign) BOOL flashOn;

@property (nonatomic, assign) id<CameraTopDelegate>delegate;

@property (nonatomic, strong) UIButton * cameraSwitchButton;

@property (nonatomic, strong) UIButton * flashButton;

@end
