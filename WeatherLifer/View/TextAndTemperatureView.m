//
//  TextAndTemperatureView.m
//  WeatherLifer
//
//  Created by ink on 15/5/28.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "TextAndTemperatureView.h"
#import "Masonry.h"

#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define TextToTop 84
@implementation TextAndTemperatureView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        photoModel = [PhotoModel new];
        [self initContent];
        [self addModelObserver];

    }
    return self;
}
- (void)addModelObserver{
    @weakify(self);
    [RACObserve(self, self.model) subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            self.temperatureLaber.text = [NSString stringWithFormat:@"%i°",(int)round(self.model.tmp)];
//            NSLog(@"%@",NSStringFromCGSize([self.temperatureLaber.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:80]]));
            WeatherIconModel * model = [WeatherIconData getWeatherIcon:self.model.wcode.integerValue];
            NSString * imageName;
            if ([TimeOperation judgeTheTime:[NSDate date]]) {
                imageName = [NSString stringWithFormat:@"%@w",model.dayImageName];
                photoModel.imageName = model.dayImageName;

            }else{
                imageName = [NSString stringWithFormat:@"%@w",model.nightImageName];
                photoModel.imageName = model.nightImageName;

            }
            self.weatherImageView.image =  [UIImage imageNamed:imageName];
            [self setCurrenText:self.model.wtxt];
            photoModel.temp = self.model.tmp ;
            photoModel.textArray = self.model.wtxt;
        }
    }];
}

- (void)initContent{
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
            toTop = TextToTop;
            break;
        case Iphone5:
        case Iphone4:{
            toTop = 50;
            break;
        }
        default:
            break;
    }

    self.weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-75, toTop, 75, 70)];;
    [self addSubview:self.weatherImageView];
//    self.weatherImageView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.weatherImageView.layer.bounds].CGPath;
    [self setViewShowdow:self.weatherImageView];
//    [self.weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).with.offset(44);
//        make.right.equalTo(self.mas_left).with.offset(0);
//        make.width.mas_equalTo(@75);
//        make.height.mas_equalTo(@70);
//    }];
    
    
    
    /**
     *  温度
     */
    self.temperatureLaber = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth, self.weatherImageView.center.y - 50, 125, 100)];
    [self addSubview:self.temperatureLaber];
    self.temperatureLaber.textColor = [UIColor whiteColor];
    [self setViewShowdow:self.temperatureLaber];
    self.temperatureLaber.textAlignment = NSTextAlignmentRight;
//    [self.temperatureLaber mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).with.offset(-10);
//        make.width.greaterThanOrEqualTo(@0);
//        make.height.greaterThanOrEqualTo(@0);
//        make.top.equalTo(self.mas_top).with.offset(54);
//    }];
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
            self.temperatureLaber.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:80];

            break;
        case Iphone5:{
            self.temperatureLaber.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:64];

            break;
        }
        case Iphone4:{
            self.temperatureLaber.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:64];

            break;
        }
        default:
            break;
    }

    
    
    
    self.textLabelT = [UILabel new];
    [self addSubview:self.textLabelT];
    self.textLabelT.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.textLabelT.textColor = [UIColor whiteColor];
    [self.textLabelT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-90);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.mas_equalTo(@24);
        
    }];
    [self setViewShowdow:self.textLabelT];
    
    
    self.textLabelS = [UILabel new];
    [self addSubview:self.textLabelS];
    self.textLabelS.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.textLabelS.textColor = [UIColor whiteColor];
    [self.textLabelS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textLabelT.mas_top).with.offset(-6);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.mas_equalTo(@24);
        
    }];
    [self setViewShowdow:self.textLabelS];
    
    /**
     *  文字
     */
    self.textLabel = [UILabel new];
    [self addSubview:self.textLabel];
    self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    self.textLabel.textColor = [UIColor whiteColor];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textLabelS.mas_top).with.offset(-6);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.mas_equalTo(@24);

    }];
    
    [self setViewShowdow:self.textLabel];
    
    
    
    
    
    
    _authLabel = [UILabel new];
    [self addSubview:_authLabel];
    _authLabel.textColor = [UIColor whiteColor];
    _authLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [_authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);

    }];
    _authLabel.text = @"©NextDay 供图";
    
    
    _cameraButton = [UIButton new];
    UIImage * buttonImage = [UIImage imageNamed:@"photo_ico.png"];
    [self addSubview:_cameraButton];
    [_cameraButton setImage:buttonImage forState:UIControlStateNormal];
    [_cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.size.mas_equalTo(buttonImage.size);
    }];
    [_cameraButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    _shareButton = [UIButton new];
    [self addSubview:_shareButton];
    UIImage * shareImage = [UIImage imageNamed:@"header_share.png"];
    [_shareButton setImage:shareImage forState:UIControlStateNormal];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.size.mas_equalTo(shareImage.size);
    }];

    [_shareButton addTarget:self action:@selector(shareToOther) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)shareToOther{
    _cameraButton.hidden = YES;
    _shareButton.hidden = YES;
    [self.delegate share];
}
- (void)closeShare{
    _cameraButton.hidden = NO;
    _shareButton.hidden = NO;

}
- (void)takePhoto{
    [self.delegate takePhotoWithPlace];


}
- (void)setCurrenText:(NSArray *)textArray{
    self.textLabel.text = nil;
    self.textLabelS.text = nil;
    self.textLabelT.text = nil;

    switch (textArray.count) {
        case 1:{
            NSDictionary * dic = textArray[0];
            self.textLabelS.text = [[dic objectForKey:@"text"] description];
            [self setlabelWithString:[dic objectForKey:@"font"] AndBg:[dic objectForKey:@"bg"] WithLabel:self.textLabelS];
            break;
        }
        case 2:{
            NSDictionary * dic = textArray[0];
            self.textLabelS.text = [[dic objectForKey:@"text"] description];
            [self setlabelWithString:[dic objectForKey:@"font"] AndBg:[dic objectForKey:@"bg"] WithLabel:self.textLabelS];

            NSDictionary * dic1 = textArray[1];
            self.textLabelT.text = [[dic1 objectForKey:@"text"] description];
            [self setlabelWithString:[dic1 objectForKey:@"font"] AndBg:[dic1 objectForKey:@"bg"] WithLabel:self.textLabelT];


            break;
        }
        case 3:{
            NSDictionary * dic = textArray[0];
            self.textLabel.text = [[dic objectForKey:@"text"] description];
            [self setlabelWithString:[dic objectForKey:@"font"] AndBg:[dic objectForKey:@"bg"] WithLabel:self.textLabel];

            NSDictionary * dic1 = textArray[1];
            self.textLabelS.text = [[dic1 objectForKey:@"text"] description];
            [self setlabelWithString:[dic1 objectForKey:@"font"] AndBg:[dic1 objectForKey:@"bg"] WithLabel:self.textLabelS];

            NSDictionary * dic2 = textArray[2];
            self.textLabelT.text = [[dic2 objectForKey:@"text"] description];
            [self setlabelWithString:[dic2 objectForKey:@"font"] AndBg:[dic2 objectForKey:@"bg"] WithLabel:self.textLabelT];


            break;
        }
            
        default:
            break;
    }
}
/**
 *  设置label
 *
 *  @param size  字号
 *  @param bg    背景
 *  @param label 设置的Label
 */
- (void)setlabelWithString:(NSString *)size AndBg:(NSString *)bg WithLabel:(UILabel *)label{
    NSLog(@"%f",ScreenWidth);
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
            
                label.font =   [UIFont fontWithName:@"HelveticaNeue-Light" size:19];

            if ([bg isEqualToString:@"N"]) {
                label.backgroundColor = [UIColor clearColor];
            }else if([bg isEqualToString:@"Y"]){
                label.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
            }
            
            break;
        case Iphone5:
        case Iphone4:{
            label.font =   [UIFont fontWithName:@"HelveticaNeue-Light" size:19];

            if ([bg isEqualToString:@"N"]) {
                label.backgroundColor = [UIColor clearColor];
            }else if([bg isEqualToString:@"Y"]){
                label.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
            }
            
            break;
        }
        default:
            break;
    }
}

- (void)closeViewAm{
    
}
- (void)startAnimation{
//    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
//    animation.toValue = [NSNumber numberWithInt:85];
//    animation.removedOnCompletion = YES ;
//    animation.fillMode = kCAFillModeForwards;
//    animation.duration = 2;
//    animation.delegate = self;
//    CABasicAnimation *animation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation1.fromValue =[NSValue valueWithCATransform3D:CATransform3DIdentity];
// animation1.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
//        animation1.removedOnCompletion=NO;
//    animation1.fillMode=kCAFillModeForwards;
//    CAAnimationGroup * group = [CAAnimationGroup animation];
//    group.animations = [NSArray arrayWithObjects:animation,animation1, nil];
//    group.duration = 3;
//    group.delegate = self;
//    [self.weatherImageView.layer addAnimation:animation forKey:@"weatherIcon"];
//    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
//    animation2.toValue = [NSValue valueWithCGPoint:CGPointMake(0,300)];
//    animation2.removedOnCompletion = NO;
//    animation2.fillMode = kCAFillModeForwards;
//    CABasicAnimation *animation3=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation3.fromValue =[NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation3.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
//    animation3.removedOnCompletion=NO;
//    animation3.fillMode=kCAFillModeForwards;
//
//    CAAnimationGroup * group1 = [CAAnimationGroup animation];
//    group1.animations = [NSArray arrayWithObjects:animation2,animation3, nil];
//    group1.duration = 3;
//    group1.delegate = self;
//    group1.autoreverses = NO;
//
//    [self.temperatureLaber.layer addAnimation:group1 forKey:@"temp"];
//    [UIView animateWithDuration:3 animations:^{
//        self.alpha = 0;
//    }];
    [UIView animateWithDuration:1 animations:^{
        
        self.weatherImageView.frame = CGRectMake(10, toTop, 75, 70);
        self.temperatureLaber.frame = CGRectMake(ScreenWidth - 130,  self.weatherImageView.center.y - 50, 125, 100);
    }];
}
- (void)changeToBack{
    UIView * fatherView = self.superview.superview;
    fatherView.userInteractionEnabled = NO;

    self.textLabel.hidden = YES;
    self.textLabelS.hidden = YES;
    self.textLabelT.hidden = YES;
    [UIView animateWithDuration:1 animations:^{
        
        self.weatherImageView.frame = CGRectMake(-75, toTop, 75, 70);
        self.temperatureLaber.frame = CGRectMake(ScreenWidth,  self.weatherImageView.center.y - 50, 125, 100);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        fatherView.userInteractionEnabled = YES;

    }];

}
- (void)changeToFront{
    UIView * fatherView = self.superview.superview;
    fatherView.userInteractionEnabled = NO;
    self.hidden = NO;
    self.textLabel.hidden = NO;
    self.textLabelS.hidden = NO;
    self.textLabelT.hidden = NO;

    [UIView animateWithDuration:1 animations:^{
        
        self.weatherImageView.frame = CGRectMake(10, toTop, 75, 70);
        self.temperatureLaber.frame = CGRectMake(ScreenWidth - 130,  self.weatherImageView.center.y - 50, 125, 100);
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        fatherView.userInteractionEnabled = YES;

    }];

}
- (void)chageCity{
    self.hidden = NO;
    self.textLabel.hidden = NO;
    self.textLabelS.hidden = NO;
    self.textLabelT.hidden = NO;
    self.alpha = 1.0;


}
- (void)setViewShowdow:(UIView *)view{
    view.layer.shadowColor = [UIColor colorWithRed:170 / 255.0 green:170 / 255.0 blue:170 / 255.0 alpha:1.0].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 1;
    view.layer.shadowOpacity = 1.0;

}


//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
////    self.hidden = YES;
//    NSLog(@"%@,%@",anim,[self.weatherImageView.layer animationForKey:@"weatherIcon"]);
//    if (anim == [self.weatherImageView.layer animationForKey:@"weatherIcon"]) {
//        CGRect weatherBounds = self.weatherImageView.layer.bounds;
//        weatherBounds.origin.x = 85;
//        self.weatherImageView.layer.bounds = weatherBounds;
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
