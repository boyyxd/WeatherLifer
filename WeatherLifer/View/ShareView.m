//
//  ShareView.m
//  WeatherLifer
//
//  Created by ink on 15/7/1.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "ShareView.h"
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480

@interface ShareView()

@property (nonatomic, strong) UIToolbar *toolbar;
@end



@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self addConternt];
    }
    return self;
}
- (void)setup {
    // If we don't clip to bounds the toolbar draws a thin shadow on top
    [self setClipsToBounds:YES];
    
    if (![self toolbar]) {
        [self setToolbar:[[UIToolbar alloc] initWithFrame:[self bounds]]];
        [self.layer insertSublayer:[self.toolbar layer] atIndex:0];
    }
    _toolbar.alpha = 0.7;
}

- (void)addConternt{
    UIButton * weChatFriendButton = [UIButton new];
    [weChatFriendButton setImage:[UIImage imageNamed:@"share1.png"] forState:UIControlStateNormal];
    [self addSubview:weChatFriendButton];
    [weChatFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(self.mas_top).with.offset(26);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(self.mas_top).with.offset(20);
                
                break;
            }
            default:
                break;
        }
        make.centerX.equalTo(self.mas_left).with.offset(ScreenWidth / 6);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
    weChatFriendButton.tag = 1;
    
    UILabel * weChatLabel = [UILabel new];
    weChatLabel.text = @"微信好友";
    [self addSubview:weChatLabel];
    weChatLabel.font = [UIFont systemFontOfSize:13];
    [weChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(weChatFriendButton.mas_bottom).with.offset(6);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(weChatFriendButton.mas_bottom).with.offset(6);
                
                break;
            }
            default:
                break;
        }

        make.centerX.equalTo(self.mas_left).with.offset(ScreenWidth / 6);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
    }];

    UIButton * weChatTimeLine = [UIButton new];
    [weChatTimeLine setImage:[UIImage imageNamed:@"share2.png"] forState:UIControlStateNormal];
    [self addSubview:weChatTimeLine];
    [weChatTimeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(self.mas_top).with.offset(26);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(self.mas_top).with.offset(20);
                
                break;
            }
            default:
                break;
        }
        
        make.centerX.equalTo(weChatFriendButton).with.offset(ScreenWidth / 3);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
    weChatTimeLine.tag = 2;

    UILabel * wechatTimeLineLabel = [UILabel new];
    wechatTimeLineLabel.text = @"朋友圈";
    [self addSubview:wechatTimeLineLabel];
    wechatTimeLineLabel.font = [UIFont systemFontOfSize:13];
    [wechatTimeLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(weChatTimeLine.mas_bottom).with.offset(6);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(weChatTimeLine.mas_bottom).with.offset(6);
                
                break;
            }
            default:
                break;
        }
        
        make.centerX.equalTo(weChatLabel).with.offset(ScreenWidth / 3);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
    }];

    
    UIButton * weiboButton = [UIButton new];
    [weiboButton setImage:[UIImage imageNamed:@"share3.png"] forState:UIControlStateNormal];
    [self addSubview:weiboButton];
    [weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(self.mas_top).with.offset(26);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(self.mas_top).with.offset(20);
                
                break;
            }
            default:
                break;
        }
        
        make.centerX.equalTo(weChatTimeLine).with.offset(ScreenWidth / 3);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
    weiboButton.tag = 3;
    
    
    
    UILabel * weiboLabel = [UILabel new];
    weiboLabel.text = @"微博";
    [self addSubview:weiboLabel];
    weiboLabel.font = [UIFont systemFontOfSize:13];
    [weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(weiboButton.mas_bottom).with.offset(6);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(weiboButton.mas_bottom).with.offset(6);
                
                break;
            }
            default:
                break;
        }
        
        make.centerX.equalTo(wechatTimeLineLabel).with.offset(ScreenWidth / 3);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
    }];

    
    
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = [UIColor blackColor];
    [self addSubview:lineView];
    lineView.alpha = 0.2;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(150);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@2);
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(self.mas_top).with.offset(150);

                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(self.mas_top).with.offset(116);

                break;
            }
            default:
                break;
        }

    }];
    
    UIButton * downLoadButton = [UIButton new];
    [downLoadButton setImage:[UIImage imageNamed:@"share4.png"] forState:UIControlStateNormal];
    [self addSubview:downLoadButton];
    [downLoadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(lineView.mas_bottom).with.offset(26);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(lineView.mas_bottom).with.offset(20);
                
                break;
            }
            default:
                break;
        }

        make.centerX.equalTo(self.mas_left).with.offset(ScreenWidth / 6);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
    downLoadButton.tag = 4;
    
    UILabel * downLabel = [UILabel new];
    downLabel.text = @"下载";
    [self addSubview:downLabel];
    downLabel.font = [UIFont systemFontOfSize:13];
    [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(downLoadButton.mas_bottom).with.offset(6);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(downLoadButton.mas_bottom).with.offset(6);
                
                break;
            }
            default:
                break;
        }
        
        make.centerX.equalTo(self.mas_left).with.offset(ScreenWidth / 6);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
    }];


    UIButton * moreButton = [UIButton new];
    [moreButton setImage:[UIImage imageNamed:@"share5.png"] forState:UIControlStateNormal];
    [self addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(lineView.mas_bottom).with.offset(26);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(lineView.mas_bottom).with.offset(20);
                
                break;
            }
            default:
                break;
        }
        make.centerX.equalTo(downLoadButton).with.offset(ScreenWidth / 3);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
    moreButton.tag = 5;
    
    UILabel * moreLabel = [UILabel new];
    moreLabel.text = @"更多";
    [self addSubview:moreLabel];
    moreLabel.font = [UIFont systemFontOfSize:13];
    [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:
                make.top.equalTo(moreButton.mas_bottom).with.offset(6);
                
                break;
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(moreButton.mas_bottom).with.offset(6);
                
                break;
            }
            default:
                break;
        }
        
        make.centerX.equalTo(downLabel).with.offset(ScreenWidth / 3);
        make.size.mas_greaterThanOrEqualTo(CGSizeMake(0, 0));
    }];

    
    
    UIButton * cancelButton = [UIButton new];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:cancelButton];
    [cancelButton setBackgroundColor:[UIColor whiteColor]];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).with.offset(-54);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    cancelButton.tag = 6;
    
    [weChatFriendButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [weChatTimeLine addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [weiboButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [downLoadButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [moreButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];


}
- (void)buttonPress:(UIButton *)button{
    [self.delegate selectShareStyle:button.tag];
}

@end
