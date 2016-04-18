//
//  Thermomter.h
//  WeatherLifer
//
//  Created by ink on 15/6/9.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "MAThermometer.h"
@interface Thermomter : UIView{
    MAThermometer * _thermometer;
}
@property (nonatomic) int currentValue;
@property (nonatomic) float maxValue;
@property (nonatomic) float minValue;
/**
 *   温度
 */
@property (nonatomic, strong) UILabel * tempLabel;

-(void)movehandleToValue:(float)value;

@end
