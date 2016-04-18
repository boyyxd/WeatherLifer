//
//  WeekLine.m
//  WeatherLifer
//
//  Created by ink on 15/6/5.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekLine.h"

@implementation WeekLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.upLineArray = [NSMutableArray array];
        self.bottomArray = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
//        [self initContentLayer];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.upLineArray = [NSMutableArray array];
        self.bottomArray = [NSMutableArray array];
        self.upValueArray = [NSMutableArray array];
        self.bottomValueArray = [NSMutableArray array];
        topLabelArray = [NSMutableArray array];
        bottomLabelArray = [NSMutableArray array];
        [self initTopLable];
        [self initBottomLable];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath * upPath = [UIBezierPath bezierPath];
    UIBezierPath * bottomPath = [UIBezierPath bezierPath];
    CGPoint CP1;
    CGPoint CP2;
    
    CGPoint p0;
    CGPoint p1;
    CGPoint p2;
    CGPoint p3;
    CGFloat tensionBezier1 = 0.3;
    CGFloat tensionBezier2 = 0.3;
    if (self.upLineArray.count >0) {
        for (int i = 0; i < self.upLineArray.count - 1; i++) {
            if (i >= 6) {
                break;
            }
            NSValue * p1Value = self.upLineArray[i];
            p1 = p1Value.CGPointValue;
            NSValue * p2Value = self.upLineArray[i + 1];
            p2 = p2Value.CGPointValue;
            [upPath moveToPoint:p1];
            if (i > 0) {
                NSValue * p0Value = self.upLineArray[i - 1];
                p0 = p0Value.CGPointValue;
            }else{
                p0 = p1;
            }
            if (i < self.upLineArray.count - 2) {
                NSValue * p3Value = self.upLineArray[i + 2];
                p3 = p3Value.CGPointValue;
            }else{
                p3 = p2;
            }
            CP1 = CGPointMake(p1.x + (p2.x - p1.x)/3,
                              p1.y - (p1.y - p2.y)/3 - (p0.y - p1.y)*tensionBezier1);
            
            // Second control point
            CP2 = CGPointMake(p1.x + 2*(p2.x - p1.x)/3,
                              (p1.y - 2*(p1.y - p2.y)/3) + (p2.y - p3.y)*tensionBezier2);
            
            
            [upPath addCurveToPoint:p2 controlPoint1:CP1 controlPoint2:CP2];
            
            
        }
    }
    if (!upShapeLayer) {
        upShapeLayer = [CAShapeLayer layer];
        
    }
    [upShapeLayer setPath:upPath.CGPath];
    [upShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [upShapeLayer setStrokeColor:[UIColor yellowColor].CGColor];
    [upShapeLayer setLineWidth:2];
    [self.layer addSublayer:upShapeLayer];
    
    if (self.bottomArray.count >0) {
        for (int i = 0; i < self.bottomArray.count - 1; i++) {
            if (i >= 6) {
                break;
            }

            NSValue * p1Value = self.bottomArray[i];
            p1 = p1Value.CGPointValue;
            NSValue * p2Value = self.bottomArray[i + 1];
            p2 = p2Value.CGPointValue;
            [bottomPath moveToPoint:p1];
            if (i > 0) {
                NSValue * p0Value = self.bottomArray[i - 1];
                p0 = p0Value.CGPointValue;
            }else{
                p0 = p1;
            }
            if (i < self.bottomArray.count - 2) {
                NSValue * p3Value = self.bottomArray[i + 2];
                p3 = p3Value.CGPointValue;
            }else{
                p3 = p2;
            }
            CP1 = CGPointMake(p1.x + (p2.x - p1.x)/3,
                              p1.y - (p1.y - p2.y)/3 - (p0.y - p1.y)*tensionBezier1);
            
            // Second control point
            CP2 = CGPointMake(p1.x + 2*(p2.x - p1.x)/3,
                              (p1.y - 2*(p1.y - p2.y)/3) + (p2.y - p3.y)*tensionBezier2);
            
            
            [bottomPath addCurveToPoint:p2 controlPoint1:CP1 controlPoint2:CP2];
            
            
        }
    }
    if (!bottomShapeLayer) {
        bottomShapeLayer = [CAShapeLayer layer];
        
    }
    [bottomShapeLayer setPath:bottomPath.CGPath];
    [bottomShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [bottomShapeLayer setStrokeColor:[UIColor cyanColor].CGColor];
    [bottomShapeLayer setLineWidth:2];
    [self.layer addSublayer:bottomShapeLayer];
    for (int i = 0; i < self.upLineArray.count; i++) {
        if (i >= 7 ) {
            break;
        }
        NSValue * value = self.upLineArray[i];
        CGPoint  point = value.CGPointValue;
        UILabel * label = topLabelArray[i];
        point.y -= 20;
        label.center = point;
        NSNumber * num = self.upValueArray[i];
        label.text = [NSString stringWithFormat:@"%i°",(int)round(num.doubleValue)];
        
    }
    for (int i = 0; i < self.bottomArray.count; i++) {
        if (i >= 7) {
            break;
        }
        NSValue * value = self.bottomArray[i];
        CGPoint  point = value.CGPointValue;
        UILabel * label = bottomLabelArray[i];
        point.y += 20;
        label.center = point;
        NSNumber * num = self.bottomValueArray[i];
        label.text = [NSString stringWithFormat:@"%i°",(int)round(num.doubleValue)];
        
    }




    
}
- (void)initTopLable{
    for (int i = 0; i < 7; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        label.textColor = [UIColor yellowColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [topLabelArray addObject:label];
    }
    
}
- (void)initBottomLable{
    for (int i = 0; i < 7; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        label.textColor = [UIColor cyanColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [bottomLabelArray addObject:label];
    }
    
}



@end
