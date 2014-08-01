//
//  LoginViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"
#import "LeenToast.h"

@interface LoginViewController : UIViewController <MBProgressHUDDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    LeenToast *myLeenToast;
    float keyboardHeight;       // 键盘高度
    Common *myCommon;
    
    CommunicationHttp *myCommunicationHttp;
    UITextField *accountNameText;       // 用户名
    UITextField *pwdText;       // 密码
    UIButton *autoLoginBtn;       // 记住密码
    NSString *isAutoLogin;        // 是否自动登录
    UIButton *loginBtn;
    NSDictionary *strRespString;        // 回复数据
}

@end
