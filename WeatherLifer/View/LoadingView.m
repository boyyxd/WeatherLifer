//
//  LoadingView.m
//  WeatherLifer
//
//  Created by ink on 15/7/3.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"loading_bg.png"];
        indicatorView = [[MONActivityIndicatorView alloc] init];
        indicatorView.numberOfCircles = 3;
        indicatorView.radius = 5;
        indicatorView.internalSpacing = 10;
        indicatorView.center = CGPointMake(self.center.x, self.center.y - 30);
        [self addSubview:indicatorView];
//        [indicatorView startAnimating];
        UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
        [self addSubview:textLabel];
        textLabel.text = @"正在加载天气";
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.center = CGPointMake(self.center.x, self.center.y );
        textLabel.textColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0];

    }
    return self;
}
#pragma mark -
#pragma mark - MONActivityIndicatorViewDelegate Methods

/**
 *  加载动画代理方法
 *
 *  @param activityIndicatorView
 *
 *  @return 加载试图
 */
- (void)startAm{
    self.hidden = NO;
    [indicatorView startAnimating];

}
- (void)stopAm{
    self.hidden = YES;
    [indicatorView stopAnimating];
}

@end
