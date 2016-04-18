//
//  ShareMenuView.h
//  SinaMenuViewExample
//
//  Created by ink on 15/5/13.
//  Copyright (c) 2015年 iOS软件开发工程师 曾宪华 热衷于简洁的UI QQ:543413507 http://www.pailixiu.com/blog   http://www.pailixiu.com/Jack/personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

typedef void(^DidSelectedItemBlock)(MenuItem *selectedItem);

@interface ShareMenuView : UIView
@property (nonatomic, strong, readonly) NSArray *items;

@property (nonatomic, copy) DidSelectedItemBlock didSelectedItemCompletion;

- (instancetype)initWithFrame:(CGRect)frame
                        items:(NSArray *)items;

- (void)showMenuAtView:(UIView *)containerView;
- (void)dismissMenu;

@end
