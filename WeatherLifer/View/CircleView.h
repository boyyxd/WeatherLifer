//
//  CircleView.h
//  WeatherLifer
//
//  Created by ink on 15/6/10.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface CircleView : UIView
@property (nonatomic,assign) float angle;
@property (nonatomic) int currentValue;
@property (nonatomic) float maxValue;
@property (nonatomic) float minValue;
/**
 *  aqi
 */
@property (nonatomic, strong) UILabel * aqiLabel;

//@property (nonatomic, strong) UIImageView * aqiImageView;

-(void)movehandleToValue:(float)value;

@end
