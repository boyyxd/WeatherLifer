//
//  EveryDayLine.m
//  WeatherLifer
//
//  Created by ink on 15/6/18.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "EveryDayLine.h"
#define MidNight @"午夜"
#define EarlyMorning @"凌晨"
#define Morning @"早晨"
#define AM @"上午"
#define Noon @"中午"
#define PM @"下午"
#define Evening @"傍晚"
#define Night @"晚上"
#define AnimationDuration 10
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define MiniteWidth [UIScreen mainScreen].bounds.size.width / 24.f


@implementation EveryDayLine
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%f",self.frame.size.width);
        [self initBasicData];
        self.backgroundColor = [UIColor clearColor];
        if (!textView) {
            
            
            textView = [[CirclLabelText alloc] initWithFrame:CGRectMake(0, 0, 75, 50)];
            [self addSubview:textView];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAnimationBackGround) name:UIApplicationDidEnterBackgroundNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimationActive) name:UIApplicationDidBecomeActiveNotification object:nil];
            [self addTimeLabel];

        }
    }
    return self;
}
- (void)addTimeLabel{
    for (int i = 0; i < 28; i++) {
        UILabel * dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:dateLabel];
        [timeLabelArray addObject:dateLabel];
        dateLabel.text = @"1";
        dateLabel.center = CGPointMake(MiniteWidth * 2 + MiniteWidth * i * 6,  CGRectGetHeight(self.frame) - 60);
        
    }
}

/**
 *  初始化基础数据
 */
- (void)initBasicData{
    self.lineValueArray = [NSMutableArray array];
    self.linePointArray = [NSMutableArray array];
    self.weatherPointArray = [NSMutableArray array];
    weatherImageArray = [NSMutableArray array];
    self.divArray = [NSMutableArray array];
    qualityLabelArray = [NSMutableArray array];
    timeLabelArray = [NSMutableArray array];
    positionNum = 0;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.linePointArray.count > 0) {
        
    
    UIBezierPath * linePath = [UIBezierPath bezierPath];
        linePath.miterLimit = 1;
        linePath.lineWidth = 3;
    UIBezierPath * fillPath = [UIBezierPath bezierPath];
        fillPath.miterLimit = 1;
        fillPath.lineWidth = 3;
    CGPoint CP1;
    CGPoint CP2;
    CGPoint p0;
    CGPoint p1;
    CGPoint p2;
    CGPoint p3;
    CGFloat tensionBezier1 = 0.3;
    CGFloat tensionBezier2 = 0.3;
    [fillPath moveToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [fillPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    for (int i = 0; i < self.linePointArray.count - 1; i++) {
        NSValue * p1Value = self.linePointArray[i];
        p1 = p1Value.CGPointValue;
        NSValue * p2Value = self.linePointArray[i + 1];
        p2 = p2Value.CGPointValue;
        [linePath moveToPoint:p1];
        [fillPath addLineToPoint:p1];
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
        [fillPath addCurveToPoint:p2 controlPoint1:CP1 controlPoint2:CP2];
        }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (self.lineGrandient != nil) {
        CGContextSaveGState(ctx);
        CGContextAddPath(ctx, [fillPath CGPath]);
        CGContextClip(ctx);
        CGContextDrawLinearGradient(ctx, self.lineGrandient, CGPointZero, CGPointMake(0, CGRectGetMaxY(fillPath.bounds)), 0);
        CGContextRestoreGState(ctx);
    }
        
        for (int i = 1; i < 7; i++) {
            NSValue * value = self.linePointArray[i * 8];
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextMoveToPoint(context, value.CGPointValue.x, CGRectGetHeight(self.frame) - 40);
            CGContextAddLineToPoint(context, value.CGPointValue.x,value.CGPointValue.y);
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextStrokePath(context);
            
        }
        CGContextMoveToPoint(ctx, 0, CGRectGetHeight(self.frame) - 40);
        CGContextAddLineToPoint(ctx, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 40);
        CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextStrokePath(ctx);
        
        CGContextBeginPath(ctx);
        for (int i = 1; i < 24 * 7; i++) {
            
            CGContextMoveToPoint(ctx, MiniteWidth * i,CGRectGetHeight(self.frame) - 40);
            CGContextAddLineToPoint(ctx,MiniteWidth * i, CGRectGetHeight(self.frame) - 46);
        }
        
        CGContextSetStrokeColorWithColor(ctx,[UIColor colorWithWhite:1 alpha:0.5].CGColor);
        CGContextSetLineWidth(ctx, 1);
        CGContextStrokePath(ctx);
        
        
        CGContextClosePath(ctx);


        

        if (!linePathNew) {
            linePathNew = [UIBezierPath bezierPath];
        }
        NSLog(@"%f,%f,%f",linePath.bounds.size.width,self.frame.size.width,fillPath.bounds.size.width);
        linePathNew = linePath;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        CAKeyframeAnimation * pathAnimation = [CAKeyframeAnimation animationWithKeyPath:NSStringFromSelector(@selector(position))];
        pathAnimation.duration = 10;
        pathAnimation.path = linePathNew.CGPath;
        pathAnimation.speed = 0;
        pathAnimation.beginTime = 0;
        pathAnimation.beginTime = positionNum;
        pathAnimation.timeOffset = positionNum;
        pathAnimation.removedOnCompletion = NO;
        [textView.layer addAnimation:pathAnimation forKey:NSStringFromSelector(@selector(position))];
        
        [CATransaction commit];
        CGContextBeginPath(ctx);
        CGContextSetLineWidth(ctx, 1);
        CGFloat dashArray[] = {2,2};
        CGContextSetLineDash(ctx, 0, dashArray, 1);

        for (int i = 0; i < [self.weatherPointArray[0] count] - 1; i++) {
            NSValue * bottomValue = self.weatherPointArray[0][i];
            CGContextMoveToPoint(ctx, bottomValue.CGPointValue.x, CGRectGetHeight(self.frame));
            CGContextAddLineToPoint(ctx, bottomValue.CGPointValue.x,  CGRectGetHeight(self.frame) - 40);
            
        }
        CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);

            CGContextStrokePath(ctx);

        
        
        
        
        for (int i =0; i < [self.divArray[0] count] - 1; i++) {
            NSValue * pointValue = self.divArray[0][i];
            CGPoint point = pointValue.CGPointValue;
            CGContextMoveToPoint(ctx, point.x,  CGRectGetHeight(self.frame) - 40);
            CGContextAddLineToPoint(ctx, point.x, [self getPointYOnBezierPath:linePath WithXAxis:point.x]);
        }
        CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextStrokePath(ctx);
        
        
        for (UILabel * lable in qualityLabelArray) {
            [lable removeFromSuperview];
        }
        
        
        
        NSArray * labelTmpArray = [self getQualityPoint:self.divArray[0]];
        if (labelTmpArray.count == [self.divArray[1] count]) {
            for (int i =0; i < [self.divArray[1] count] ; i++) {
                UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28, 50)];
                label.textAlignment = NSTextAlignmentCenter;
                label.numberOfLines = 0;
                label.textColor = [UIColor whiteColor];
//                label.font = [UIFont systemFontOfSize:13];
                NSValue * pointValue = labelTmpArray[i];
                label.center = CGPointMake(pointValue.CGPointValue.x+ 2,   CGRectGetHeight(self.frame) - 100) ;
                [self addSubview:label];
                label.backgroundColor = [UIColor clearColor];
//                label.text = [self FormatSting:self.divArray[1][i]];
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: [self FormatSting:self.divArray[1][i]]];
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                
                [paragraphStyle setLineSpacing:0];//调整行间距
                
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[self FormatSting:self.divArray[1][i]] length])];
                label.attributedText = attributedString;
                [qualityLabelArray addObject:label];
            }
            
        }

        
        
        
        
        

        
        
        
        
        
        
        
        
        
        
        for (UIImageView * imageView in weatherImageArray) {
            [imageView removeFromSuperview];
        }
        NSArray * imageTmpArray = [self getImageViewPoint:self.weatherPointArray[0]];
        if (imageTmpArray.count == [self.weatherPointArray[1] count]) {
            for (int i =0; i <[self.weatherPointArray[0] count]; i++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
                NSValue * pointValue = imageTmpArray[i];
               
                if (i > 0) {
                    NSValue * pvalue = imageTmpArray[i - 1];
                    NSValue * judgePointValue = self.weatherPointArray[0][i];
                    NSValue * judgePointValuep = self.weatherPointArray[0][i - 1];
                    NSLog(@"-=-=-=-=-=%f,%f,%f,%d,%f",judgePointValue.CGPointValue.x - judgePointValuep.CGPointValue.x,judgePointValue.CGPointValue.x ,judgePointValuep.CGPointValue.x,i, ScreenWidth / 24);
                    if (judgePointValue.CGPointValue.x - judgePointValuep.CGPointValue.x <= ScreenWidth / 24) {
                        imageView.frame = CGRectMake(0, 0, 10, 10);
//                        UIImageView * tmp = weatherImageArray[i-1];
//                        tmp.frame =  CGRectMake(0, 0, 10, 10);
//                        tmp.center = pvalue.CGPointValue;
                    }
                    
                    
                }
                 imageView.center = pointValue.CGPointValue;
                WeatherIconModel * model = [WeatherIconData getWeatherIcon:[self.weatherPointArray[1][i]  integerValue]];
                NSString * imageName;
                if ([TimeOperation judgeTheTime:[NSDate date]]) {
                    imageName = [NSString stringWithFormat:@"%@",model.dayImageName];
                    
                }else{
                    imageName = [NSString stringWithFormat:@"%@",model.nightImageName];
                    
                }
                imageView.image = [UIImage imageNamed:imageName];
                imageView.alpha = 1;
                [self addSubview:imageView];
                [weatherImageArray addObject:imageView];
            }
        
        }
        [self startImageViewAm];
        
        for (int i = 0; i < timeLabelArray.count; i++) {
            UILabel * label = timeLabelArray[i];
            NSDate * timeDate;
            if (i == 0) {
                timeDate  = [NSDate dateWithTimeInterval:3600 * 2 sinceDate:[self getYesterday00Time]];
                
            }else{
                timeDate  = [NSDate dateWithTimeInterval:(i * 6 + 2) * 3600 sinceDate:[self getYesterday00Time]];
                
            }
            
            label.text = [self getTimeLabelString:timeDate];
        }



    }
    
}
/**
 *  添加天气动画
 */
- (void)startImageViewAm{
    for ( UIImageView * imageView in weatherImageArray) {
        CGPoint point  = imageView.center;
        point.y =   CGRectGetHeight(self.frame) - 20;
        [UIView animateWithDuration:1 animations:^{
            imageView.center = point;
            imageView.alpha = 1;
        }];
    }
    
}

/**
 *  移除圆点动画
 */
- (void)removeAnimationBackGround{
    [textView.layer removeAllAnimations];
    textView.layer.opacity = 0;
}
/**
 *  添加圆点动画
 */
- (void)addAnimationActive{
    textView.layer.opacity = 1;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CAKeyframeAnimation * pathAnimation = [CAKeyframeAnimation animationWithKeyPath:NSStringFromSelector(@selector(position))];
    pathAnimation.duration = AnimationDuration;
    pathAnimation.path = linePathNew.CGPath;
    pathAnimation.speed = 0;
    pathAnimation.beginTime = 0;
    pathAnimation.beginTime = positionNum;
    pathAnimation.timeOffset = positionNum;
    pathAnimation.removedOnCompletion = NO;
    [textView.layer addAnimation:pathAnimation forKey:NSStringFromSelector(@selector(position))];
    
    [CATransaction commit];
    
}
/**
 *  根据滑动距离设置圆点位置
 *
 *  @param num 滑动距离
 */
- (void)setCirclePoint:(CGFloat)num{
    CGFloat timeOff = num  / (self.frame.size.width / 10.0f);
    if (timeOff < 0) {
        timeOff = 0;
    }else if (timeOff >= 10){
        timeOff = 10 - 0.00001f;
    }
    positionNum = timeOff;
    textView.tempLabel.text = [self getTimeWithOffSet:num];
    [textView.layer removeAllAnimations];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CAKeyframeAnimation * pathAnimation = [CAKeyframeAnimation animationWithKeyPath:NSStringFromSelector(@selector(position))];
    pathAnimation.duration = AnimationDuration;
    pathAnimation.path = linePathNew.CGPath;
    pathAnimation.speed = 0;
    pathAnimation.beginTime = 0;
    pathAnimation.beginTime = positionNum;
    pathAnimation.timeOffset = positionNum;
    pathAnimation.removedOnCompletion = NO;
    [textView.layer addAnimation:pathAnimation forKey:NSStringFromSelector(@selector(position))];
    
    [CATransaction commit];
    
//    NSLog(@"%@",NSStringFromCGPoint(linePathNew.currentPoint));
    
}
/**
 *  获取日期文字
 *
 *  @param offSet scrollview偏移量
 *
 *  @return 日期字符串
 */
- (NSString *)getTimeWithOffSet:(CGFloat)offSet{
    
    NSDate * futureDate = [NSDate dateWithTimeIntervalSinceNow:-1 * 24 * 60 * 60];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    [gregorian setTimeZone:gmt];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: futureDate];
    [components setHour: 0];
    [components setMinute:0];
    [components setSecond: 0];
    NSDate *newDate = [gregorian dateFromComponents: components];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:newDate];
    newDate = [newDate dateByAddingTimeInterval:-interval];
    NSDate * date = [NSDate dateWithTimeInterval:offSet / ScreenWidth * 24 * 60 * 60 sinceDate:newDate];
    
    return  [self getTimeString:date];
}
/**
 *  判断当前时间文字（上午，下午，午夜）
 *
 *  @param date 要判断的时间
 *
 *  @return 时间字符串
 */
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

//- (NSArray *)getImageViewPoint:(NSArray *)pointArray{
//    NSMutableArray * resultArray = [NSMutableArray array];
//    NSValue * p1Value = pointArray[0];
//    CGPoint p1 = p1Value.CGPointValue;
//    CGPoint p2;
//    [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake(p1.x / 2, CGRectGetHeight(self.frame) + 17)]];
//    if (pointArray.count > 1) {
//        for (int i = 1; i < pointArray.count; i++) {
//            NSValue * pointValue = pointArray[i];
//            p1 = pointValue.CGPointValue;
//            NSValue * pPointValue = pointArray[i - 1];
//            p2 = pPointValue.CGPointValue;
//            [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake((p1.x + p2.x) / 2,CGRectGetHeight(self.frame) + 17)]];
//            
//        }
//    }
//    p1Value = [pointArray lastObject];
//    p1 = p1Value.CGPointValue;
//    [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake((p1.x + CGRectGetWidth(self.frame)) / 2, CGRectGetHeight(self.frame) + 17)]];
//    return resultArray;
//}
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
    //    p1Value = [pointArray lastObject];
    //    p1 = p1Value.CGPointValue;
    //    [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake((p1.x + CGRectGetWidth(self.frame)) / 2, CGRectGetHeight(self.frame) + 17)]];
    return resultArray;
}


- (CGFloat)getPointYOnBezierPath:(UIBezierPath *)path WithXAxis:(CGFloat)x{
    CGPathRef tapTargetPath = CGPathCreateCopyByStrokingPath(path.CGPath, NULL, fmaxf(1.f, path.lineWidth), path.lineCapStyle, path.lineJoinStyle, path.miterLimit);
    
    UIBezierPath *tapTarget = [UIBezierPath bezierPathWithCGPath:tapTargetPath];
    CGPathRelease(tapTargetPath);
    for (int i = 0; i < CGRectGetHeight(self.frame); i++) {
        CGPoint point = CGPointMake(x, i);
        BOOL success = [tapTarget containsPoint:point];
        if (success) {
            
            return i;
        }
    }
    return 0;
    
}

- (NSArray *)getQualityPoint:(NSArray *)pointArray{
    NSLog(@"%@,%f",pointArray,self.frame.size.width);
    NSMutableArray * resultArray = [NSMutableArray array];
    NSValue * p1Value = pointArray[0];
    CGPoint p1 = p1Value.CGPointValue;
    CGPoint p2;
    [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake(p1.x / 2, CGRectGetHeight(self.frame) - 50)]];
    if (pointArray.count > 1) {
        for (int i = 0; i < pointArray.count - 1; i++) {
            NSValue * pointValue = pointArray[i];
            p1 = pointValue.CGPointValue;
            NSValue * pPointValue = pointArray[i + 1];
            p2 = pPointValue.CGPointValue;
            [resultArray addObject:[NSValue valueWithCGPoint:CGPointMake((p1.x + p2.x) / 2,CGRectGetHeight(self.frame) - 50)]];
        }
    }
    return resultArray;
}

- (NSDate *)getYesterday00Time{
    NSDate * futureDate = [NSDate dateWithTimeIntervalSinceNow:-1 * 24 * 60 * 60];
    NSTimeZone *gmt = [NSTimeZone localTimeZone];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    [gregorian setTimeZone:gmt];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: futureDate];
    [components setHour: 0];
    [components setMinute:0];
    [components setSecond: 0];
    [components setNanosecond:0];
    NSDate *newDate = [gregorian dateFromComponents: components];
    return newDate;
}
/**
*  判断当前时间文字（上午，下午，午夜）
*
*  @param date 要判断的时间
*
*  @return 时间字符串
*/
- (NSString *)getTimeLabelString:(NSDate *)date{
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
- (NSString *)FormatSting:(NSString *)string{
    NSMutableArray *letterArray = [NSMutableArray array];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:(NSStringEnumerationByComposedCharacterSequences)
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                [letterArray addObject:substring];
                            }];
    NSString * returnString = [NSString new];
    for (int i = 0; i < letterArray.count; i++) {
        returnString = [returnString stringByAppendingString:[letterArray objectAtIndex:i]];
        if (i != letterArray.count - 1) {
            
            returnString = [returnString stringByAppendingString:@"\n"];
        }
        
    }
    return returnString;
}



@end
