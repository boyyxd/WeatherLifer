//
//  CameraBottomView.m
//  WeatherLifer
//
//  Created by ink on 15/3/13.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "CameraBottomView.h"
#import "Masonry.h"
@implementation CameraBottomView
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
    _changeTextColorButton = [UIButton new];
    [self addSubview:_changeTextColorButton];
    [_changeTextColorButton setImage:[UIImage imageNamed:@"photo_switch_ico.png"] forState:UIControlStateNormal];
    [_changeTextColorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).with.offset(51);
        make.centerY.equalTo(self.mas_top).with.offset(45);
               make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_changeTextColorButton addTarget:self action:@selector(changeTextColor) forControlEvents:UIControlEventTouchUpInside];
    _photoAlbumsButton = [UIButton new];
    [self addSubview:_photoAlbumsButton];
    [_photoAlbumsButton setImage:[UIImage imageNamed:@"photo_album_ico.png"] forState:UIControlStateNormal];
    [_photoAlbumsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top).with.offset(45);
        make.centerX.equalTo(self.mas_right).with.offset(-51);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_photoAlbumsButton addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
}
- (void)changeTextColor{
    [self.delegate changeTextColor];
}
- (void)selectPhoto{
    [self.delegate selectAlbums];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
