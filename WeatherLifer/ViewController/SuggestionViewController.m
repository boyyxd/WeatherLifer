//
//  SuggestionViewController.m
//  WeatherLifer
//
//  Created by Tina on 15/3/31.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "SuggestionViewController.h"
#import <sys/utsname.h>
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define ImageWith 226
#define ImageHeigth 191
@interface SuggestionViewController ()

@end

@implementation SuggestionViewController

- (void)viewDidLoad {

    
     [super viewDidLoad];
        switch ((NSInteger)ScreenHeigth) {
        case Iphone6p:{
            self.view.frame = CGRectMake(0, 0, ImageWith * 1.29f, ImageHeigth * 1.29f);

            break;
        }
        case Iphone6:{
            self.view.frame = CGRectMake(0, 0, ImageWith * 1.17f, ImageHeigth * 1.17f);

            break;
        }
        case Iphone5:{
            self.view.frame = CGRectMake(0, 0, ImageWith , ImageHeigth );

        }
        case Iphone4:{
            self.view.frame = CGRectMake(0, 0, ImageWith , ImageHeigth);

        }
            
        default:
            break;
    }
    NSLog(@"%f",ScreenHeigth);
    /**
     不弹出键盘
     */
    _textField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    self.imageView.layer.shadowColor = [UIColor clearColor].CGColor;
    self.view.layer.shadowColor = [UIColor clearColor].CGColor;
   
}

/**
 *  拷贝天气家微信公众号
 *
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)closeButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
//#pragma mark- UITextFiledDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    [_textField canResignFirstResponder];
//    
//    return YES;
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
