//
//  WZGuideViewController.m
//  WZGuideViewController
//
//  Created by Wei on 13-3-11.
//  Copyright (c) 2013年 ZhuoYun. All rights reserved.
//

#import "WZGuideViewController.h"
#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Iphone6p 736
#define Iphone6 667
#define Iphone5 568
#define Iphone4 480

@interface WZGuideViewController ()

@end

@implementation WZGuideViewController

@synthesize animating = _animating;

@synthesize pageScroll = _pageScroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark -

- (CGRect)onscreenFrame
{
	return [UIScreen mainScreen].applicationFrame;
}

- (CGRect)offscreenFrame
{
	CGRect frame = [self onscreenFrame];
	switch ([UIApplication sharedApplication].statusBarOrientation)
    {
		case UIInterfaceOrientationPortrait:
			frame.origin.y = frame.size.height;
			break;
		case UIInterfaceOrientationPortraitUpsideDown:
			frame.origin.y = -frame.size.height;
			break;
		case UIInterfaceOrientationLandscapeLeft:
			frame.origin.x = frame.size.width;
			break;
		case UIInterfaceOrientationLandscapeRight:
			frame.origin.x = -frame.size.width;
			break;
	}
	return frame;
}

- (void)showGuide
{
	if (!_animating && self.view.superview == nil)
	{
		[WZGuideViewController sharedGuide].view.frame = [self offscreenFrame];
		[[self mainWindow] addSubview:[WZGuideViewController sharedGuide].view];
		
		_animating = YES;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(guideShown)];
		[WZGuideViewController sharedGuide].view.frame = [self onscreenFrame];
		[UIView commitAnimations];
	}
}

- (void)guideShown
{
	_animating = NO;
}

- (void)hideGuide
{
	if (!_animating && self.view.superview != nil)
	{
		_animating = YES;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(guideHidden)];
		[WZGuideViewController sharedGuide].view.frame = [self offscreenFrame];
		[UIView commitAnimations];
	}
}

- (void)guideHidden
{
	_animating = NO;
	[[[WZGuideViewController sharedGuide] view] removeFromSuperview];
}

- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

+ (void)show
{
    [[WZGuideViewController sharedGuide].pageScroll setContentOffset:CGPointMake(0.f, 0.f)];
	[[WZGuideViewController sharedGuide] showGuide];
}

+ (void)hide
{
	[[WZGuideViewController sharedGuide] hideGuide];
}

#pragma mark - 

+ (WZGuideViewController *)sharedGuide
{
    @synchronized(self)
    {
        static WZGuideViewController *sharedGuide = nil;
        if (sharedGuide == nil)
        {
            sharedGuide = [[self alloc] init];
        }
        return sharedGuide;
    }
}


- (void)pressEnterButton:(UIButton *)enterButton
{
    [self hideGuide];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"begin" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *imageNameArray = [NSArray arrayWithObjects:@"slogan1.jpg", @"slogan2.jpg", @"slogan3.jpg",@"slogan4.jpg", nil];
    
    
    _pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
    self.pageScroll.pagingEnabled = YES;
    self.pageScroll.contentSize = CGSizeMake(ScreenWidth * imageNameArray.count, 0);
    self.pageScroll.showsHorizontalScrollIndicator = NO;
    self.pageScroll.showsVerticalScrollIndicator = NO;
    self.pageScroll.delegate = self;
    [self.view addSubview:self.pageScroll];
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    switch ((NSInteger)ScreenHeigth) {
        case Iphone6p:
        case Iphone6:
        case Iphone5:{
            pageControl.center = CGPointMake(self.view.center.x, ScreenHeigth - 30);

            break;
        }
        case Iphone4:
        {
            pageControl.center = CGPointMake(self.view.center.x, ScreenHeigth - 20);

            break;
        }
            
        default:
            break;
    }

    pageControl.numberOfPages = 4;
    [self.view addSubview:pageControl];
    NSString *imgName = nil;
    UIImageView *view;
    for (int i = 0; i < imageNameArray.count; i++) {
        imgName = [imageNameArray objectAtIndex:i];
        view = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width * i), 0.f, self.view.frame.size.width, self.view.frame.size.height)];
        switch ((NSInteger)ScreenHeigth) {
            case Iphone6p:{
                 view.frame = CGRectMake((self.view.frame.size.width * i), 0.f, self.view.frame.size.width, self.view.frame.size.height);
                break;
            }
            case Iphone6:
            case Iphone5:{
                view.frame = CGRectMake((self.view.frame.size.width * i), 0.f, self.view.frame.size.width, self.view.frame.size.height);
                break;
            }
            case Iphone4:{
                view.frame = CGRectMake((self.view.frame.size.width * i), -14, 320, 568);

                break;
            }
                
            default:
                break;
        }

        view.image = [UIImage imageNamed:imgName];
        view.userInteractionEnabled = YES;
        [self.pageScroll addSubview:view];
        
        if (i == imageNameArray.count - 1) {            
            
            UIButton *enterButton = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 118, 42)];
            [enterButton setTitle:@"进入天气家" forState:UIControlStateNormal];
            [enterButton.layer setCornerRadius:21];
            [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [enterButton setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]];
                        switch ((NSInteger)ScreenHeigth) {
                case Iphone6p:
                case Iphone6:
                case Iphone5:{
                    [enterButton setCenter:CGPointMake(self.view.center.x,ScreenHeigth - 70)];

                    break;
                }
                case Iphone4:
                {
                    [enterButton setCenter:CGPointMake(self.view.center.x,ScreenHeigth - 40)];
                    
                    break;
                }
                    
                default:
                    break;
            }
            [enterButton addTarget:self action:@selector(pressEnterButton:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:enterButton];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage = scrollView.contentOffset.x / ScreenWidth;

    NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x <= 0) {
        scrollView.contentOffset = CGPointZero;
        self.pageScroll.pagingEnabled = NO;

    }else if(scrollView.contentOffset.x < ScreenWidth * 3){
        self.pageScroll.pagingEnabled = YES;

    }else if (scrollView.contentOffset.x >= ScreenWidth * 3){
                scrollView.contentOffset = CGPointMake(ScreenWidth * 3, 0);
        self.pageScroll.pagingEnabled = NO;

    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
