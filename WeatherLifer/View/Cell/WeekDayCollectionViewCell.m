//
//  WeekDayCollectionViewCell.m
//  WeatherLifer
//
//  Created by ink on 15/6/15.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekDayCollectionViewCell.h"
#import "Masonry.h"
@implementation WeekDayCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addWeekDay];
    }
    return self;
}
- (void)addWeekDay{
    self.dayLabel = [UILabel new];
    [self addSubview:self.dayLabel];
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.font = [UIFont systemFontOfSize:16];
    self.dayLabel.textColor = [UIColor whiteColor];
    self.dayLabel.alpha = 0.3;

}
- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        self.dayLabel.alpha = 1.0;
    }else{
        self.dayLabel.alpha = 0.3;
    }
}
@end
