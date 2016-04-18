//
//  LoadingView.h
//  WeatherLifer
//
//  Created by ink on 15/7/3.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MONActivityIndicatorView.h"

@interface LoadingView : UIView{
    MONActivityIndicatorView * indicatorView;

}
- (void)startAm;
- (void)stopAm;
@end
