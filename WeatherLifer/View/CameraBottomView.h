//
//  CameraBottomView.h
//  WeatherLifer
//
//  Created by ink on 15/3/13.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CameraBottomDelegate
- (void)changeTextColor;
- (void)selectAlbums;

@end

@interface CameraBottomView : UIView

@property (nonatomic, assign) id<CameraBottomDelegate>delegate;

@property (nonatomic, strong) UIButton * changeTextColorButton;
@property (nonatomic, strong) UIButton * photoAlbumsButton;
@end
