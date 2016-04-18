//
//  WindClass.m
//  WeatherLifer
//
//  Created by ink on 15/6/12.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WindClass.h"

@implementation WindClass
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addBackImageView];
        [self addClassImageView];
        [self addPointer];
        self.windLabel = [UILabel new];
        self.windLabel.textColor = [UIColor whiteColor];
        self.windLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.windLabel];
        [self.windLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
            make.centerY.equalTo(self.mas_centerY).with.offset(-17);
            make.centerX.equalTo(self.mas_centerX);
        }];
        self.windLabel.font = [UIFont systemFontOfSize:30];
       UILabel * windClassLabel = [UILabel new];
        windClassLabel.text = @"m/s";
        windClassLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:windClassLabel];
        windClassLabel.textColor = [UIColor whiteColor];
        [windClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
            make.top.equalTo(self.windLabel.mas_bottom).with.offset(-2);
            make.centerX.equalTo(self.mas_centerX);
        }];
        self.windDir = [UILabel new];
        [self addSubview:self.windDir];
        self.windDir.font = [UIFont systemFontOfSize:12];
        self.windDir.textColor = [UIColor whiteColor];
        [self.windDir mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
            make.top.equalTo(windClassLabel.mas_bottom).with.offset(0);
            make.centerX.equalTo(self.mas_centerX);
        }];


    }
    return self;
}
- (void)addBackImageView{
    UIImage *backImage = [UIImage imageNamed:@"dial_wind.png"];
    UIImageView * backImageView = [UIImageView new];
    [self addSubview:backImageView];
    backImageView.image = backImage;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
        
    }];
}
- (void)addClassImageView{
    UIImage *backImage = [UIImage imageNamed:@"dial_wind2.png"];
    _classImageView = [UIImageView new];
    _classImageView.image = backImage;
    [self addSubview:_classImageView];
    [_classImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(backImage.size);
        make.center.mas_equalTo(self.center);
    }];


}
- (void)addPointer{
    UIImage * pointerImage = [UIImage imageNamed:@"dial_wind_ico.png"];
    _pointerImageView = [UIImageView new];
    [self addSubview:_pointerImageView];
    _pointerImageView.image = pointerImage;
    [_pointerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(pointerImage.size);
        make.centerX.equalTo(self.mas_left).with.offset(81);
        make.centerY.equalTo(self.mas_top).with.offset(132);
    }];

}
- (void)moveToValue:(CGFloat)value andWindValue:(CGFloat)windValue{
    if (windValue>self.maxValue) {
        windValue=self.maxValue;
    }else if (windValue<self.minValue){
        windValue= self.minValue;
    }


//    CGFloat windAngle =-M_PI * 5 / 6 + (M_PI + M_PI * 2 / 3) * windValue / self.maxValue;
    CGFloat windAngle =-M_PI * 2 / 3 +  (M_PI + M_PI * 1 / 3) * windValue / self.maxValue;


    _classImageView.layer.transform = CATransform3DMakeRotation(windAngle, 0, 0, 1);
    _pointerImageView.layer.transform = CATransform3DMakeRotation(value, 0, 0, 1);


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
