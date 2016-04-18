//
//  EveryDayLine.h
//  WeatherLifer
//
//  Created by ink on 15/6/18.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CirclLabelText.h"
#import "TimeOperation.h"
#import "WeatherIconData.h"

@interface EveryDayLine : UIView{
    CirclLabelText * textView;
    UIBezierPath * linePathNew;
    CGFloat positionNum;
    NSMutableArray * weatherImageArray;
    NSMutableArray * qualityLabelArray;
    NSMutableArray * timeLabelArray;


}
/**
 *  曲线点数组
 */
@property (nonatomic, strong) NSMutableArray * linePointArray;

/**
 *  曲线数值数组
 */
@property (nonatomic, strong) NSMutableArray * lineValueArray;

/**
 *  曲线渐变色填充
 */
@property (nonatomic, assign) CGGradientRef lineGrandient;
/**
 *  底部天气数组
 */
@property (nonatomic, strong) NSMutableArray * weatherPointArray;


@property (nonatomic, strong) NSMutableArray * divArray;

- (void)setCirclePoint:(CGFloat)num;

@end
