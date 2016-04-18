//
//  CircleRing.m
//  WeatherLifer
//
//  Created by ink on 15/6/10.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CircleRing.h"
#define Circle_Padding 10
#define Circle_LineWidth 10
#define MAXANGLE 360
#define START_ANGLE 90
#define CLOCK_WISE YES


@implementation CircleRing

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"dial_humidity.png"];
        imageView.center = self.center;
        radius = self.frame.size.width/2 - Circle_Padding / 2;
        self.humLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.humLabel.center = self.center;
        self.humLabel.textColor = [UIColor whiteColor];
        self.humLabel.textAlignment = NSTextAlignmentCenter;
        self.humLabel.font = [UIFont systemFontOfSize:25];
        [self addSubview:self.humLabel];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = @"湿度";
        label.center = CGPointMake(self.center.x, self.center.y + 20);
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        self.angle = 0;

    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
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
                        - M_PI_2,
                        - M_PI_2,
                        0);
    
    }else{
        CGContextAddArc(ctx,
                        self.frame.size.width/2,
                        self.frame.size.height/2,
                        radius,
                        - M_PI_2,
                        self.angle,
                        0);

    }
    
    
    CGContextSetLineWidth(ctx, Circle_LineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
//    [[UIColor colorWithRed:57 / 255.0 green:216 / 255.0 blue:254 / 255.0 alpha:1.0] setStroke];
    [[UIColor colorWithWhite:1 alpha:.3] setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    CGContextAddArc(ctx,
                    self.frame.size.width/2,
                    self.frame.size.height/2,
                    40,
                    0,
                    2 * M_PI,
                    0);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:1 alpha:0.1].CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    
    
    

    CGContextSaveGState(ctx);
    CGContextRestoreGState(ctx);
    
//    CGContextRelease(ctx);


}
- (float)getAngleWithValue:(CGFloat)value{
    return -M_PI_2 + (value / self.maxValue * 2 * M_PI);
}
+(float) toRad:(float)deg  withMax:(float)max{
    return ( (M_PI * (deg)) / (max/2) );
}

+(float) toDeg:(float)rad withMax:(float)max
{
    return ( ((max/2) * (rad)) / M_PI );
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



@end
