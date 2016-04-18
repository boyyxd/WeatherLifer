//
//  EffectCollectionViewCell.m
//  WeatherLifer
//
//  Created by ink on 15/5/11.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "EffectCollectionViewCell.h"
#import "Masonry.h"
@implementation EffectCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControls];
    }
    return self;
}
- (void)initControls{
    self.layer.borderWidth = 2.0;

    self.exampleImageView = [UIImageView new];
    [self addSubview:self.exampleImageView];
    [self.exampleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.effectLabel = [UILabel new];
    [self addSubview:self.effectLabel];
    self.effectLabel.textColor = [UIColor whiteColor];
    self.effectLabel.textAlignment = NSTextAlignmentCenter;
    [self.effectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_bottom).with.offset(-30);
        make.height.mas_equalTo(@30);
        make.width.equalTo(self.mas_width);
    }];
}
- (void)setSelected:(BOOL)selected{
    if (selected) {
        self.layer.borderColor = [UIColor colorWithRed:80 / 255.0 green:128 / 255.0 blue:180 / 255.0 alpha:1.0].CGColor;
        
    }else{
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
}
@end
