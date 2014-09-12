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

#define PADDING_LEFT 20
#define PADDING_TOP 90


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
    if (SCREEN_SIZE.height > 480)
    {
        [bgView setImage:[UIImage imageNamed:@"bg-568h"]];
        
    }
    else
    {
        [bgView setImage:[UIImage imageNamed:@"bg"]];
    }
    [self.view addSubview:bgView];

    // account background
    frame.origin.x = (320 - 104.5)/2;
    frame.origin.y = PADDING_TOP;
    frame.size.width = 104.5;
    frame.size.height = 104.5;
    UIImageView *accountBg = [[UIImageView alloc] initWithFrame:frame];
    [accountBg setImage:[UIImage imageNamed:@"accountBg"]];
    [self.view addSubview:accountBg];
    
    // account image
    frame.origin.x = 10.5/2;
    frame.origin.y = 10.5/2;
    frame.size.width = 94;
    frame.size.height = 94;
    UIImageView *accountImg = [[UIImageView alloc] initWithFrame:frame];
    [accountImg setImage:[UIImage imageNamed:@"accountImg"]];
    [accountBg addSubview:accountImg];
    
    // accountNameText
    frame.origin.x = (SCREEN_SIZE.width - 213.5)/2;
    frame.origin.y = accountBg.frame.origin.y + accountBg.frame.size.height + 40;
    frame.size.width = 213.5;
    frame.size.height = 28.5;
    accountNameText =[[UITextField alloc] initWithFrame:frame];
    [accountNameText setBackground:[UIImage imageNamed:@"userNameBg"]];
    accountNameText.textAlignment = NSTextAlignmentCenter;
    [accountNameText setReturnKeyType:UIReturnKeyDone];
    // 设置垂直居中
    accountNameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    accountNameText.font = [UIFont systemFontOfSize:14.0f];
    accountNameText.placeholder = @"请输入邮箱/账号/昵称";
    accountNameText.autocorrectionType = UITextAutocorrectionTypeNo;    // 关闭自动语法错误提示
    accountNameText.autocapitalizationType = UITextAutocapitalizationTypeNone;    // 关闭自动大小写
    accountNameText.clearButtonMode = UITextFieldViewModeAlways;
    accountNameText.delegate = self;
    [self.view addSubview:accountNameText];
    
    // 默认用户名
    if([[NSUserDefaults standardUserDefaults] objectForKey:USERID])
        accountNameText.text = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    
    // pwdText
    frame.origin.y += accountNameText.frame.size.height + 15;
    pwdText =[[UITextField alloc] initWithFrame:frame];
    [pwdText setBackground:[UIImage imageNamed:@"passwdBg"]];
    pwdText.textAlignment = NSTextAlignmentCenter;
    pwdText.secureTextEntry = YES;
    [pwdText setReturnKeyType:UIReturnKeyDone];
    // 设置垂直居中
    pwdText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [pwdText setKeyboardType:UIKeyboardTypeAlphabet];
    pwdText.font = [UIFont systemFontOfSize:14.0f];
    pwdText.placeholder = @"请输入密码";
    pwdText.autocorrectionType = UITextAutocorrectionTypeNo;    // 关闭自动语法错误提示
    pwdText.autocapitalizationType = UITextAutocapitalizationTypeNone;    // 关闭自动大小写
    pwdText.clearButtonMode = UITextFieldViewModeAlways;
    pwdText.delegate = self;
    [self.view addSubview:pwdText];

    // autoLoginBtn
    frame.origin.x += 2;
    frame.origin.y += pwdText.frame.size.height + 10;
    frame.size.width = 25;
    frame.size.height = 25;
    autoLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    autoLoginBtn.frame = frame;
    [autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"showMore"] forState:UIControlStateNormal];
    [autoLoginBtn setBackgroundImage:[UIImage imageNamed:@"showMore_h"] forState:UIControlStateSelected];
    [autoLoginBtn addTarget:self action:@selector(autoLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:autoLoginBtn];

    // autoLoginLbl
    frame.origin.x += autoLoginBtn.frame.size.width + 10;
    frame.size.width = 85;
    frame.size.height = 25;
    UILabel *autoLoginLbl = [[UILabel alloc] initWithFrame:frame];
    autoLoginLbl.text = @"是否自动登录";
    autoLoginLbl.font = [UIFont systemFontOfSize:13.0f];
    autoLoginLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:autoLoginLbl];

    // loginBtn
    frame.origin.x = accountNameText.frame.origin.x;
    frame.origin.y += autoLoginBtn.frame.size.height + 10;
    frame.size.width = 213.5;
    frame.size.height = 29;
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = frame;
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtnBg"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    // 给button添加圆角和边框
//    [loginBtn.layer setCornerRadius:8.0f];
//    [loginBtn.layer setBorderWidth:1.0f];
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){1,1,1,1});
//    [loginBtn.layer setBorderColor:colorref];
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
    if([accountNameText.text isEqualToString:@""])
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
    
    [accountNameText resignFirstResponder];
    [pwdText resignFirstResponder];
    
    // 设置请求URL
    NSString *strRequestURL;
    if([accountNameText.placeholder isEqualToString:@"请输入邮箱/账号/昵称"])
    {
        // 正常登陆
        strRequestURL = [NSString stringWithFormat:@"%@?userID=%@&password=%@&tel=%@&rememberMe=%@&vCode=%@&machineKey=%@&type=%@",HTTPURL_LOGIN,accountNameText.text,pwdText.text,@"",isAutoLogin,@"",myCommon.m_strOpenUDID,@"0"];
    }
    else
    {
        // 手机验证登录
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
                     
                     // 获取用户菜单按钮权限
                     [self getUserPermission];
        
                 }
                 else if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 8)
                 {
                     UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你不在常用地区登录，请用手机验证码登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alt show];
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

// 获取用户菜单按钮权限
- (void)getUserPermission
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?UID=%@",HTTPURL_GETPERMISSION, [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"getUserPermission strRequestURL = %@",strRequestURL);
    
    __block NSDictionary *respDic;
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^
         {
             // 发送请求
             respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETPERMISSION threadType:1 strJsonContent:strRequestURL];
         }
          completionBlock:^
         {
             // 隐藏HUD
             [HUD removeFromSuperview];
             HUD = nil;
             if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
             {
                 NSMutableArray *localPermissionAry = [[NSMutableArray alloc] init];
                 NSMutableArray *module1 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0"]];
                 NSMutableArray *module2 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"0",@"0"]];
                 NSMutableArray *module3 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0"]];
                 NSMutableArray *module4 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"0"]];
                 NSMutableArray *module5 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"0"]];
                 NSMutableArray *module6 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"0"]];
                 NSMutableArray *module7 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0"]];
                 NSMutableArray *module8 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"0"]];
                 NSMutableArray *module9 = [[NSMutableArray alloc] initWithArray:@[@"0",@"0",@"0"]];
                 [localPermissionAry addObject:module1];
                 [localPermissionAry addObject:module2];
                 [localPermissionAry addObject:module3];
                 [localPermissionAry addObject:module4];
                 [localPermissionAry addObject:module5];
                 [localPermissionAry addObject:module6];
                 [localPermissionAry addObject:module7];
                 [localPermissionAry addObject:module8];
                 [localPermissionAry addObject:module9];
                 
                 NSArray *detailPermissionAry;
                 
                 for(int i = 0; i<[[respDic objectForKey:@"Data"] count]; i++)
                 {
                    detailPermissionAry = [[[respDic objectForKey:@"Data"] objectAtIndex:i] objectForKey:@"Actions"];
                    for(int j = 0; j < [detailPermissionAry count]; j++)
                    {
                        switch ([[[detailPermissionAry objectAtIndex:j] objectForKey:@"ActionCode"] intValue])
                        {
                            case 6010001:
                                localPermissionAry[0][0] = @"1";
                                break;
                            case 6010002:
                                localPermissionAry[0][1] = @"1";
                                break;
                            case 6020001:
                                localPermissionAry[1][0] = @"1";
                                break;
                            case 6020002:
                                localPermissionAry[1][1] = @"1";
                                break;
                            case 6020003:
                                localPermissionAry[1][2] = @"1";
                                break;
                            case 6020004:
                                localPermissionAry[1][3] = @"1";
                                break;
                            case 6030001:
                                localPermissionAry[2][0] = @"1";
                                break;
                            case 6030002:
                                localPermissionAry[2][1] = @"1";
                                break;
                            case 6040001:
                                localPermissionAry[3][0] = @"1";
                                break;
                            case 6040002:
                                localPermissionAry[3][1] = @"1";
                                break;
                            case 6040003:
                                localPermissionAry[3][2] = @"1";
                                break;
                            case 6050001:
                                localPermissionAry[4][0] = @"1";
                                break;
                            case 6050002:
                                localPermissionAry[4][1] = @"1";
                                break;
                            case 6050003:
                                localPermissionAry[4][2] = @"1";
                                break;
                            case 6060001:
                                localPermissionAry[5][0] = @"1";
                                break;
                            case 6060002:
                                localPermissionAry[5][1] = @"1";
                                break;
                            case 6060003:
                                localPermissionAry[5][2] = @"1";
                                break;
                            case 6070001:
                                localPermissionAry[6][0] = @"1";
                                break;
                            case 6070002:
                                localPermissionAry[6][1] = @"1";
                                break;
                            case 6080001:
                                localPermissionAry[7][0] = @"1";
                                break;
                            case 6080002:
                                localPermissionAry[7][1] = @"1";
                                break;
                            case 6080003:
                                localPermissionAry[7][2] = @"1";
                                break;
                            case 6090001:
                                localPermissionAry[8][0] = @"1";
                                break;
                            case 6090002:
                                localPermissionAry[8][1] = @"1";
                                break;
                            case 6090003:
                                localPermissionAry[8][2] = @"1";
                                break;
                                
                            default:
                                break;

                        }
                    }
                 }
                 
                 [[NSUserDefaults standardUserDefaults] setObject:localPermissionAry forKey:USERPERMISSIONARY];
                 myCommon.m_userPermissionAry = [[NSUserDefaults standardUserDefaults] objectForKey:USERPERMISSIONARY];
                 
                 // 进入主界面
                 MainBoardViewController *mainBoardViewController = [[MainBoardViewController alloc] init];
                 [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                 [self presentViewController:mainBoardViewController animated:YES completion:nil];
                 
//                 NSLog(@"myCommon.m_userPermissionAry = %@",myCommon.m_userPermissionAry);
             }
             else
             {
                 UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alt show];
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
    offset = 20 + frame.origin.y + frame.size.height + 60 - (self.view.frame.size.height - keyboardHeight) ;//键盘高度keyboardHeight
    if(SYSTEM_VERSION < 7.0f)
        offset = 20 + frame.origin.y + frame.size.height + 50 - (self.view.frame.size.height - keyboardHeight) ;//键盘高度keyboardHeight
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
