//
//  AppDelegate.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Common.h"
#import "MainBoardViewController.h"
#import "JSON.h"
#import "Reachability.h"

@implementation AppDelegate

// 检查更新
- (void)checkVersion
{
    // 显示HUD
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
    [self.window bringSubviewToFront:HUD];
    HUD.delegate = self;
    HUD.labelText = @"正在检查更新...";
    [HUD show:YES];
    
    // 设置检查更新事件的请求参数
    NSMutableDictionary *tempDicAppUpdate = [[NSMutableDictionary alloc] init];
    //    [tempDicAppUpdate setValue:GOLD forKey:@"tier"];
    // 转换成json格式
    NSString *strJsonData = [NSString stringWithFormat:@"%@",[tempDicAppUpdate JSONRepresentation]];
//    NSLog(@"update status: %@",strJsonData);
    
    // 发送请求
    [myCommunicationHttp sendHttpRequest:HTTP_UPDATE threadType:0 strJsonContent:strJsonData];
    
    // 2秒后假更新成功
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateStatus) userInfo:nil repeats:NO];
}

// 2秒后假更新成功
- (void)updateStatus
{
    // 隐藏HUD
    if(HUD)
    {
        [HUD removeFromSuperview];
        HUD = nil;
    }
    
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"" message:@"当前为最新版本" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alt show];
    [alt dismissWithClickedButtonIndex:0 animated:YES];
}

// 判断网络连接并更新
- (void)judgeNetworkStatus
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus networkStatus = [reach currentReachabilityStatus];
    if(networkStatus == kNotReachable)
    {
        [self showAlertMessage:@"亲，社区通需要连接网络才能使用哦~"];
    }
    else
    {
        // 检查更新
//        [self checkVersion];
    }
}

// 检查自动登录
- (BOOL)checkAutoLogin
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?UID=%@",HTTPURL_AUTOLOGINAUTH,[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"strRequestURL = %@",strRequestURL);
    
    // 发送登录请求
    strRespString = [myCommunicationHttp sendHttpRequest:HTTP_AUTOLOGINAUTH threadType:1 strJsonContent:strRequestURL];
    if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
    {
//        NSLog(@"IsAuthenticated = %d",[[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"IsAuthenticated"] intValue]);
        return [[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"IsAuthenticated"] intValue];
    }
    
    return false;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    
//    //// 测试HTTP_TEST
//    [myCommunicationHttp sendHttpRequest:HTTP_IMAGETEST threadType:1 strJsonContent:jsonData];


    // 判断网络连接，检查更新
    [self judgeNetworkStatus];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:ISFIRSTLOGIN] isEqualToString:@"isLogined"])
    {
        // 已登录成功过
        
        if([self checkAutoLogin])       // 检查自动登录
        {
            // 未超时进功能界面
            MainBoardViewController *mainBoardViewController = [[MainBoardViewController alloc] init];
            self.window.rootViewController = mainBoardViewController;
        }
        else
        {
            // 超时进登录界面
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            self.window.rootViewController = loginViewController;
        }
    }
    else
    {
        // 未登录成功过
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        self.window.rootViewController = loginViewController;
    }

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - show Alert Message

//提示信息框
- (void)showAlertMessage:(NSString *)msg
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    [alertView show];
    
}


#pragma mark MBProgressHUD methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
//    NSLog(@"Hud:%@",hud);
    [HUD removeFromSuperview];
    HUD = nil;
}


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        // 退出程序
        exit(0);
    }
}

@end
