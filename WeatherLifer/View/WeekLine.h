//
//  WeekLine.h
//  WeatherLifer
//
//  Created by ink on 15/6/5.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekLine : UIView{
    CAShapeLayer * upShapeLayer;
    CAShapeLayer * bottomShapeLayer;
    NSMutableArray * topLabelArray;
    NSMutableArray * bottomLabelArray;
}
/**
 *  顶部曲线
 */
@property (nonatomic, strong) NSMutableArray * upLineArray;
/**
 *  底部曲线
 */
@property (nonatomic, strong) NSMutableArray * bottomArray;
/**
 *  顶部曲线数据
 */
@property (nonatomic, strong) NSMutableArray * upValueArray;
/**
 *  底部曲线数据
 */
@property (nonatomic, strong) NSMutableArray * bottomValueArray;
@end
