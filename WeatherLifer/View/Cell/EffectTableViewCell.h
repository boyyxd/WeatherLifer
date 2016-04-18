//
//  EffectTableViewCell.h
//  WeatherLifer
//
//  Created by ink on 15/6/15.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface EffectTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * effectImageView;
@property (nonatomic, strong) UILabel * effectLabel;
@property (nonatomic, strong) NSString * selectImageName;
@property (nonatomic, strong) NSString * unSelectImageName;
@end
