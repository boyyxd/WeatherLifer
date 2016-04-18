//
//  CircleRing.h
//  WeatherLifer
//
//  Created by ink on 15/6/10.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleRing : UIView{
    int radius;
}
@property (nonatomic,assign) float angle;
@property (nonatomic) int currentValue;
@property (nonatomic) float maxValue;
@property (nonatomic) float minValue;
/**
 *  湿度
 */
@property (nonatomic, strong) UILabel * humLabel;
-(void)movehandleToValue:(float)value;
@end
