//
//  WeekAirLine.m
//  WeatherLifer
//
//  Created by ink on 15/6/18.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeekAirLine.h"

@implementation WeekAirLine
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.linePointArray = [NSMutableArray array];
        self.valueArray = [NSMutableArray array];
        topLabelArray = [NSMutableArray array];
        bottomLabelArray = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
        [self initTopLable];
        [self initBottomLable];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath * linePath = [UIBezierPath bezierPath];
    CGPoint CP1;
    CGPoint CP2;
    
    CGPoint p0;
    CGPoint p1;
    CGPoint p2;
    CGPoint p3;
    CGFloat tensionBezier1 = 0.3;
    CGFloat tensionBezier2 = 0.3;
    if (self.linePointArray.count >0) {
        for (int i = 0; i < self.linePointArray.count - 1; i++) {
            if (i >= 6) {
                break;
            }
            NSValue * p1Value = self.linePointArray[i];
            p1 = p1Value.CGPointValue;
            NSValue * p2Value = self.linePointArray[i + 1];
            p2 = p2Value.CGPointValue;
            [linePath moveToPoint:p1];
            if (i > 0) {
                NSValue * p0Value = self.linePointArray[i - 1];
                p0 = p0Value.CGPointValue;
            }else{
                p0 = p1;
            }
            if (i < self.linePointArray.count - 2) {
                NSValue * p3Value = self.linePointArray[i + 2];
                p3 = p3Value.CGPointValue;
            }else{
                p3 = p2;
            }
            CP1 = CGPointMake(p1.x + (p2.x - p1.x)/3,
                              p1.y - (p1.y - p2.y)/3 - (p0.y - p1.y)*tensionBezier1);
            
            // Second control point
            CP2 = CGPointMake(p1.x + 2*(p2.x - p1.x)/3,
                              (p1.y - 2*(p1.y - p2.y)/3) + (p2.y - p3.y)*tensionBezier2);
            
            [linePath addCurveToPoint:p2 controlPoint1:CP1 controlPoint2:CP2];
            
        }
    }
    if (!_lineLayer) {
        _lineLayer = [CAShapeLayer layer];
        
    }
    [_lineLayer setPath:linePath.CGPath];
    [_lineLayer setFillColor:[UIColor clearColor].CGColor];
    [_lineLayer setStrokeColor:[UIColor colorWithRed:248 / 255.0  green:236 / 255.0 blue:131 / 255.0 alpha:1.0].CGColor];
    [_lineLayer setLineWidth:2];
    [self.layer addSublayer:_lineLayer];
    for (int i = 0; i < self.linePointArray.count; i++) {
        if (i >= 7) {
            break;
        }
        NSValue * value = self.linePointArray[i];
        CGPoint  point = value.CGPointValue;
        UILabel * label = bottomLabelArray[i];
        point.y += 20;
        label.center = point;
        NSNumber * num = [self.valueArray[i] objectForKey:@"aqi"];
        label.text = [NSString stringWithFormat:@"%i",(int)round(num.doubleValue)];
        point.y -= 40;
        UILabel * labelT = topLabelArray[i];
        labelT.center = point;
        labelT.text = [self.valueArray[i] objectForKey:@"tip"];
    }



}
- (void)initTopLable{
    for (int i = 0; i < 7; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        label.textColor = [UIColor colorWithRed:248 / 255.0  green:236 / 255.0 blue:131 / 255.0 alpha:1.0];
        label.font = [UIFont boldSystemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [topLabelArray addObject:label];
    }
    
}
- (void)initBottomLable{
    for (int i = 0; i < 7; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        label.textColor = [UIColor colorWithRed:248 / 255.0  green:236 / 255.0 blue:131 / 255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [bottomLabelArray addObject:label];
    }
    
}




@end
