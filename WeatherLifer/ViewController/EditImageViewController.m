//
//  EditImageViewController.m
//  WeatherLifer
//
//  Created by ink on 15/5/7.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "EditImageViewController.h"
#import "Masonry.h"
#import "EffectCollectionViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "UMSocialDataService.h"
#import "UMSocialSnsPlatformManager.h"
#define LastCity @"LastCity"

#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define RowCount 7
#define ItemWith 108
#define ItemHeight 100
#define NavHeight 44
#define BottomHeight 70
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480
#define PhotoLocation @"PhotoLocation"
@interface EditImageViewController (){
    UIImageView * photoImageView;
    UIImage * photoImage;
    NSArray * effectArray;
    NSMutableArray * imageArray;
    UIButton * _coloButton;
    UILabel * temperatureLabel;
    UILabel * firstLable;
    UILabel * secondLabel;
    UILabel * thirdLable;
    UIImageView * iconImageView;
    NSArray * effectImageArray;
    ShareView * _shareView;
}

@end

@implementation EditImageViewController
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        photoImage = image;
        effectArray = [NSArray arrayWithObjects:@"原图",@"晴朗",@"多云",@"阴天",@"雨天",@"雾霾",@"沙尘", nil];
        effectImageArray = [NSArray arrayWithObjects:@"normal.jpg",@"hudson.jpg",@"rise.jpg",@"x-pro-ll.jpg",@"walden.jpg",@"amaro.jpg",@"earlybird.jpg", nil];
        imageArray = [NSMutableArray array];
        self.textArray = [NSMutableArray array];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:36 / 255.0 green:33 / 255.0 blue:28 / 255.0 alpha:1.0];
    photoImageView = [UIImageView new];
    [self.view addSubview:photoImageView];
    [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(NavHeight + 10);
        make.left.equalTo(self.view.mas_left).with.offset(ScreenWidth * 0.05f);
        make.width.mas_equalTo(ScreenWidth * 0.9);
        make.height.mas_equalTo((ScreenHeigth - NavHeight - BottomHeight) * 0.9);
    }];
    photoImageView.image = photoImage;
    
    iconImageView = [UIImageView new];
    [photoImageView addSubview:iconImageView];
    iconImageView.image = self.iconImage;
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(photoImageView.mas_top).with.offset(70 * 0.9);
        make.size.mas_equalTo(CGSizeMake(75 * 0.9, 70 * 0.9));
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:{
                make.top.equalTo(photoImageView.mas_top).with.offset(50 * 0.9);
                make.left.equalTo(photoImageView.mas_left).with.offset(10 * 0.9);
                
                break;
            }
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(photoImageView.mas_top).with.offset(25 * 0.9);
                make.left.equalTo(photoImageView.mas_left).with.offset(8 * 0.9);
                
                
                break;
            }
            default:
                break;
        }

    }];
    [self setViewShowdow:iconImageView];

    temperatureLabel = [UILabel new];
    [photoImageView addSubview:temperatureLabel];
    
    [temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:{
                make.top.equalTo(photoImageView.mas_top).with.offset(50 * 0.9);
                make.right.equalTo(photoImageView.mas_right).with.offset(-10 * 0.9);

                break;
            }
            case Iphone5:
            case Iphone4:{
                make.top.equalTo(photoImageView.mas_top).with.offset(10 * 0.9);
                make.right.equalTo(photoImageView.mas_right).with.offset(-8 * 0.9);

                
                break;
            }
            default:
                break;
        }

        make.height.mas_equalTo(@(100 *0.9));
        make.width.mas_equalTo(@(200 * 0.9));
    }];
    temperatureLabel.textAlignment = NSTextAlignmentRight;
    if (self.isWhite) {
        
        temperatureLabel.textColor = [UIColor whiteColor];
    }else{
        temperatureLabel.textColor = [UIColor blackColor];

    }
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:{
            temperatureLabel.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:80];
            
            break;
        }
        case Iphone5:
        case Iphone4:{
            temperatureLabel.font =[UIFont fontWithName:@"HelveticaNeue-Thin" size:58];
            
            
            break;
        }
        default:
            break;
    }
    [self setViewShowdow:temperatureLabel];
    temperatureLabel.text = self.temperatureText;
    
    
    
    firstLable = [UILabel new];
    [photoImageView addSubview:firstLable];
    [self setLabel:firstLable];
    
    [firstLable mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:{
                make.bottom.equalTo(photoImageView.mas_bottom).with.offset(-190 * 0.7);

                break;
            }
            case Iphone5:
            case Iphone4:{
                
                make.bottom.equalTo(photoImageView.mas_bottom).with.offset(-118 * 0.7);

                break;
            }
            default:
                break;
        }

        make.right.equalTo(photoImageView.mas_right).with.offset(-10 * 0.9);
        make.height.mas_greaterThanOrEqualTo(@(30 * 0.9));
        make.width.mas_greaterThanOrEqualTo(@0);
        make.width.mas_lessThanOrEqualTo(ScreenWidth);
    }];
    
    secondLabel = [UILabel new];
    [photoImageView addSubview:secondLabel];
    [self setLabel:secondLabel];
    
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:{
                make.bottom.equalTo(photoImageView.mas_bottom).with.offset(-140 * 0.7);
                
                break;
            }
            case Iphone5:
            case Iphone4:{
                
                make.bottom.equalTo(photoImageView.mas_bottom).with.offset(-82 * 0.7);
                
                break;
            }
            default:
                break;
        }

        make.right.equalTo(photoImageView.mas_right).with.offset(-10 *0.9);
        make.height.mas_greaterThanOrEqualTo(@(30 * 0.9));
        make.width.mas_greaterThanOrEqualTo(@0);
        make.width.mas_lessThanOrEqualTo(ScreenWidth);
        
        
    }];

    
    
    thirdLable = [UILabel new];
    [photoImageView addSubview:thirdLable];
    [self setLabel:thirdLable];
    
    [thirdLable mas_makeConstraints:^(MASConstraintMaker *make) {
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6:
            case Iphone6p:{
                make.bottom.equalTo(photoImageView.mas_bottom).with.offset(-90 * 0.7);
                
                break;
            }
            case Iphone5:
            case Iphone4:{
                
                make.bottom.equalTo(photoImageView.mas_bottom).with.offset(-46 * 0.7);
                
                break;
            }
            default:
                break;
        }

        make.right.equalTo(photoImageView.mas_right).with.offset(-10 * 0.9);
        make.height.mas_greaterThanOrEqualTo(@(30 * 0.9));
        make.width.mas_greaterThanOrEqualTo(@0);
        make.width.mas_lessThanOrEqualTo(ScreenWidth);
        
    }];
    [self setViewShowdow:firstLable];
    [self setViewShowdow:secondLabel];
    [self setViewShowdow:thirdLable];

    _authLabel = [UILabel new];
    [photoImageView addSubview:_authLabel];
    _authLabel.textColor = [UIColor whiteColor];
    _authLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [_authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(photoImageView.mas_centerX);
        make.bottom.equalTo(photoImageView.mas_bottom).with.offset(-10);
        make.width.greaterThanOrEqualTo(@0);
        make.height.greaterThanOrEqualTo(@0);
        
    }];
    if (self.isWhite) {
        
        _authLabel.textColor = [UIColor whiteColor];
    }else{
        _authLabel.textColor = [UIColor blackColor];
        
    }

    _authLabel.text = self.placeString;
    if (self.textArray.count == 3) {
        
        
        
        for (int i = 0; i < self.textArray.count; i++) {
            NSDictionary * dic = [self.textArray objectAtIndex:i];
            switch (i) {
                case 0:{
                    firstLable.text =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"text"] description]];
                    [self setlabelWithString:[[dic objectForKey:@"font"] description] AndBg:[[dic objectForKey:@"bg"] description] WithLabel:firstLable];
                    break;
                }
                case 1:{
                    secondLabel.text =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"text"] description]];
                    [self setlabelWithString:[[dic objectForKey:@"font"] description] AndBg:[[dic objectForKey:@"bg"] description] WithLabel:secondLabel];
                    break;
                }
                case 2:{
                    thirdLable.text =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"text"] description]];
                    
                    [self setlabelWithString:[[dic objectForKey:@"font"] description] AndBg:[[dic objectForKey:@"bg"] description] WithLabel:thirdLable];
                    break;
                }
                    
                default:
                    break;
            }
        }
    }else if (self.textArray.count ==2 ){
        for (int i = 0; i < self.textArray.count; i++) {
            NSDictionary * dic = [self.textArray objectAtIndex:i];
            switch (i) {
                case 0:{
                    secondLabel.text =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"text"] description]];
                    [self setlabelWithString:[[dic objectForKey:@"font"] description] AndBg:[[dic objectForKey:@"bg"] description] WithLabel:secondLabel];
                    break;
                }
                case 1:{
                    thirdLable.text =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"text"] description]];
                    [self setlabelWithString:[[dic objectForKey:@"font"] description] AndBg:[[dic objectForKey:@"bg"] description] WithLabel:thirdLable];
                    break;
                }
                    
                default:
                    break;
            }
        }
        
    }else if (self.textArray.count == 1){
        for (int i = 0; i < self.textArray.count; i++) {
            NSDictionary * dic = [self.textArray objectAtIndex:i];
            switch (i) {
                case 0:{
                    secondLabel.text =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"text"] description]];
                    [self setlabelWithString:[[dic objectForKey:@"font"] description] AndBg:[[dic objectForKey:@"bg"] description] WithLabel:secondLabel];
                    break;
                }
                    
                default:
                    break;
            }
        }
        
    }
    

    
    
    
    
    
    
    
    [self initFilter];
    [self initCollectionView];
    
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavHeight)];
    navView.backgroundColor = [UIColor colorWithRed:36 / 255.0 green:33 / 255.0 blue:28 / 255.0 alpha:1.0];
    [self.view addSubview:navView];
    UIButton * saveButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50 ,0, 50, 50)];
    [saveButton setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(showShareView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [backButton setImage:[UIImage imageNamed:@"all_arrow_left_w.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    _coloButton = [UIButton new];
    [self.view addSubview:_coloButton];
    _coloButton.tag = 7;
    [_coloButton setBackgroundImage:[UIImage imageNamed:@"photo_switch_button.png"] forState:UIControlStateNormal];
    [_coloButton addTarget:self action:@selector(changeTextColor) forControlEvents:UIControlEventTouchUpInside];
    
    [_coloButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_top).with.offset(48);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@84);
    }];
    _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, ScreenHeigth, ScreenWidth, 370)];
    _shareView.delegate = self;
    [self.view addSubview:_shareView];
    photoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * cancelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
    [photoImageView addGestureRecognizer:cancelTap];
    cancelTap.delegate = self;
    NSLog(@"%@",self.textArray);

}
- (void)cancelTap{
    if (isShare) {
        
        [self closeShareView];
    }
}
- (void)changeTextColor{
    if (!self.isWhite) {
        temperatureLabel.textColor = [UIColor whiteColor];
        firstLable.textColor = [UIColor whiteColor];
        secondLabel.textColor = [UIColor whiteColor];
        thirdLable.textColor = [UIColor whiteColor];
        iconImageView.image = [UIImage imageNamed:[self.imageName stringByAppendingString:@"w"]];
        _authLabel.textColor = [UIColor whiteColor];
        [_coloButton setImage:[UIImage imageNamed:@"photo_switch_button.png"] forState:UIControlStateNormal];
        
    }else{
        temperatureLabel.textColor = [UIColor blackColor];
        _authLabel.textColor = [UIColor blackColor];
        firstLable.textColor = [UIColor blackColor];
        secondLabel.textColor = [UIColor blackColor];
        thirdLable.textColor = [UIColor blackColor];
        iconImageView.image = [UIImage imageNamed:[self.imageName stringByAppendingString:@"b"]];
        [_coloButton setImage:[UIImage imageNamed:@"photo_switch_button_pressed.png"] forState:UIControlStateNormal];
        
    }
    self.isWhite = !self.isWhite;
}
- (void)setlabelWithString:(NSString *)size AndBg:(NSString *)bg WithLabel:(UILabel *)label{
    NSLog(@"%f",ScreenWidth);
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6:
        case Iphone6p:
            label.font =   [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
            if ([bg isEqualToString:@"N"]) {
                label.backgroundColor = [UIColor clearColor];
            }else if([bg isEqualToString:@"Y"]){
                label.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
            }
            
            break;
        case Iphone5:
        case Iphone4:{
            label.font =   [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
            if ([bg isEqualToString:@"N"]) {
                label.backgroundColor = [UIColor clearColor];
            }else if([bg isEqualToString:@"Y"]){
                label.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
            }
            
            break;
        }
        default:
            break;
    }
}

- (void)setLabel:(UILabel *)label{
    if (self.isWhite) {
        
        label.textColor = [UIColor whiteColor];
    }else{
        label.textColor = [UIColor blackColor];

    }
    label.textAlignment = NSTextAlignmentRight;
    [label sizeToFit];
    
}

- (void)savePhotoToPhone{
    UIImageWriteToSavedPhotosAlbum([self snapShot], self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)sharePhotoToFriend{
    NSData * data =    UIImageJPEGRepresentation([self snapShot], 0.5);
    UIImage * sendImage = [UIImage imageWithData:data];
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [UMSocialData defaultData].extConfig.wechatSessionData.title =  [[NSUserDefaults standardUserDefaults] objectForKey:PhotoLocation];;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:nil image:sendImage location:nil urlResource:nil presentedController:  [UIApplication sharedApplication].keyWindow.rootViewController completion:^(UMSocialResponseEntity * response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        } else if(response.responseCode != UMSResponseCodeCancel) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    
    
}
- (void)sharePhototoTimeLine{
    NSData * data =    UIImageJPEGRepresentation([self snapShot], 0.5);
    UIImage * sendImage = [UIImage imageWithData:data];
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:nil image:sendImage location:nil urlResource:nil presentedController:  [UIApplication sharedApplication].keyWindow.rootViewController completion:^(UMSocialResponseEntity * response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        } else if(response.responseCode != UMSResponseCodeCancel) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    
    
    
}
- (void)sharePhotoToWeibo{
    NSData * data =    UIImageJPEGRepresentation([self snapShot], 0.5);
    UIImage * sendImage = [UIImage imageWithData:data];
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:nil image:sendImage location:nil urlResource:nil presentedController:  [UIApplication sharedApplication].keyWindow.rootViewController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        }
    }];
    
}
- (void)moreButtonPress{
    UIImage * image = [self snapShot];
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];
    activityController.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToWeibo, UIActivityTypeAssignToContact,nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:activityController animated:YES completion:nil];
    
}



- (void)backAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditImageBack" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)showShareView{
    [self openShareView];
    
}


- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                          
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    
    [alert show];
    
}
- (UIImage *)snapShot{
//    NSLog(@"%@",NSStringFromCGRect(photoImageView.bounds));
    UIGraphicsBeginImageContextWithOptions(photoImageView.bounds.size, YES, 0);
    [photoImageView drawViewHierarchyInRect:photoImageView.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;

}
- (void)initFilter{
    self.rotationFilter = [[IFRotationFilter alloc] initWithRotation:kGPUImageRotateRight];
    self.filter = [[IFNormalFilter alloc] init];
    self.internalFilter = self.filter;
    [self.rotationFilter addTarget:self.filter];
    
}
- (void)initCollectionView{
    UICollectionViewFlowLayout * collectionLayout = [UICollectionViewFlowLayout new];
    CGFloat width = ItemHeight / (ScreenHeigth - NavHeight -BottomHeight) * ScreenWidth;
    NSLog(@"%f,%d",width,ItemHeight);
    [collectionLayout setItemSize:CGSizeMake(width,  ItemHeight)];
    collectionLayout.sectionInset = UIEdgeInsetsZero;
    collectionLayout.minimumInteritemSpacing = 0;
    collectionLayout.minimumLineSpacing = 20;
    collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView * effectCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ScreenHeigth - ItemHeight, ScreenWidth, ItemHeight) collectionViewLayout:collectionLayout];
    effectCollectionView.delegate = self;
    effectCollectionView.dataSource = self;
    [effectCollectionView registerClass:[EffectCollectionViewCell class] forCellWithReuseIdentifier:@"effectCollectionCell"];
    [self.view addSubview:effectCollectionView];
    effectCollectionView.backgroundColor =[UIColor colorWithRed:36 / 255.0 green:33 / 255.0 blue:28 / 255.0 alpha:1.0];

    [effectCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}
#pragma mark collectionViewDateSoure
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return RowCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"effectCollectionCell";
    EffectCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.exampleImageView.image = photoImage;
    cell.effectLabel.text = effectArray[indexPath.row];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self selectFilter:indexPath.row];

}
- (void)selectFilter:(effectType)type{
    
    if ((photoImage != nil) && (self.stillImageSource == nil)) {
        
        // This is the state when we just switched from live view to album photo view
        [self.rotationFilter removeTarget:self.filter];
        self.stillImageSource = [[GPUImagePicture alloc] initWithImage:photoImage];
        [self.stillImageSource addTarget:self.filter];
    } else {
        
        if (_currentFilterType == type) {
            return;
        }
    }
    
    [self forceSwitchToNewFilter:type];

}
- (void)forceSwitchToNewFilter:(effectType)type{
    _currentFilterType = type;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        switch (type) {
            case NORMAL_TYPE:{
                self.internalFilter = [[IFNormalFilter alloc] init];
                break;
            }
                
            case ARARO_TYPE:{
                self.internalFilter = [[IFAmaroFilter alloc] init];
                self.internalSourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blackboard1024" ofType:@"png"]]];
                self.internalSourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"overlayMap" ofType:@"png"]]];
                self.internalSourcePicture3 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"amaroMap" ofType:@"png"]]];
                break;
            }
            case RISE_TYPE:{
                self.internalFilter = [[IFRiseFilter alloc] init];
                self.internalSourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blackboard1024" ofType:@"png"]]];
                self.internalSourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"overlayMap" ofType:@"png"]]];
                self.internalSourcePicture3 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"riseMap" ofType:@"png"]]];

                break;
            }
            case HUDSON_TYPE:{
                self.internalFilter = [[IFHudsonFilter alloc] init];
                self.internalSourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hudsonBackground" ofType:@"png"]]];
                self.internalSourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"overlayMap" ofType:@"png"]]];
                self.internalSourcePicture3 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hudsonMap" ofType:@"png"]]];
                break;
            }
            case X_PRO_TYPE:{
                self.internalFilter = [[IFXproIIFilter alloc] init];
                self.internalSourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"xproMap" ofType:@"png"]]];
                self.internalSourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"vignetteMap" ofType:@"png"]]];

                break;
            }
            case EARLYBIRD_TYPE:{
                self.internalFilter = [[IFEarlybirdFilter alloc] init];
                self.internalSourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"earlyBirdCurves" ofType:@"png"]]];
                self.internalSourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"earlybirdOverlayMap" ofType:@"png"]]];
                self.internalSourcePicture3 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"vignetteMap" ofType:@"png"]]];
                self.internalSourcePicture4 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"earlybirdBlowout" ofType:@"png"]]];
                self.internalSourcePicture5 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"earlybirdMap" ofType:@"png"]]];
                break;
            }
            case WALDEN_TYPE:{
                self.internalFilter = [[IFWaldenFilter alloc] init];
                self.internalSourcePicture1 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"waldenMap" ofType:@"png"]]];
                self.internalSourcePicture2 = [[GPUImagePicture alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"vignetteMap" ofType:@"png"]]];
                break;
            }
                
            default:
                break;
        }
        [self performSelectorOnMainThread:@selector(switchNewFilter) withObject:nil waitUntilDone:NO];
        
    });

}
- (void)switchNewFilter{
    if (self.stillImageSource == nil) {
        [self.rotationFilter removeTarget:self.filter];
        self.filter = self.internalFilter;
        [self.rotationFilter addTarget:self.filter];
    } else {
        [self.stillImageSource removeTarget:self.filter];
        self.filter = self.internalFilter;
        [self.stillImageSource addTarget:self.filter];
    }
    
    switch (_currentFilterType) {
        case NORMAL_TYPE:{
            break;
        }
        case ARARO_TYPE:{
            self.sourcePicture1 = self.internalSourcePicture1;
            self.sourcePicture2 = self.internalSourcePicture2;
            self.sourcePicture3 = self.internalSourcePicture3;
            
            [self.sourcePicture1 addTarget:self.filter];
            [self.sourcePicture2 addTarget:self.filter];
            [self.sourcePicture3 addTarget:self.filter];

            break;
        }
        case RISE_TYPE:{
            self.sourcePicture1 = self.internalSourcePicture1;
            self.sourcePicture2 = self.internalSourcePicture2;
            self.sourcePicture3 = self.internalSourcePicture3;
            
            [self.sourcePicture1 addTarget:self.filter];
            [self.sourcePicture2 addTarget:self.filter];
            [self.sourcePicture3 addTarget:self.filter];

            break;
        }
        case HUDSON_TYPE:{
            self.sourcePicture1 = self.internalSourcePicture1;
            self.sourcePicture2 = self.internalSourcePicture2;
            self.sourcePicture3 = self.internalSourcePicture3;
            
            [self.sourcePicture1 addTarget:self.filter];
            [self.sourcePicture2 addTarget:self.filter];
            [self.sourcePicture3 addTarget:self.filter];

            break;
        }
        case X_PRO_TYPE:{
            self.sourcePicture1 = self.internalSourcePicture1;
            self.sourcePicture2 = self.internalSourcePicture2;
            
            [self.sourcePicture1 addTarget:self.filter];
            [self.sourcePicture2 addTarget:self.filter];
            break;
        }
        case EARLYBIRD_TYPE:{
            self.sourcePicture1 = self.internalSourcePicture1;
            self.sourcePicture2 = self.internalSourcePicture2;
            self.sourcePicture3 = self.internalSourcePicture3;
            self.sourcePicture4 = self.internalSourcePicture4;
            self.sourcePicture5 = self.internalSourcePicture5;
            
            [self.sourcePicture1 addTarget:self.filter];
            [self.sourcePicture2 addTarget:self.filter];
            [self.sourcePicture3 addTarget:self.filter];
            [self.sourcePicture4 addTarget:self.filter];
            [self.sourcePicture5 addTarget:self.filter];

            break;

        }
        case WALDEN_TYPE:{
            self.sourcePicture1 = self.internalSourcePicture1;
            self.sourcePicture2 = self.internalSourcePicture2;
            
            [self.sourcePicture1 addTarget:self.filter];
            [self.sourcePicture2 addTarget:self.filter];

            break;
        }
        default:
            break;
    }
    if (self.stillImageSource != nil) {
        [self.stillImageSource processImage];
        
    } else {
        
    }
    photoImageView.image = [[self.filter imageFromCurrentlyProcessedOutput] imageRotatedByDegrees:self.degress];
//    imageArray addObject:[[self.filter imageFromCurrentlyProcessedOutput] imageRotatedByDegrees:self.degress];
}
- (void)setViewShowdow:(UIView *)view{
    view.layer.shadowColor = [UIColor colorWithRed:170 / 255.0 green:170 / 255.0 blue:170 / 255.0 alpha:1.0].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 10;
    view.layer.shadowOpacity = 1.0;
    
}
- (void)openShareView{
    isShare = YES;
      [UIView animateWithDuration:0.7 animations:^{
        _shareView.frame = CGRectMake(0, ScreenHeigth - 370, ScreenWidth, 370);
    }];
}
- (void)closeShareView{
  
    isShare = NO;
    [UIView animateWithDuration:0.7 animations:^{
        _shareView.frame = CGRectMake(0, ScreenHeigth, ScreenWidth, 370);
    }];
    
}
- (void)selectShareStyle:(NSInteger)tag{
    switch (tag) {
        case 1:{
            [self sharePhotoToFriend];
            break;
        }
        case 2:{
            [self sharePhototoTimeLine];
            break;
        }
        case 3:{
            [self sharePhotoToWeibo];
            break;
        }
        case 4:{
            [self savePhotoToPhone];
            break;
        }
        case 5:{
            [self moreButtonPress];
            break;
        }
        case 6:{
            [self closeShareView];
        }
            
        default:
            break;
    }

}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    NSLog(@"%@",gestureRecognizer.view);
//    
//    return NO;
//}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    NSLog(@"%@",touch.view.class);
    return YES;
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return NO;
//}

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

@end
