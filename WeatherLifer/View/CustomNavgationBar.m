//
//  CustomNavgationBar.m
//  WeatherLifer
//
//  Created by ink on 15/5/27.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CustomNavgationBar.h"
#import "Masonry.h"
#define MidNight @"午夜"
#define EarlyMorning @"凌晨"
#define Morning @"早晨"
#define AM @"上午"
#define Noon @"中午"
#define PM @"下午"
#define Evening @"傍晚"
#define Night @"晚上"

@implementation CustomNavgationBar


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initContent];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBackToFront) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appChangeToBack) name:UIApplicationDidEnterBackgroundNotification object:nil];

    }
    return self;
}
/**
 *  应用进入后台
 */
- (void)appChangeToBack{
    [_timer invalidate];
}
/**
 *  应用回到前台
 */
- (void)appBackToFront{
    _timeLabel.text = [self getTimeString:[NSDate date]];
    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(settime) userInfo:nil repeats:YES];

}
/**
 *  初始化控件
 */
- (void)initContent{
    /**
     *  更多按钮
     */
    moreButton = [UIButton new];
    [self addSubview:moreButton];
    [moreButton setImage:[UIImage imageNamed:@"header_more.png"] forState:UIControlStateNormal];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    moreButton.tag = 1;
    [moreButton addTarget:self action:@selector(buttonPressWithButton:) forControlEvents:UIControlEventTouchUpInside];
    /**
     *  分享按钮
     */
    shareButton = [UIButton new];
    [self addSubview:shareButton];
    [shareButton setImage:[UIImage imageNamed:@"header_share.png"] forState:UIControlStateNormal];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    shareButton.tag = 2;
    [shareButton addTarget:self action:@selector(buttonPressWithButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _countyLabel = [UILabel new];
    [self addSubview:_countyLabel];
    _countyLabel.textColor = [UIColor whiteColor];
    _countyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [_countyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);

    }];
    
    _addressLabel = [UILabel new];
    [self addSubview:_addressLabel];
    _addressLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    _addressLabel.textColor = [UIColor whiteColor];
    _addressLabel.alpha = 0.5;
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.countyLabel.mas_bottom).with.offset(5);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);

    }];
    _timeLabel = [UILabel new];
    [self addSubview:_timeLabel];
    _timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.alpha = 0.5;
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.addressLabel.mas_bottom).with.offset(5);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
        
    }];
    _timeLabel.text = [self getTimeString:[NSDate date]];
   _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(settime) userInfo:nil repeats:YES];
}
- (void)settime{
    _timeLabel.text = [self getTimeString:[NSDate date]];

}
- (void)buttonPressWithButton:(UIButton *)button{
    if (button.tag == 2) {
        shareButton.hidden = YES;
        moreButton.hidden = YES;
    }
    [self.delegate selectNavButtonWithTag:button.tag];
}
- (NSString *)getTimeString:(NSDate *)date{
    NSString * timeString;
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.locale = locale;
    [formatter setDateFormat:@"aa"];
    NSString * judgeString =[formatter stringFromDate:date];
    [formatter setDateFormat:@"h"];
    NSInteger hourTime = [formatter stringFromDate:date].integerValue;
    [formatter setDateFormat:@"h:mm"];
    if ([judgeString isEqualToString:@"上午"]) {
        if (hourTime == 12) {
            timeString = [NSString stringWithFormat:@"%@%@",MidNight,[formatter stringFromDate:date]];
        }else if (hourTime >= 1 && hourTime < 5){
            timeString = [NSString stringWithFormat:@"%@%@",EarlyMorning,[formatter stringFromDate:date]];
            
        }else if (hourTime >= 5 && hourTime < 8){
            timeString = [NSString stringWithFormat:@"%@%@",Morning,[formatter stringFromDate:date]];
            
        }else if (hourTime >=8 && hourTime <12){
            timeString = [NSString stringWithFormat:@"%@%@",AM,[formatter stringFromDate:date]];
            
        }
    }else{
        if (hourTime == 12) {
            timeString = [NSString stringWithFormat:@"%@%@",Noon,[formatter stringFromDate:date]];
            
        }else if (hourTime >= 1 && hourTime < 5){
            timeString = [NSString stringWithFormat:@"%@%@",PM,[formatter stringFromDate:date]];
            
        }else if (hourTime >= 5 && hourTime <7){
            timeString = [NSString stringWithFormat:@"%@%@",Evening,[formatter stringFromDate:date]];
            
        }else if (hourTime >= 7 && hourTime < 12){
            timeString = [NSString stringWithFormat:@"%@%@",Night,[formatter stringFromDate:date]];
            
        }
    }
    return timeString;
    
}
- (void)alreadyShare{
    shareButton.hidden = NO;
    moreButton.hidden = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
