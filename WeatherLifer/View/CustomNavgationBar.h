//
//  CustomNavgationBar.h
//  WeatherLifer
//
//  Created by ink on 15/5/27.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomNavgationBarDelegate
- (void)selectNavButtonWithTag:(NSInteger)tag;
@end
@interface CustomNavgationBar : UIView{
    NSTimer * _timer;
    UIButton * moreButton;
    UIButton * shareButton;
}

@property (nonatomic, assign) id<CustomNavgationBarDelegate>delegate;
/**
 *  区域
 */
@property (nonatomic, strong) UILabel * countyLabel;

/**
 *  地址
 */
@property (nonatomic, strong) UILabel * addressLabel;
/**
 * 时间
 */
@property (nonatomic, strong) UILabel * timeLabel;
- (void)alreadyShare;
@end
