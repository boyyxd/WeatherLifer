//
//  AirPressure.h
//  WeatherLifer
//
//  Created by ink on 15/6/12.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface AirPressure : UIView{
    UIImageView * _pointerImageView;
}
@property (nonatomic) float maxValue;
@property (nonatomic) float minValue;
- (void)moveToValue:(CGFloat)value;
@end
