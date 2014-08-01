//
//  AppDelegate.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"
#import "JSON.h"
#import "GTMBase64.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, MBProgressHUDDelegate, UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    CommunicationHttp *myCommunicationHttp;
    NSDictionary *strRespString;        // 回复数据
}

@property (strong, nonatomic) UIWindow *window;

@end
