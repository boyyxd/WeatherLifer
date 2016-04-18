//
//  AirPressure.m
//  WeatherLifer
//
//  Created by ink on 15/6/12.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "AirPressure.h"

@implementation AirPressure
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addBackImageView];
        [self addPointer];
    }
    return self;
}
- (void)addBackImageView{
    UIImage *backImage = [UIImage imageNamed:@"dial_pressure.png"];
    UIImageView * backImageView = [UIImageView new];
    [self addSubview:backImageView];
    backImageView.image = backImage;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);

    }];
}
- (void)addPointer{
    UIImage * pointerImage = [UIImage imageNamed:@"dial_pressure_ico.png"];
    _pointerImageView = [UIImageView new];
    [self addSubview:_pointerImageView];
    _pointerImageView.image = pointerImage;
    [_pointerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(pointerImage.size);
        make.center.mas_equalTo(self.center);
    }];
}
- (void)moveToValue:(CGFloat)value{
    if (value>self.maxValue) {
        value=self.maxValue;
    }else if (value<self.minValue){
        value= self.minValue;
    }
    CGFloat angle = M_PI * value / self.maxValue;
    _pointerImageView.layer.transform = CATransform3DMakeRotation(-M_PI_2 + angle, 0, 0, 1);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
