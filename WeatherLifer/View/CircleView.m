//
//  CircleView.m
//  WeatherLifer
//
//  Created by ink on 15/6/10.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CircleView.h"
#define Circle_Padding 3
#define Circle_LineWidth 4

@implementation CircleView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.opaque = NO;
        
        self.angle = 0;

        [self addBackImageView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addBackImageView];
    }
    return self;
}
- (void)addBackImageView{
    UIImage * backImage = [UIImage imageNamed:@"dial_aqi.png"];
    UIImageView * backImageView = [UIImageView new];
    [self addSubview:backImageView];
    backImageView.image = backImage;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
    self.aqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.aqiLabel.center = self.center;
    self.aqiLabel.textColor = [UIColor whiteColor];
    self.aqiLabel.textAlignment = NSTextAlignmentCenter;
    self.aqiLabel.font = [UIFont systemFontOfSize:25];
    [self addSubview:self.aqiLabel];
//    self.aqiImageView = [UIImageView new];
//    [self addSubview:self.aqiImageView];
//    [self.aqiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.centerY.equalTo(self.mas_bottom).with.offset(-23);
//    }];

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    CGFloat  radius = self.frame.size.width/2 - Circle_Padding;

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx,
                    self.frame.size.width/2,
                    self.frame.size.height/2,
                    radius,
                    0,
                    M_PI *2,
                    0);
    [[UIColor colorWithWhite:1.0 alpha:0.1]setStroke];
    CGContextSetLineWidth(ctx, Circle_LineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextDrawPath(ctx, kCGPathStroke);
    if (self.currentValue == 0) {
        CGContextAddArc(ctx,
                        self.frame.size.width/2,
                        self.frame.size.height/2,
                        radius,
                        - M_PI- (M_PI_2  /2),
                        - M_PI- (M_PI_2  /2 ),
                        0);
        
    }else{
        CGContextAddArc(ctx,
                        self.frame.size.width/2,
                        self.frame.size.height/2,
                        radius,
                        - M_PI- (M_PI_2 / 2),
                        self.angle,
                        0);

        
    }


    CGContextSetLineWidth(ctx, Circle_LineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    [[UIColor colorWithRed:57 / 255.0 green:216 / 255.0 blue:254 / 255.0 alpha:1.0] setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
//    CGContextRelease(ctx);


}
-(void)movehandleToValue:(float)value{
    if (value>self.maxValue) {
        value=self.maxValue;
    }else if (value<self.minValue){
        value= self.minValue;
    }
    self.currentValue = value;
    if (self.currentValue == 0) {
        self.angle = -M_PI_2;
    }else{
        
        self.angle = [self getAngleWithValue:self.currentValue];
    }
    [self setNeedsDisplay];
}
- (float)getAngleWithValue:(CGFloat)value{
    NSLog(@"%f",value);
    return  - M_PI- (M_PI_2 /2 ) + (value / self.maxValue * (2 * M_PI -  M_PI_2));
}




@end
