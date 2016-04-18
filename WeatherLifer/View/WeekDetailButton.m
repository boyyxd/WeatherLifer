//
//  WeekDetailButton.m
//  WeatherLifer
//
//  Created by ink on 15/6/23.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekDetailButton.h"

@implementation WeekDetailButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        for (UIView * view in self.subviews) {
            [view removeFromSuperview];
        }
        [self addContent];
    }
    return self;
}
- (void)addContent{
    self.effectImageView = [UIImageView new];
    [self addSubview:self.effectImageView];
    [self.effectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.greaterThanOrEqualTo(@0);
        make.width.greaterThanOrEqualTo(@0);
    }];
    self.effectLabel = [UILabel new];
    [self addSubview:self.effectLabel];
    [self.effectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(50);
        make.centerY.equalTo(self.mas_centerY).with.offset(-2);
        make.height.greaterThanOrEqualTo(@0);
        make.width.greaterThanOrEqualTo(@0);
        
    }];
    self.effectLabel.textColor = [UIColor whiteColor];
    
}

@end
