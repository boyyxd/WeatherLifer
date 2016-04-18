//
//  PlaceTableViewCell.h
//  WeatherLifer
//
//  Created by ink on 15/6/30.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface PlaceTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * placeNameLabel;

@property (nonatomic, strong) UIImageView * locationImageView;

@property (nonatomic, strong) UILabel * addressLabel;

@property (nonatomic, strong) UILabel * tempLabel;

@property (nonatomic, strong) UIImageView * weatherIconImageView;

@end
