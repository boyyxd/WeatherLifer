//
//  CirclLabelText.m
//  WeatherLifer
//
//  Created by ink on 15/3/4.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CirclLabelText.h"

@implementation CirclLabelText
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.anchorPoint = CGPointMake(0.5, 1);

        self.backgroundColor = [UIColor clearColor];
        _tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), 20)];
        _tempLabel.textAlignment = NSTextAlignmentCenter;
        _tempLabel.textColor = [UIColor whiteColor];
        _tempLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_tempLabel];


    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    CAShapeLayer * cicleLayer = [CAShapeLayer layer];
    cicleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)) radius:5 startAngle:M_PI endAngle:-M_PI clockwise:NO].CGPath;
    cicleLayer.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.3].CGColor;
    cicleLayer.fillColor = [UIColor whiteColor].CGColor;
    cicleLayer.lineWidth = 6.0f;
    [self.layer addSublayer:cicleLayer];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
