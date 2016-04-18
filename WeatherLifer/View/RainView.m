//
//  RainView.m
//  WeatherLifer
//
//  Created by ink on 15/6/24.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "RainView.h"
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define MinuteWidth (ScreenWidth - 20) / 60
#define itemWidth (ScreenWidth - 20)   / 6.f
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480

@implementation RainView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pointArray = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
//        UILabel * bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 34)];
//        bigLabel.textColor = [UIColor whiteColor];
//        [self addSubview:bigLabel];
//        bigLabel.text = @"暴雨";
//        
//        UILabel * nomalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, 100, 34)];
//        nomalLabel.textColor = [UIColor whiteColor];
//        [self addSubview:nomalLabel];
//        nomalLabel.text = @"大雨";
//        
//        UILabel * smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 68, 100, 34)];
//        smallLabel.textColor = [UIColor whiteColor];
//        [self addSubview:smallLabel];
//        smallLabel.text = @"中雨";
//        UILabel * msmallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 102, 100, 34)];
//        msmallLabel.textColor = [UIColor whiteColor];
//        [self addSubview:msmallLabel];
//        msmallLabel.text = @"小雨";

        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = {
            133 / 255.0, 218 / 255.0, 255 / 255.0, 0.5,
            133 / 255.0, 218 / 255.0, 255 / 255.0, 0.5
        };
        gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
        NSInteger time = 10;
        for (int i = 0; i < 6; i++) {
            UILabel * dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
            dateLabel.textColor = [UIColor whiteColor];
            dateLabel.font = [UIFont systemFontOfSize:13];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:dateLabel];
            switch ((NSInteger)ScreenHeigth) {
                case Iphone6:
                case Iphone6p:
                case Iphone5:
                    dateLabel.center = CGPointMake(itemWidth + itemWidth * i * 2,  CGRectGetHeight(self.frame) - 20);

                    break;
                case Iphone4:{
                    dateLabel.center = CGPointMake(itemWidth + itemWidth * i * 2,  CGRectGetHeight(self.frame) - 14);

                    break;
                }
                default:
                    break;
            }

            dateLabel.text = [NSString stringWithFormat:@"%d分钟",time *  2 * i + 10];
            
        }


    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat lineHeight;
    CGFloat toBottom;
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
        case Iphone5:
            lineHeight = 34;
            toBottom = 32;
            break;
        case Iphone4:{
            lineHeight = 24;
            toBottom = 26;
            
            break;
        }
        default:
            break;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    for (int i = 1; i < 12; i++) {
        
        CGContextMoveToPoint(ctx, itemWidth * i,CGRectGetHeight(self.frame) - toBottom);
        CGContextAddLineToPoint(ctx,itemWidth * i,CGRectGetHeight(self.frame) - toBottom - 6);
    }

    
    CGContextSetStrokeColorWithColor(ctx,[UIColor colorWithWhite:1 alpha:0.5].CGColor);
    CGContextSetLineWidth(ctx, 1);
    CGContextStrokePath(ctx);

    CGContextMoveToPoint(ctx, 0, CGRectGetHeight(self.frame) - toBottom);
    CGContextAddLineToPoint(ctx, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - toBottom);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokePath(ctx);
    CGFloat dashArray[] = {2,2};
    CGContextSetLineDash(ctx, 0, dashArray, 1);
    CGContextMoveToPoint(ctx, 0,CGRectGetHeight(self.frame) - toBottom - lineHeight * 3);
    CGContextAddLineToPoint(ctx, CGRectGetWidth(self.frame),CGRectGetHeight(self.frame) - toBottom - lineHeight * 3);
    CGContextStrokePath(ctx);
    CGContextMoveToPoint(ctx, 0,CGRectGetHeight(self.frame) - toBottom - lineHeight * 2);
    CGContextAddLineToPoint(ctx, CGRectGetWidth(self.frame),CGRectGetHeight(self.frame) - toBottom -lineHeight * 2);
    CGContextMoveToPoint(ctx, 0,CGRectGetHeight(self.frame) - toBottom - lineHeight);
    CGContextAddLineToPoint(ctx, CGRectGetWidth(self.frame),CGRectGetHeight(self.frame) - toBottom - lineHeight);

    CGContextStrokePath(ctx);
    CGContextClosePath(ctx);

    UIBezierPath * path = [UIBezierPath bezierPath];
    CGPoint CP1;
    CGPoint CP2;
    
    CGPoint p0;
    CGPoint p1;
    CGPoint p2;
    CGPoint p3;
    CGFloat tensionBezier1 = 0.3;
    CGFloat tensionBezier2 = 0.3;
    if (self.pointArray.count >0) {
        NSValue * lastValue = [self.pointArray lastObject];
        [path moveToPoint:CGPointMake(lastValue.CGPointValue.x,CGRectGetHeight(self.frame) - toBottom)];
        NSValue * p1Value =[self.pointArray objectAtIndex:0];

        [path addLineToPoint:CGPointMake(p1Value.CGPointValue.x,CGRectGetHeight(self.frame) - toBottom)];
        for (int i = 0; i < self.pointArray.count - 1; i++) {
            NSValue * p1Value = self.pointArray[i];
            p1 = p1Value.CGPointValue;
            NSValue * p2Value = self.pointArray[i + 1];
            p2 = p2Value.CGPointValue;
            [path addLineToPoint:p1];
            if (i > 0) {
                NSValue * p0Value = self.pointArray[i - 1];
                p0 = p0Value.CGPointValue;
            }else{
                p0 = p1;
            }
            if (i < self.pointArray.count - 2) {
                NSValue * p3Value = self.pointArray[i + 2];
                p3 = p3Value.CGPointValue;
            }else{
                p3 = p2;
            }
            CP1 = CGPointMake(p1.x + (p2.x - p1.x)/3,
                              p1.y - (p1.y - p2.y)/3 - (p0.y - p1.y)*tensionBezier1);
            
            // Second control point
            CP2 = CGPointMake(p1.x + 2*(p2.x - p1.x)/3,
                              (p1.y - 2*(p1.y - p2.y)/3) + (p2.y - p3.y)*tensionBezier2);
            
            
            [path addCurveToPoint:p2 controlPoint1:CP1 controlPoint2:CP2];
            
            
        }
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        if (gradient != nil) {
            CGContextSaveGState(ctx);
            CGContextAddPath(ctx, [path CGPath]);
            CGContextClip(ctx);
            CGContextDrawLinearGradient(ctx, gradient, CGPointZero, CGPointMake(0, CGRectGetMaxY(path.bounds)), 0);
            CGContextRestoreGState(ctx);
        }

    }

    
}


@end
