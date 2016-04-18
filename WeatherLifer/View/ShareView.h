//
//  ShareView.h
//  WeatherLifer
//
//  Created by ink on 15/7/1.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@protocol ShareButtonDelegate
- (void)selectShareStyle:(NSInteger)tag;
@end

@interface ShareView : UIView
@property (nonatomic, assign) id<ShareButtonDelegate>delegate;

@end
