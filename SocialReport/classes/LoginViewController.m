//
//  LoginViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "LoginViewController.h"
#import "JSON.h"
#import "Common.h"
#import "MainBoardViewController.h"

#define MAIN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define PADDING_LEFT 20
#define PADDING_TOP 70


@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)init
{
    if (self = [super init])
    {
        
        return self;
    }
    
    return self;
}

- (void)initView
{
    CGRect frame = self.view.frame;
    
    // set background image
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:frame];
    // bg for ip5
    if (MAIN_SCREEN_HEIGHT > 480)
    {
        [bgView setImage:[UIImage imageNamed:@"bg-568h"]];
        
    }
    // bg for ip4
    else
    {
        [bgView setImage:[UIImage imageNamed:@"bg"]];
    }
    [self.view addSubview:bgView];

    // logo
    frame.origin.x = (320 - 200)/2 + 15;
    frame.origin.y = PADDING_TOP;
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 200, 76)];
    [logoView setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logoView];
    
    // account bg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = frame.origin.y + logoView.frame.size.height + 105;
    frame.size.width = 280;
    frame.size.height = 100;
    UIImageView *loginBgView = [[UIImageView alloc] initWithFrame:frame];
    [loginBgView setImage:[UIImage imageNamed:@"login_bg"]];
    [loginBgView setUserInteractionEnabled:YES];
    [self.view addSubview:loginBgView];
    
    // accountNameLabel
    UILabel *accountNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 100/2-10)];
    accountNameLabel.backgroundColor = [UIColor clearColor];
    accountNameLabel.textAlignment = NSTextAlignmentLeft;
    accountNameLabel.font = [UIFont systemFontOfSize:16.0f];
    accountNameLabel.text = @"帐号:";
    [loginBgView addSubview:accountNameLabel];
    
    // accountNameText
    accountNameText =[[UITextField alloc] initWithFrame:CGRectMake(60, 10, 200, 100/2-10)];
    accountNameText.backgroundColor = [UIColor clearColor];
    accountNameText.textAlignment = NSTextAlignmentLeft;
    [accountNameText setReturnKeyType:UIReturnKeyDone];
    // 设置垂直居中
    accountNameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    accountNameText.font = [UIFont systemFontOfSize:16.0f];
    accountNameText.placeholder = @"请输入用户名";
    accountNameText.autocorrectionType = UITextAutocorrectionTypeNo;    // 关闭自动语法错误提示
    accountNameText.autocapitalizationType = UITextAutocapitalizationTypeNone;    // 关闭自动大小写
    accountNameText.delegate = self;
    [loginBgView addSubview:accountNameText];
    
    // 默认用户名
    if([[NSUserDefaults standardUserDefaults] objectForKey:USERID])
        accountNameText.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    
    // bgline
    UILabel *bgLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+40, 260, 1)];
    bgLine.backgroundColor = [UIColor lightGrayColor];
    [loginBgView addSubview:bgLine];
    
    // pwdLabel
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 51, 60, 100/2-10)];
    pwdLabel.backgroundColor = [UIColor clearColor];
    pwdLabel.textAlignment = NSTextAlignmentLeft;
    pwdLabel.font = [UIFont systemFontOfSize:16.0f];
    pwdLabel.text = @"密码:";
    [loginBgView addSubview:pwdLabel];
    
    // pwdText
    pwdText =[[UITextField alloc] initWithFrame:CGRectMake(60, 51, 200, 100/2-10)];
    pwdText.backgroundColor = [UIColor clearColor];
    pwdText.textAlignment = NSTextAlignmentLeft;
    pwdText.secureTextEntry = YES;
    [pwdText setReturnKeyType:UIReturnKeyDone];
    // 设置垂直居中
    pwdText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [pwdText setKeyboardType:UIKeyboardTypeAlphabet];
    pwdText.font = [UIFont systemFontOfSize:16.0f];
    pwdText.placeholder = @"请输入密码";
    pwdText.autocorrectionType = UITextAutocorrectionTypeNo;    // 关闭自动语法错误提示
    pwdText.autocapitalizationType = UITextAutocapitalizationTypeNone;    // 关闭自动大小写
    pwdText.delegate = self;
    [loginBgView addSubview:pwdText];
    
    // autoLoginBtn
    frame.origin.y = frame.origin.y + loginBgView.frame.size.height + 15 + 10;
    frame.size.width = 25;
    frame.size.height = 25;
    autoLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    autoLoginBtn.frame = frame;
    [autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"showMore"] forState:UIControlStateNormal];
    [autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"showMore_h"] forState:UIControlStateSelected];
    [autoLoginBtn addTarget:self action:@selector(autoLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:autoLoginBtn];
    
    // autoLoginLbl
    frame.origin.x += 25 + 10;
    frame.origin.y -= 10;
    frame.size.width = 85;
    frame.size.height = 45;
    UILabel *autoLoginLbl = [[UILabel alloc] initWithFrame:frame];
    autoLoginLbl.text = @"自动登录";
    autoLoginLbl.font = [UIFont systemFontOfSize:16.0f];
    autoLoginLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:autoLoginLbl];
    
    // loginBtn
    frame.origin.x += 85;
    frame.size.width = 160;
    frame.size.height = 45;
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = frame;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];

}

- (void)initData
{
    myLeenToast = [[LeenToast alloc] init];
    isAutoLogin = @"false";     //默认不自动登录
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    
    myCommon = [Common shared];
    // 获取openudid
    myCommon.m_strOpenUDID = [myCommon getOpenUDID];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self initView];
    
    [self initData];
    
    // 获取键盘高度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击登录按钮
-(void)loginBtnClicked
{
    [accountNameText resignFirstResponder];
    [pwdText resignFirstResponder];
    
    // 设置请求URL
    NSString *strRequestURL;
    if([accountNameText.placeholder isEqualToString:@"请输入用户名"])
    {
        strRequestURL = [NSString stringWithFormat:@"%@?userID=%@&password=%@&tel=%@&rememberMe=%@&vCode=%@&machineKey=%@&type=%@",HTTPURL_LOGIN,accountNameText.text,pwdText.text,@"",isAutoLogin,@"",myCommon.m_strOpenUDID,@"0"];
    }
    else
    {
        strRequestURL = [NSString stringWithFormat:@"%@?userID=%@&password=%@&tel=%@&rememberMe=%@&vCode=%@&machineKey=%@&type=%@",HTTPURL_LOGIN,@"",@"",accountNameText.text,isAutoLogin,pwdText.text,myCommon.m_strOpenUDID,@"1"];
    }
//    NSLog(@"strRequestURL = %@",strRequestURL);
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"登录中...";
        [HUD showAnimated:YES whileExecutingBlock:^
        {
            
            strRespString = [myCommunicationHttp sendHttpRequest:HTTP_LOGIN threadType:1 strJsonContent:strRequestURL];
            
        }
          completionBlock:^
         {
             // 隐藏HUD
             [HUD removeFromSuperview];
             HUD = nil;
             
             if(strRespString)
             {
                 if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
                 {
                     // 设置已登录过标志
                     [[NSUserDefaults standardUserDefaults] setValue:@"isLogined" forKey:ISFIRSTLOGIN];
                     // 保存令牌UID
                     [[NSUserDefaults standardUserDefaults] setValue:[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UID"] forKey:UID];
                     // 保存用户ID
                     [[NSUserDefaults standardUserDefaults] setValue:[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UserID"] forKey:USERID];
                     // 保存用户名
                     [[NSUserDefaults standardUserDefaults] setValue:[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UserName"] forKey:USERNAME];
                     // 租户号
                     [[NSUserDefaults standardUserDefaults] setValue:[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"TenantCode"] forKey:TENANTCODE];
                 
                     [myLeenToast settext:@"登录成功"];
                     [myLeenToast show];
                     
                     // 切换到主界面
                     MainBoardViewController *mainBoardViewController = [[MainBoardViewController alloc] init];
                     [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                     [self presentModalViewController:mainBoardViewController animated:YES];
                 }
                 else if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 8)
                 {
                     UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你不在常用地区登录，请用手机验证码登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alt show];
                     return;
                 }
                 else if([accountNameText.text isEqualToString:@""])
                 {
                     [myLeenToast settext:@"用户名不能为空"];
                     [myLeenToast show];
                     return;
                 }
                 else if([pwdText.text isEqualToString:@""])
                 {
                     [myLeenToast settext:@"密码不能为空"];
                     [myLeenToast show];
                     return;
                 }
                 else
                 {
                     // 用户名或密码错误
                     [myLeenToast settext:@"用户名或密码错误"];
                     [myLeenToast show];
                     return;
                 }
             }
             else
             {
                 // 网络错误
                 [myLeenToast settext:@"网络异常，请检查网络后重试~"];
                 [myLeenToast show];
                 return;
             }
         }];

    }
}

// 是否记住密码自动登录
- (void)autoLoginBtnClick
{
    if(!autoLoginBtn.selected)
    {
        isAutoLogin = @"true";
    }
    else
    {
        isAutoLogin = @"false";
    }
    
    autoLoginBtn.selected = !autoLoginBtn.selected;
}

// 获取短信验证码
- (void)getMsgBtnClicked
{
    
}


#pragma mark UITextFieldDelegate

//开始编辑时调整键盘高度
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(keyboardHeight == 0)
        keyboardHeight = 216;
    CGRect frame = textField.frame;
    CGFloat offset;
    offset = 251 + frame.origin.y + frame.size.height + 60 - (self.view.frame.size.height - keyboardHeight) ;//键盘高度keyboardHeight
    if(SYSTEM_VERSION < 7.0f)
        offset = 251 + frame.origin.y + frame.size.height + 50 - (self.view.frame.size.height - keyboardHeight) ;//键盘高度keyboardHeight
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //高度不够，需要调整，抬高self.view到offset的高度
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    //高度够了，若上次有抬高self.view，则需要恢复到0高度
    else
    {
        if(self.view.frame.origin.y < 0 )
        {
            CGRect rect = CGRectMake(0.0f, 0.0f,width,height);
            self.view.frame = rect;
        }
        
    }
    
    [UIView commitAnimations];
}

// called when resign fist responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    // 键盘消失时需要恢复self.view到0高度
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

// called when click done button
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 键盘消失时需要恢复self.view到0高度
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *) noti
{
    NSDictionary *info = [noti userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyboardHeight = [value CGRectValue].size.height;
    
    ///keyboardWasShown = YES;
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
        accountNameText.placeholder = @"请输入手机号";
        pwdText.placeholder = @"请输入验证码";
        [loginBtn setTitle:@"获取短信码" forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(getMsgBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
