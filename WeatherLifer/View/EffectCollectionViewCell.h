//
//  EffectCollectionViewCell.h
//  WeatherLifer
//
//  Created by ink on 15/5/11.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectCollectionViewCell : UICollectionViewCell
/**
 *  示例图片
 */
@property (nonatomic, strong) UIImageView * exampleImageView;
/**
 *  效果名称
 */
@property (nonatomic, strong) UILabel * effectLabel;
@end
