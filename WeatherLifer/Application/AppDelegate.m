//
//  AppDelegate.m
//  WeatherLifer
//
//  Created by ink on 15/5/26.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#define BaiDuAK @"qBuR3CwY61Gkv1IpEzqnQIxs"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define YouMengKey @"553efa75e0f55aa732000472"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "MobClick.h"
#import "WZGuideViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentDirectory = [paths objectAtIndex:0];
    NSString * dbpath = [documentDirectory stringByAppendingPathComponent:@"Weatherist.db"];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath:dbpath]) {
        NSLog(@"存在");
        [fileMgr removeItemAtPath:dbpath error:nil];
    }else{
        NSLog(@"不存在");

    }
    [Fabric with:@[CrashlyticsKit]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [MobClick startWithAppkey:YouMengKey reportPolicy:BATCH channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [UMSocialData setAppKey:YouMengKey];
    [UMSocialWechatHandler setWXAppId:@"wxa048b611a1aed1e5" appSecret:@"799ad9398a1ec1b175ffb754525c0b9b" url:nil];
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:BaiDuAK generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failded");
    }
    LeftViewController * leftController = [LeftViewController new];
    RootViewController * rootController = [RootViewController new];
    UINavigationController * rootNavController = [[UINavigationController alloc] initWithRootViewController:rootController];
    MMDrawerController * drawerController = [[MMDrawerController alloc] initWithCenterViewController:rootNavController leftDrawerViewController:leftController];
    [drawerController setMaximumLeftDrawerWidth:ScreenWidth - 40];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeTapCenterView];

    self.window.rootViewController = drawerController;
    [self.window makeKeyAndVisible];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [WZGuideViewController show];
    }

    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    NSLog(@"%@",url);
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
