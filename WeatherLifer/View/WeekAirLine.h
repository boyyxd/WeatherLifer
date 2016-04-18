//
//  WeekAirLine.h
//  WeatherLifer
//
//  Created by ink on 15/6/18.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekAirLine : UIView{
    CAShapeLayer * _lineLayer;
    NSMutableArray * topLabelArray;
    NSMutableArray * bottomLabelArray;
}
/**
 *   坐标数组
 */
@property (nonatomic, strong) NSMutableArray * linePointArray;
/**
 *  数值数组
 */
@property (nonatomic, strong) NSMutableArray * valueArray;


@end
