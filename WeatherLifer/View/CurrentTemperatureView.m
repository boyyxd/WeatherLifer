//
//  CurrentTemperatureView.m
//  WeatherLifer
//
//  Created by ink on 15/5/30.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CurrentTemperatureView.h"
#import "FXBlurView.h"
#import "Masonry.h"
#import "TemperatureStraightLine.h"
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define xPoint ScreenWidth * 2 / 24
#define MinuteWidth (ScreenWidth - 40) / 60
#define RainHeigth 34
#define RainHeigthS 24

#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480

@interface CurrentTemperatureView(){
    TemperatureStraightLine * line;

}

@end

@implementation CurrentTemperatureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
            _temperatureLabel.text = [NSString stringWithFormat:@"%i°C",(int)round(self.model.tmp)];
            _weatherLabel.text = self.model.wcn;
            _windClassLabel.text = self.model.wind;
            _humidityClassLabel.text = [NSString stringWithFormat:@"%ld%%",(long)self.model.hum];
            _airLabel.text = [NSString stringWithFormat:@"%ld",(long)self.model.aqi];
            _airDes.text = self.model.tip_aqi;
            _describeLabel.text = self.model.text_aqi;
            [line.pointArray removeAllObjects];
            [line.pointArray addObjectsFromArray:self.model.aqiArray];
            [line.valueArray removeAllObjects];
            [line.valueArray addObjectsFromArray:self.model.aqiValueArray];
            [line.bottomPointArray removeAllObjects];
            [line.bottomPointArray addObjectsFromArray:self.model.bottomArray];
            [line.bottomValueArray removeAllObjects];
            [line.bottomValueArray addObjectsFromArray:self.model.bottomValueArray];
            line.Aqi = YES;
            line.startTime = self.model.startTime;
            [line setNeedsDisplay];
            [_rainView.pointArray removeAllObjects];
            [_rainView.pointArray addObjectsFromArray:[self getRainPointAndValueWithArray:self.model.rainArray]];
            [_rainView setNeedsDisplay];
//            if (self.model.rainArray.count == 0) {
                [tempButton setImage:[UIImage imageNamed:@"ico_temp.png"] forState:UIControlStateNormal];
                [rainButton setImage:[UIImage imageNamed:@"ico_rain01.png"] forState:UIControlStateNormal];
                [airButton setImage:[UIImage imageNamed:@"ico_aqi02_p.png"] forState:UIControlStateNormal];
                _describeLabel.text = self.model.text_aqi;
                funcationLabel.text = @"24小时空气质量";
                line.hidden = NO;
                _rainView.hidden = YES;
                smallRainLabel.hidden = YES;
                middleRainLabel.hidden = YES;
                largeRainLabel.hidden = YES;
                stromRainLabel.hidden = YES;


//            }else{
//                [tempButton setImage:[UIImage imageNamed:@"ico_temp.png"] forState:UIControlStateNormal];
//                [rainButton setImage:[UIImage imageNamed:@"ico_rain01_p.png"] forState:UIControlStateNormal];
//                [airButton setImage:[UIImage imageNamed:@"ico_aqi02.png"] forState:UIControlStateNormal];
//                line.hidden = YES;
//                _rainView.hidden = NO;
//                _describeLabel.text = self.model.rain_text;
//                funcationLabel.text = @"2小时降雨预报";
//                smallRainLabel.hidden = NO;
//                middleRainLabel.hidden = NO;
//                largeRainLabel.hidden = NO;
//                stromRainLabel.hidden = NO;
//
//
//            }
            [scrollView setContentOffset:CGPointMake(0, 0)];
            
        }
    }];
}
/**
 *  获取下雨坐标
 *
 *  @param array <#array description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)getRainPointAndValueWithArray:(NSArray *)array{
    NSMutableArray * pointArray = [NSMutableArray array];
    CGFloat toBottom;
    CGFloat rainViewItem;
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
        case Iphone5:
            toBottom = 32;
            rainViewItem = RainHeigth;
            break;
        case Iphone4:{
            toBottom = 26;
            rainViewItem = RainHeigthS;
            break;
        }
        default:
            break;
    }

    for (NSDictionary * dic in array) {
        NSInteger minute = [[dic objectForKey:@"m"] integerValue];
        CGFloat pointX = minute * (ScreenWidth - 20) / 60;
        double value = [[dic objectForKey:@"rain"] doubleValue];
        double pointY;
        if (value <= 2.5) {
            pointY =CGRectGetHeight(_rainView.frame) - toBottom -  (value / 2.5 * rainViewItem)  ;
        }else if (value > 2.5 && value <= 8){
            pointY =CGRectGetHeight(_rainView.frame) - toBottom - rainViewItem  - ((value - 2.5)/ 5.5 * rainViewItem);
        }else if(value >8 && value <= 16){
            pointY =CGRectGetHeight(_rainView.frame) - toBottom - rainViewItem * 2 - ((value - 8) / 8 * rainViewItem);
        }else{
            pointY =CGRectGetHeight(_rainView.frame) - toBottom - rainViewItem * 3 - (value - 16) / 84 * rainViewItem;
        }
        NSValue * pointValue = [NSValue valueWithCGPoint:CGPointMake(pointX, pointY)];
        [pointArray addObject:pointValue];
    }
    return pointArray;
    
}
- (void)initContent{
    CGFloat lineHeight;
    CGFloat bottomHeight;
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
        case Iphone5:
            lineHeight = 148;
            bottomHeight = -272;
            
            break;
        case Iphone4:{
            lineHeight = 100;
            bottomHeight = -200;
            break;
        }
        default:
            break;
    }

    UIView * backView = [UIView new];
    [self addSubview:backView];
    backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_bottom).with.offset(bottomHeight);
    }];

    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, ScreenHeigth - 188, ScreenWidth - 20, 188)];
    [self addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.frame) * 2, 0)];

    line = [[TemperatureStraightLine alloc] initWithFrame:CGRectMake(0, 188 - lineHeight,(ScreenWidth - 20) * 2, lineHeight)];
//    [line.bottomPointArray addObjectsFromArray:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(220, 0)],nil]];
//    [line initTemperatureLable];
    [scrollView addSubview:line];
//    [line startAnimation]
    
    _rainView = [[RainView alloc] initWithFrame:CGRectMake(0, 20,(ScreenWidth - 20) * 2 , 168)];
    [scrollView addSubview:_rainView];
    _rainView.hidden = YES;
    
    
    rainButton = [UIButton new];
    UIImage * rainImage = [UIImage imageNamed:@"ico_rain01.png"];
    [rainButton setImage:rainImage forState:UIControlStateNormal];
    [self addSubview:rainButton];
    [rainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.top.equalTo(backView.mas_top).with.offset(12);
        make.size.mas_equalTo(rainImage.size);
        
    }];
    rainButton.tag = 2;
    [rainButton addTarget:self action:@selector(changeLine:) forControlEvents:UIControlEventTouchUpInside];
    tempButton = [UIButton new];
    UIImage * tempImage = [UIImage imageNamed:@"ico_temp.png"];
    [self addSubview:tempButton];
    [tempButton setImage:tempImage forState:UIControlStateNormal];
    [tempButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rainButton.mas_left).with.offset(-10);
        make.top.equalTo(backView.mas_top).with.offset(12);
        make.size.mas_equalTo(tempImage.size);

        
    }];
    tempButton.tag = 1;
    [tempButton addTarget:self action:@selector(changeLine:) forControlEvents:UIControlEventTouchUpInside];
    
    airButton  = [UIButton new];
    UIImage * airImage = [UIImage imageNamed:@"ico_aqi02_p.png"];
    [airButton setImage:airImage forState:UIControlStateNormal];
    [self addSubview:airButton];
    [airButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tempButton.mas_left).with.offset(-10);
        make.top.equalTo(backView.mas_top).with.offset(12);
        make.size.mas_equalTo(tempImage.size);

    }];
    airButton.tag = 0;
    [airButton addTarget:self action:@selector(changeLine:) forControlEvents:UIControlEventTouchUpInside];
    _describeLabel = [UILabel new];
    [self addSubview:_describeLabel];
    _describeLabel.font = [UIFont systemFontOfSize:16];
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:
                make.top.equalTo(backView.mas_top).with.offset(80);
                
                break;
            case Iphone4:{
                make.top.equalTo(backView.mas_top).with.offset(58);
                
                break;
            }
            default:
                break;
        }

        
    }];
    _describeLabel.textColor = [UIColor whiteColor];
    
    
    
    UIImageView * windImageView = [UIImageView new];
    [self addSubview:windImageView];
    UIImage * windImage = [UIImage imageNamed:@"parameter_s1.png"];
    windImageView.image = windImage;
    [windImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_top).with.offset(-10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_equalTo(windImage.size);
    }];
    
    _windClassLabel = [UILabel new];
    [self addSubview:_windClassLabel];
    _windClassLabel.font = [UIFont systemFontOfSize:16];
    _windClassLabel.textColor = [UIColor whiteColor];
    [_windClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(windImageView.mas_right).with.offset(10);
        make.centerY.equalTo(windImageView.mas_centerY);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];


    UIImageView * humImageView = [UIImageView new];
    [self addSubview:humImageView];
    UIImage * humImage = [UIImage imageNamed:@"parameter_s2.png"];
    humImageView.image = humImage;
    [humImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_windClassLabel.mas_right).with.offset(10);
        make.centerY.equalTo(_windClassLabel.mas_centerY);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];
    _humidityClassLabel = [UILabel new];
    [self addSubview:_humidityClassLabel];
    _humidityClassLabel.font = [UIFont systemFontOfSize:16];
    _humidityClassLabel.textColor = [UIColor whiteColor];

    [_humidityClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(humImageView.mas_right).with.offset(10);
        make.centerY.equalTo(humImageView.mas_centerY);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];


    UIImageView * airImageView = [UIImageView new];
    [self addSubview:airImageView];
    UIImage * topAirImage = [UIImage imageNamed:@"parameter_s3.png"];
    airImageView.image = topAirImage;
    [airImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_humidityClassLabel.mas_right).with.offset(10);
        make.centerY.equalTo(_humidityClassLabel.mas_centerY);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];

    _airLabel = [UILabel new];
    [self addSubview:_airLabel];
    _airLabel.font = [UIFont systemFontOfSize:16];
    _airLabel.textColor = [UIColor whiteColor];
    
    [_airLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(airImageView.mas_right).with.offset(10);
        make.centerY.equalTo(airImageView.mas_centerY);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];
    
    _airDes = [UILabel new];
    [self addSubview:_airDes];
    _airDes.font = [UIFont systemFontOfSize:16];
    _airDes.textColor = [UIColor whiteColor];
    
    [_airDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_airLabel.mas_right).with.offset(10);
        make.centerY.equalTo(_airLabel.mas_centerY);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];

    _temperatureLabel = [UILabel new];
    [self addSubview:_temperatureLabel];
    _temperatureLabel.textColor = [UIColor whiteColor];
    [_temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:
                make.bottom.equalTo(windImageView.mas_top).with.offset(-10);

                break;
            case Iphone4:{
                make.bottom.equalTo(windImageView.mas_top).with.offset(0);

                break;
            }
            default:
                break;
        }


    }];
    _temperatureLabel.textAlignment = NSTextAlignmentLeft;
    _weatherLabel = [UILabel new];
    [self addSubview:_weatherLabel];
    _weatherLabel.textColor = [UIColor whiteColor];
    [_weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.bottom.equalTo(_temperatureLabel.mas_top).with.offset(0);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
        
    }];
    
    funcationLabel = [UILabel new];
    [self addSubview:funcationLabel];
    funcationLabel.textColor = [UIColor whiteColor];
    funcationLabel.textAlignment = NSTextAlignmentLeft;
    [funcationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(airButton.mas_centerY);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
    }];
    funcationLabel.text = @"24小时空气质量";

    
    UIView * lineView = [UIView new];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@0.5);
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:
                make.top.equalTo(funcationLabel.mas_bottom).with.offset(20);

                break;
            case Iphone4:{
                make.top.equalTo(funcationLabel.mas_bottom).with.offset(10);
                
                break;
            }
            default:
                break;
        }

        
    }];
    lineView.alpha = 0.3;
    lineView.backgroundColor = [UIColor whiteColor];

    
    UIButton * huartButton = [UIButton new];
    [huartButton setImage:[UIImage imageNamed:@"heart.png"] forState:UIControlStateNormal];
    [self addSubview:huartButton];
    [huartButton addTarget:self action:@selector(changeView) forControlEvents:UIControlEventTouchUpInside];
    [huartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:{
                make.bottom.equalTo(backView.mas_top).with.offset(-48);
                make.size.mas_equalTo(CGSizeMake(42, 42));

                break;
            }
            case Iphone6p:
                make.bottom.equalTo(backView.mas_top).with.offset(-60);
                make.size.mas_equalTo(CGSizeMake(52, 52));

                break;
            case Iphone5:{
                
                make.bottom.equalTo(backView.mas_top).with.offset(-48);
                make.size.mas_equalTo(CGSizeMake(42, 42));
                break;
            }
            case Iphone4:{
                make.bottom.equalTo(backView.mas_top).with.offset(-40);
                make.size.mas_equalTo(CGSizeMake(42, 42));


                    break;
            }
            default:
                break;
        }

    }];
    
    smallRainLabel = [UILabel new];
    smallRainLabel.textColor = [UIColor whiteColor];
    [self addSubview:smallRainLabel];
    smallRainLabel.text = @"小雨";
    [smallRainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:{
                make.top.equalTo(self.mas_bottom).with.offset(-57);

                
                break;
            }
            case Iphone4:{
                make.top.equalTo(self.mas_bottom).with.offset(-46);

                
                break;
            }
            default:
                break;
        }

    }];

    
    middleRainLabel = [UILabel new];
    middleRainLabel.textColor = [UIColor whiteColor];
    [self addSubview:middleRainLabel];
    middleRainLabel.text = @"中雨";
    [middleRainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:{
                make.bottom.equalTo(smallRainLabel.mas_top).with.offset(-15);

                break;
            }
            case Iphone4:{
                make.bottom.equalTo(smallRainLabel.mas_top).with.offset(-9);

                
                break;
            }
            default:
                break;
        }

        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
    }];
    
    largeRainLabel = [UILabel new];
    largeRainLabel.textColor = [UIColor whiteColor];
    [self addSubview:largeRainLabel];
    largeRainLabel.text = @"大雨";
    [largeRainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:{
                make.bottom.equalTo(middleRainLabel.mas_top).with.offset(-15);

                break;
            }
            case Iphone4:{
                make.bottom.equalTo(middleRainLabel.mas_top).with.offset(-8);

                
                break;
            }
            default:
                break;
        }

    }];

    stromRainLabel = [UILabel new];
    stromRainLabel.textColor = [UIColor whiteColor];
    [self addSubview:stromRainLabel];
    stromRainLabel.text = @"暴雨";
    [stromRainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
            case Iphone5:{
                make.bottom.equalTo(largeRainLabel.mas_top).with.offset(-15);

                break;
            }
            case Iphone4:{
                make.bottom.equalTo(largeRainLabel.mas_top).with.offset(-8);

                
                break;
            }
            default:
                break;
        }

    }];
    
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:{
            _temperatureLabel.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:80];
            _weatherLabel.font = [UIFont systemFontOfSize:30];

            break;
        }
        case Iphone5:
            _temperatureLabel.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:64];
            _weatherLabel.font = [UIFont systemFontOfSize:30];
            funcationLabel.font = [UIFont systemFontOfSize:18];
            
            
            break;
        case Iphone4:{
            _temperatureLabel.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:64];
            _weatherLabel.font = [UIFont systemFontOfSize:20];
            funcationLabel.font = [UIFont systemFontOfSize:16];
            smallRainLabel.font = [UIFont systemFontOfSize:13];
            middleRainLabel.font = [UIFont systemFontOfSize:13];
            largeRainLabel.font = [UIFont systemFontOfSize:13];
            stromRainLabel.font = [UIFont systemFontOfSize:13];

            
            break;
        }
        default:
            break;
    }


    smallRainLabel.hidden = YES;
    middleRainLabel.hidden = YES;
    largeRainLabel.hidden = YES;
    stromRainLabel.hidden = YES;
    

    
}
- (void)changeView{
    [self.delegate heartPress];
}
- (void)changeLine:(UIButton *)button{
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    switch (button.tag) {
        case 0:{
            line.hidden = NO;
            _rainView.hidden = YES;
            [line.pointArray removeAllObjects];
            [line.pointArray addObjectsFromArray:self.model.aqiArray];
            [line.valueArray removeAllObjects];
            [line.valueArray addObjectsFromArray:self.model.aqiValueArray];
            line.Aqi = YES;
            [line setNeedsDisplay];
            [tempButton setImage:[UIImage imageNamed:@"ico_temp.png"] forState:UIControlStateNormal];
            [rainButton setImage:[UIImage imageNamed:@"ico_rain01.png"] forState:UIControlStateNormal];
            [airButton setImage:[UIImage imageNamed:@"ico_aqi02_p.png"] forState:UIControlStateNormal];
            _describeLabel.text = self.model.text_aqi;
            funcationLabel.text = @"24小时空气质量";
            smallRainLabel.hidden = YES;
            middleRainLabel.hidden = YES;
            largeRainLabel.hidden = YES;
            stromRainLabel.hidden = YES;

            break;
        }
        case 1:{
            line.hidden = NO;
            _rainView.hidden = YES;
            [line.pointArray removeAllObjects];
            [line.pointArray addObjectsFromArray:self.model.tempArray];
            [line.valueArray removeAllObjects];
            [line.valueArray addObjectsFromArray:self.model.tempValueArray];
            line.Aqi  = NO;
            [line setNeedsDisplay];
            [tempButton setImage:[UIImage imageNamed:@"ico_temp_p.png"] forState:UIControlStateNormal];
            [rainButton setImage:[UIImage imageNamed:@"ico_rain01.png"] forState:UIControlStateNormal];
            [airButton setImage:[UIImage imageNamed:@"ico_aqi02.png"] forState:UIControlStateNormal];
            _describeLabel.text = self.model.text_st;
            funcationLabel.text = @"24小时体感温度";
            smallRainLabel.hidden = YES;
            middleRainLabel.hidden = YES;
            largeRainLabel.hidden = YES;
            stromRainLabel.hidden = YES;

            break;

        }
        case 2:{
            [tempButton setImage:[UIImage imageNamed:@"ico_temp.png"] forState:UIControlStateNormal];
            [rainButton setImage:[UIImage imageNamed:@"ico_rain01_p.png"] forState:UIControlStateNormal];
            [airButton setImage:[UIImage imageNamed:@"ico_aqi02.png"] forState:UIControlStateNormal];
            line.hidden = YES;
            _rainView.hidden = NO;
            _describeLabel.text = self.model.rain_text;
            funcationLabel.text = @"2小时降雨预报";
            smallRainLabel.hidden = NO;
            middleRainLabel.hidden = NO;
            largeRainLabel.hidden = NO;
            stromRainLabel.hidden = NO;
            break;
        }
            
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
