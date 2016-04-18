//
//  SuggestionViewController.h
//  WeatherLifer
//
//  Created by Tina on 15/3/31.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;

@interface SuggestionViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)closeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
@protocol MJSecondPopupDelegate <NSObject>

@optional

- (void)cancelButtonClicked:(SuggestionViewController * )sugesstionViewController;

@end