//
//  CameraTopView.m
//  WeatherLifer
//
//  Created by ink on 15/3/13.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CameraTopView.h"
#import "Masonry.h"
@implementation CameraTopView{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self initControls];
    }
    return self;
}
/**
 *  初始化控件
 */
- (void)initControls{
    UIButton * cancelButton = [UIButton new];
    [cancelButton setImage:[UIImage imageNamed:@"all_arrow_left_w.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);

        make.left.equalTo(self.mas_left).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    _cameraSwitchButton = [UIButton new];
    [_cameraSwitchButton setBackgroundImage:[UIImage imageNamed:@"photo_reversal_ico.png"] forState:UIControlStateNormal];
    [self addSubview:_cameraSwitchButton];
    [_cameraSwitchButton addTarget:self action:@selector(frontOrBack) forControlEvents:UIControlEventTouchUpInside];
    [_cameraSwitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(26, 22));
    }];
    
    _flashButton = [UIButton new];
      [_flashButton setImage:[UIImage imageNamed:@"photo_exposure_ico.png"] forState:UIControlStateNormal];
    [_flashButton addTarget:self action:@selector(operationFlash) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_flashButton];
    [_flashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.equalTo(self.mas_right).with.offset(10);
    }];
}
/**
 *  取消
 */
- (void)cancel{
    [_delegate cancelButtonPress];
}
- (void)frontOrBack{
    [_delegate frontOrBackButtonPress];
}
- (void)operationFlash{
    if (_flashOn) {
        _flashOn = NO;
        [_flashButton setImage:[UIImage imageNamed:@"photo_exposure_ico.png"] forState:UIControlStateNormal];
        
    }else{
        _flashOn = YES;
        [_flashButton setImage:[UIImage imageNamed:@"photo_exposure_ico_pressed.png"] forState:UIControlStateNormal];
        
    }
    [_delegate opeartionFlashPower:_flashOn];

}
- (void)setFlashOn:(BOOL)flashOn{
    self->_flashOn = flashOn;
    if (flashOn) {
        [_flashButton setImage:[UIImage imageNamed:@"photo_exposure_ico_pressed.png"] forState:UIControlStateNormal];

    }else{
        [_flashButton setImage:[UIImage imageNamed:@"photo_exposure_ico.png"] forState:UIControlStateNormal];

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
