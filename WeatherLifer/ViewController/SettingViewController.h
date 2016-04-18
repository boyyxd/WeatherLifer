//
//  SettingViewController.h
//  WeatherLifer
//
//  Created by Tina on 15/3/24.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestionViewController.h"
#import "GiantShoulderViewController.h"
#import <MessageUI/MessageUI.h>

@interface SettingViewController : UIViewController<MJSecondPopupDelegate,MFMailComposeViewControllerDelegate>
{
    UITableView * _tbView;
    NSArray * array1;
    NSArray * array2;
    NSArray * array3;
    NSArray * array4;
    UITableViewCell * cell;
}

- (IBAction)backAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *versionInfoLabel;

@end
