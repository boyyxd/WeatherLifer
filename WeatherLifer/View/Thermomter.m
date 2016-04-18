//
//  Thermomter.m
//  WeatherLifer
//
//  Created by ink on 15/6/9.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "Thermomter.h"

@implementation Thermomter
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addBackImageView];
        [self addThermomter];
        self.tempLabel = [UILabel new];
        self.tempLabel.textColor = [UIColor whiteColor];
        self.tempLabel.textAlignment = NSTextAlignmentCenter;
        self.tempLabel.font = [UIFont systemFontOfSize:25];
        [self addSubview:self.tempLabel];
        [self.tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_centerX).with.offset(-40);
        }];
        
    }
    return self;
}
- (void)addBackImageView{
    UIImage * backImage = [UIImage imageNamed:@"dial_temp.png"];
    UIImageView * backImageView = [UIImageView new];
    [self addSubview:backImageView];
    backImageView.image = backImage;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
    
    
}
- (void)addThermomter{
    _thermometer = [[MAThermometer alloc] initWithFrame:CGRectMake(0, 90, 6, 100)];
    _thermometer.center = self.center;
    [self addSubview:_thermometer];
    [_thermometer setArrayColors:@[[UIColor colorWithRed:162 / 255.0 green:254 / 255.0 blue:255 / 255.0 alpha:1.0],[UIColor colorWithRed:249 / 255.0 green:238 / 255.0 blue:132 / 255.0 alpha:1.0],[UIColor colorWithRed:253 / 255.0 green:229 / 255.0 blue:2 / 255.0 alpha:1.0]]];
    [_thermometer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(6, 110));
    }];
    
}
-(void)movehandleToValue:(float)value{
    if (value>self.maxValue) {
        value=self.maxValue;
    }else if (value<self.minValue){
        value= self.minValue;
    }
    self.currentValue = value;
    _thermometer.curValue = value;
    [_thermometer setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
