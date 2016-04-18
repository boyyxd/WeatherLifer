//
//  GiantShoulderViewController.h
//  WeatherLifer
//
//  Created by Tina on 15/4/8.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;

@interface GiantShoulderViewController : UIViewController

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

- (IBAction)closeButton:(id)sender;

@end

@protocol MJSecondPopupDelegate <NSObject>

@optional

- (void)cancelButtonClicked:(GiantShoulderViewController * )giantShoulderViewController;

@end