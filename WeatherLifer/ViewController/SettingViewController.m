//
//  SettingViewController.m
//  WeatherLifer
//
//  Created by Tina on 15/3/24.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "SettingViewController.h"
#import "Masonry.h"
#import "SuggestionViewController.h"
#import "UIViewController+MJPopupViewController.h"
//#import "WeatherUrl.h"
#import "DataComeFromViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
    CGFloat heigth ;
    self.navigationController.navigationBarHidden = YES;
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
            heigth = 160;
            break;
        case Iphone5:
        case Iphone4:{
            heigth = 140;
                     break;
            
        }
        default:
            break;
    }
    
    _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, heigth, self.view.frame.size.width, self.view.frame.size.height-76) style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [_tbView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tbView];
    
    
    //logo和版本信息
    [_imageView setBackgroundColor:[UIColor clearColor]];
    [_imageView setImage:[UIImage imageNamed:@"setting_logo"]];
    [_versionInfoLabel setBackgroundColor:[UIColor clearColor]];
    _versionInfoLabel.text = @"天气家 weatherist 2.0";
    
    array1 = @[@"清理缓存"];
    array2 = @[@"意见反馈",@"巨人的肩膀",@"数据来源",@"关注天气家"];
    array3 = @[@"setting_ico1"];
    array4 = @[@"setting_ico2",@"setting_ico3",@"setting_ico5",@"setting_ico8.png"];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 54, ScreenWidth, 1)];
    [self.view addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithRed:195 / 255.0 green:195 / 255.0 blue:195 / 255.0 alpha:1.0];

    
    
}
//弹出Suggestion视图
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown) || (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

- (void)cancelButtonClicked:(SuggestionViewController *)suggstionView
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        [self clearFile];
        
        
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            

            /**
             弹出建议窗口
             */

            [self sendEmail];
            
       
            
        }else if (indexPath.row ==1){
//
//            /**
//             *  跳转到AppStore
//             *
//             */
//            NSString * str =[NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@",AppID];
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
//            /**
//             *  跳转到评价界面
//             */
//            NSString * strt = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=%@",AppID];
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:strt]];
            
            GiantShoulderViewController* giantView = [[GiantShoulderViewController alloc]init];
            giantView.delegate = self;
            
            [self presentPopupViewController:giantView animationType:MJPopupViewAnimationFade];

        }else if (indexPath.row ==2){
            /**
//             巨人的肩膀
//             */
//            
//             GiantShoulderViewController* giantView = [[GiantShoulderViewController alloc]init];
//            giantView.delegate = self;
//
//            [self presentPopupViewController:giantView animationType:MJPopupViewAnimationFade];
            DataComeFromViewController * dataController = [DataComeFromViewController new];
            [self presentPopupViewController:dataController animationType:MJPopupViewAnimationFade];

        }else if (indexPath.row == 3){
            SuggestionViewController * suggestionView = [[SuggestionViewController alloc]init];
            suggestionView.delegate = self;
            [self.navigationController presentPopupViewController:suggestionView animationType:MJPopupViewAnimationFade];

        }
    }
    [_tbView deselectRowAtIndexPath:_tbView.indexPathForSelectedRow animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            
            return 0;
            break;
            
        case 1:
            
            return 25;
            break;
            
            
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            
            return [array1 count];
            break;
            
        case 1:
            
            return [array2 count];
            break;
            

    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"xiaoheiCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textColor = [UIColor colorWithRed:96 /255.0 green:96 /255.0 blue:102 /255.0 alpha:1.0];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 100, 20)];
            [detailLabel setTextColor:[UIColor blueColor]];
            detailLabel.text = [NSString stringWithFormat:@"已使用%.2fM",[self filePath]];
            detailLabel.textColor = [UIColor colorWithRed:47 /255.0 green:120 /255.0 blue:208 /255.0 alpha:1.0];
            [detailLabel setTextAlignment:NSTextAlignmentLeft];
            [cell addSubview:detailLabel];
            //            [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //                make.right.equalTo(self.view.mas_right).with.offset(0);
            //                make.top.equalTo(self.view.mas_top).with.offset(5);
            //                make.size.mas_equalTo(CGSizeMake(100, 20));
            //            }];
            
            
        }else {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    switch (indexPath.section) {
        case 0:
            [[cell textLabel] setText:[array1 objectAtIndex:indexPath.row]];
            [[cell imageView] setImage:[UIImage imageNamed:[array3 objectAtIndex:indexPath.row]]];
            
            break;
        case 1:
            [[cell textLabel] setText:[array2 objectAtIndex:indexPath.row]];
            [[cell imageView] setImage:[UIImage imageNamed:[array4 objectAtIndex:indexPath.row]]];
            break;
            
    }
    return cell;
}
/**
 *  清理缓存
 *
 */
//计算单个文件的大小
- (long long)fileSizeAtPath:(NSString*)filePath
{
    NSLog(@"调用");
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil]fileSize];
    }
    return 0;
}
//遍历文件获得文件夹的大小，返回多少M
- (float)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator * childFilesEnumerator = [[manager subpathsAtPath:folderPath]objectEnumerator];
    NSString * fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        NSLog(@"%@",fileAbsolutePath);
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0 * 1024.0);
}
//显示缓存大小
- (float)filePath
{
    //    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //    NSLog(@"累累累累累%@,%@",cachPath,NSTemporaryDirectory());
    return [self folderSizeAtPath:NSTemporaryDirectory()];
}
//清理缓存
- (void)clearFile
{
    //    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSArray * files = [[NSFileManager defaultManager]subpathsAtPath:NSTemporaryDirectory()];
    NSLog(@"cachpath = %@",NSTemporaryDirectory());
    for (NSString * p in files) {
        NSError * error = nil;
        NSString * path = [NSTemporaryDirectory() stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
            [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            
        }
        
    }
    [self performSelectorOnMainThread:@selector(clearCachSuccess) withObject:nil waitUntilDone:YES];
}
- (void)clearCachSuccess
{
    NSLog(@"清理成功");
    UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"缓存清理完毕" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [_tbView reloadData];
}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)sendEmail{
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
        mailPicker.mailComposeDelegate = self;
        [mailPicker setSubject:@"意见反馈"];
        NSArray *toRecipients = [NSArray arrayWithObject: @"service@mlogcn.com"];
        [mailPicker setToRecipients: toRecipients];
        [self presentViewController:mailPicker animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                              
                                                        message:@"请先设置邮箱"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];

    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
}

@end
