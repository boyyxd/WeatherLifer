//
//  TemperatureStraightLine.m
//  WeatherLifer
//
//  Created by ink on 15/6/1.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "TemperatureStraightLine.h"
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define MidNight @"午夜"
#define EarlyMorning @"凌晨"
#define Morning @"早晨"
#define AM @"上午"
#define Noon @"中午"
#define PM @"下午"
#define Evening @"傍晚"
#define Night @"晚上"
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480

#define itemWidth (ScreenWidth - 20) * 2  / 24.0f
@implementation TemperatureStraightLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        timeLabelArray = [NSMutableArray array];
        self.pointArray = [NSMutableArray array];
        self.bottomPointArray = [NSMutableArray array];
        labelArray = [NSMutableArray array];
        self.valueArray = [NSMutableArray array];
        self.bottomValueArray = [NSMutableArray array];
        imageArray = [NSMutableArray array];
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = {
            1.0, 1.0, 1.0, 0.3,
            1.0, 1.0, 1.0, 0.3
        };
        gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);;
        self.backgroundColor = [UIColor clearColor];
        [self initTemperatureLable];
        [self addTimeLabel];
     
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)initTemperatureLable{
    for (int i = 0; i < 25; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 0;
        [self addSubview:label];
        [labelArray addObject:label];
    }

}
- (void)addTimeLabel{
    for (int i = 0; i < 6; i++) {
        UILabel * dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:dateLabel];
        [timeLabelArray addObject:dateLabel];
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:
                dateLabel.center = CGPointMake(itemWidth + itemWidth * i * 4,  CGRectGetHeight(self.frame) - 20);

                break;
            case Iphone4:{
                dateLabel.center = CGPointMake(itemWidth + itemWidth * i * 4,  CGRectGetHeight(self.frame) - 14);
                break;
            }
            default:
                break;
        }

        
    }
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(ctx);
        for (int i = 1; i < 24; i++) {
            
            CGContextMoveToPoint(ctx, itemWidth * i, CGRectGetHeight(self.frame));
            CGContextAddLineToPoint(ctx,itemWidth * i, CGRectGetHeight(self.frame) - 6);
        }
    
        CGContextSetStrokeColorWithColor(ctx,[UIColor colorWithWhite:1 alpha:0.5].CGColor);
        CGContextSetLineWidth(ctx, 1);
        CGContextStrokePath(ctx);
    
    
        CGContextClosePath(ctx);
    if (self.pointArray.count != 0) {
    UIBezierPath * linePath = [UIBezierPath bezierPath];
    UIBezierPath * fillPath = [UIBezierPath bezierPath];
    [fillPath moveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height )];
    CGPoint point;
    NSValue *value = self.pointArray[0];
    point = value.CGPointValue;
    [fillPath addLineToPoint:CGPointMake(0, self.frame.size.height )];
    [fillPath addLineToPoint:point];
    [linePath moveToPoint:point];
    for (int i = 1; i < self.pointArray.count; i++) {
        NSValue * pointValue = self.pointArray[i];
        point = pointValue.CGPointValue;
        [linePath addLineToPoint:point];
        [fillPath addLineToPoint:point];
    }
    [[UIColor colorWithWhite:0.2 alpha:0.1] set];
    [fillPath fillWithBlendMode:kCGBlendModeNormal alpha:1];
    if (gradient != nil) {
        CGContextSaveGState(ctx);
        CGContextAddPath(ctx, [fillPath CGPath]);
        CGContextClip(ctx);
        CGContextDrawLinearGradient(ctx, gradient, CGPointZero, CGPointMake(0, CGRectGetMaxY(fillPath.bounds)), 0);
        CGContextRestoreGState(ctx);
    }
    


    if (!lineLayer) {
        
        lineLayer = [CAShapeLayer layer];
    }
    [lineLayer setPath:linePath.CGPath];
    [lineLayer setFillColor:[UIColor clearColor].CGColor];
    [lineLayer setStrokeColor:[UIColor whiteColor].CGColor];
    [lineLayer setLineWidth:2];
    [self.layer addSublayer:lineLayer];
    CGContextBeginPath(ctx);
        CGContextSetLineWidth(ctx, 1);
        CGFloat dashArray[] = {2,2};
        CGContextSetLineDash(ctx, 0, dashArray, 1);
    NSArray * topArray =[self getBottomPointToUpWithArray:self.bottomPointArray AndLinePointArray:self.pointArray];
       for (int i = 0; i < self.bottomPointArray.count-1; i++) {
        NSValue * bottomValue = self.bottomPointArray[i];
        NSValue * topValue = topArray[i];
        CGContextMoveToPoint(ctx, bottomValue.CGPointValue.x, CGRectGetHeight(self.frame));
        CGContextAddLineToPoint(ctx, topValue.CGPointValue.x, topValue.CGPointValue.y);

    }
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
        
    CGContextStrokePath(ctx);
        [self startAnimation];
        for (int i = 0; i < self.pointArray.count; i++) {
            NSValue * value = self.pointArray[i];
            CGPoint  point = value.CGPointValue;
            UILabel * label = labelArray[i];
            point.y -= 40;
            if (i == 0) {
                point.x += 10;
            }else if (i == self.pointArray.count - 1){
                point.x -= 10;
            }
            label.center = point;
            
            label.alpha = 0;
            label.text = nil;
            if (i % 4 == 0) {
                if (self.Aqi) {
                    
                    label.text = [NSString stringWithFormat:@"%i",(int)round([self.valueArray[i] doubleValue])];
                }else{
                    label.text = [NSString stringWithFormat:@"%i°",(int)round([self.valueArray[i] doubleValue])];

                }
            }

        }
        [self startLabelAnimation];
        for (UIImageView * imageView in imageArray) {
            [imageView removeFromSuperview];
        }
        NSArray * imageTmpArray = [self getImageViewPoint:self.bottomPointArray];
        if (imageTmpArray.count == self.bottomValueArray.count) {
            for (int i =0; i < self.bottomValueArray.count ; i++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
                NSValue * pointValue = imageTmpArray[i];
                imageView.center = pointValue.CGPointValue;
                WeatherIconModel * model = [WeatherIconData getWeatherIcon:[self.bottomValueArray[i] integerValue]];
                NSString * imageName;
                if ([TimeOperation judgeTheTime:[NSDate date]]) {
                    imageName = [NSString stringWithFormat:@"%@",model.dayImageName];
                    
                }else{
                    imageName = [NSString stringWithFormat:@"%@",model.nightImageName];
                    
                }

                imageView.image = [UIImage imageNamed:imageName];
                imageView.alpha = 0;
                [self addSubview:imageView];
                [imageArray addObject:imageView];
            }
            
        }
        [self startImageViewAm];
        

    }
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMddHH"];
    NSDate * startDate = [formatter dateFromString:self.startTime];
    for (int i = 0; i < timeLabelArray.count; i++) {
        UILabel * label = timeLabelArray[i];
        NSDate * timeDate;
        if (i == 0) {
            timeDate  = [NSDate dateWithTimeInterval:3600 sinceDate:startDate];

        }else{
            timeDate  = [NSDate dateWithTimeInterval:(i * 4 + 1) * 3600 sinceDate:startDate];

        }
        
        label.text = [self getTimeString:timeDate];
    }

    
}
/**
 *  添加天气动画
 */
- (void)startImageViewAm{
    for ( UIImageView * imageView in imageArray) {
        CGPoint point  = imageView.center;
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:
                point.y -= 66;
                break;
            case Iphone4:{
                point.y -= 57;
                break;
            }
            default:
                break;
        }


        [UIView animateWithDuration:1 animations:^{
            imageView.center = point;
            imageView.alpha = 1;
        }];
    }

}
- (NSArray *)getBottomPointToUpWithArray:(NSArray *)bottomArray AndLinePointArray:(NSArray *)linePointArray{
    NSMutableArray * upArray = [NSMutableArray array];
    for (int i = 0; i < bottomArray.count; i++) {
        NSValue * bottomValue = bottomArray[i];
        CGPoint bottomPoint = bottomValue.CGPointValue;
        for (int j = 0; j < linePointArray.count; j++) {
            NSValue * linePointVlaue = linePointArray[j];
            CGPoint linePoint = linePointVlaue.CGPointValue;
            if (bottomPoint.x >= linePoint.x) {
                NSValue * nextValue;
                if (j < linePointArray.count-1) {
                    nextValue = linePointArray[j+1];
                }

                if (nextValue.CGPointValue.x >= bottomPoint.x) {
                    
                CGPoint  upPoint = [self getPointWithPointA:linePoint AndPointB:nextValue.CGPointValue andXpoint:bottomPoint.x];
                    [upArray addObject:[NSValue valueWithCGPoint:upPoint]];
                    break;
                }
            }
        }
    }
    return upArray;
}

- (CGPoint)getPointWithPointA:(CGPoint)pointA AndPointB:(CGPoint)pointB andXpoint:(CGFloat)x{
    CGFloat y = pointA.y * ((pointB.x - x) / (pointB.x - pointA.x)) + pointB.y * ((x - pointA.x) / (pointB.x - pointA.x));
    
    return CGPointMake(x, y);
}
- (void)startAnimation{
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    [strokeAnimation setDelegate:self];
    [strokeAnimation setDuration:3];
    [strokeAnimation setFromValue:@0];
    [strokeAnimation setToValue:@1];
    [lineLayer addAnimation:strokeAnimation forKey:@"lockAnimation"];

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        NSLog(@"finish");

    }
}

- (void)startLabelAnimation{
    for (UILabel * label in labelArray) {
        CGPoint point  = label.center;
        point.y += 30;
        [UIView animateWithDuration:1 animations:^{
            label.center = point;
            label.alpha = 1;
        }];
    }
}
- (NSArray *)getImageViewPoint:(NSArray *)pointArray{
    NSLog(@"%@,%f",pointArray,self.frame.size.width);
    NSMutableArray * resultArray = [NSMutableArray array];
    NSValue * p1Value = pointArray[0];
    CGPoint p1 = p1Value.CGPointValue;
    CGPoint p2;
    [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake(p1.x / 2, CGRectGetHeight(self.frame) + 17)]];
    if (pointArray.count > 1) {
        for (int i = 0; i < pointArray.count - 1; i++) {
            NSValue * pointValue = pointArray[i];
            p1 = pointValue.CGPointValue;
            NSValue * pPointValue = pointArray[i + 1];
            p2 = pPointValue.CGPointValue;
            [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake((p1.x + p2.x) / 2,CGRectGetHeight(self.frame) + 17)]];
        }
    }
    return resultArray;
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
    [formatter setDateFormat:@"h"];
    if ([judgeString isEqualToString:@"上午"]) {
        if (hourTime == 12) {
            timeString = [NSString stringWithFormat:@"%@%@时",MidNight,[formatter stringFromDate:date]];
        }else if (hourTime >= 1 && hourTime < 5){
            timeString = [NSString stringWithFormat:@"%@%@时",EarlyMorning,[formatter stringFromDate:date]];
            
        }else if (hourTime >= 5 && hourTime < 8){
            timeString = [NSString stringWithFormat:@"%@%@时",Morning,[formatter stringFromDate:date]];
            
        }else if (hourTime >=8 && hourTime <12){
            timeString = [NSString stringWithFormat:@"%@%@时",AM,[formatter stringFromDate:date]];
            
        }
    }else{
        if (hourTime == 12) {
            timeString = [NSString stringWithFormat:@"%@%@时",Noon,[formatter stringFromDate:date]];
            
        }else if (hourTime >= 1 && hourTime < 5){
            timeString = [NSString stringWithFormat:@"%@%@时",PM,[formatter stringFromDate:date]];
            
        }else if (hourTime >= 5 && hourTime <7){
            timeString = [NSString stringWithFormat:@"%@%@时",Evening,[formatter stringFromDate:date]];
            
        }else if (hourTime >= 7 && hourTime < 12){
            timeString = [NSString stringWithFormat:@"%@%@时",Night,[formatter stringFromDate:date]];
            
        }
    }
    return timeString;
    
}



@end
