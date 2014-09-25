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
                     // 保存令牌UID
                     [[NSUserDefaults standardUserDefaults] setValue:[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UID"] forKey:UID];
                     // 保存用户ID
                     [[NSUserDefaults standardUserDefaults] setValue:[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UserID"] forKey:USERID];
                     // 保存用户名
                     [[NSUserDefaults standardUserDefaults] setValue:[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UserName"] forKey:USERNAME];
                     // 租户号
                     [[NSUserDefaults standardUserDefaults] setValue:[[[strRespString objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"TenantCode"] forKey:TENANTCODE];
                     
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
//                 NSLog(@"myCommon.m_userPermissionAry = %@",myCommon.m_userPermissionAry);
                 
                 if([[[NSUserDefaults standardUserDefaults] valueForKey:ISFIRSTLOGIN] isEqualToString:@"isLogined"])
                 {
                     [myLeenToast settext:@"登录成功"];
                     [myLeenToast show];
                     
                     // 进入主界面
                     MainBoardViewController *mainBoardViewController = [[MainBoardViewController alloc] init];
                     [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                     [self presentViewController:mainBoardViewController animated:YES completion:nil];
                 }
                 else
                 {
                     // 弹出协议视图
                     [self alertProtocolView];
                 }
             }
             else
             {
                 UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alt show];
             }
         }];
    }

}

// 弹出协议视图
- (void)alertProtocolView
{
    // create custom view
    CGRect frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = 270;
    frame.size.height = 370;
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    
    frame.origin.x = 10;
    frame.origin.y = 10;
    frame.size.width = 250;
    frame.size.height = 20;
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:frame];
    titleLbl.text = @"用户协议";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = [UIFont systemFontOfSize:15.0f];
    titleLbl.textColor = [UIColor colorWithRed:29/255.0f green:123/255.0f blue:175/255.0f alpha:1.0f];
    titleLbl.backgroundColor = [UIColor clearColor];
    [containerView addSubview:titleLbl];
    
    frame.origin.y += titleLbl.frame.size.height + 10;
    frame.size.height = 320;
    UITextView *contentTView = [[UITextView alloc] initWithFrame:frame];
    contentTView.text = @"        本协议是数字物业云服务平台（包括数字物业云服务平台APP，以下单独或称为“本平台”）的经营者厦门领航互联信息技术有限公司（以下简称为“领航互联”），与用户（以下称为“您”），共同缔结的对双方具有约束力的契约。领航互联向您提供本平台上所展示的产品与服务（下称“数字物业云服务”、“本服务”），并将不断更新服务内容，最新的本平台上的相关产品及服务的以向用户实际提供的为准。\n1.   总则\n1.1 您确认：您在使用本平台服务之前，已经充分阅读、理解并接受本平台服务条款的全部内容，一旦您选择“同意”并使用本服务，即表示您同意遵循本平台服务条款之所有约定。\n1.2您同意：领航互联有权随时对本平台服务条款及相应的服务规则内容进行单方面的变更，并有权以消息推送、网页公告等方式予以公布，而无需另行单独通知您；若您在本平台服务条款内容公告变更后继续使用本平台服务的，表示您已充分阅读、理解并接受修改后的协议内容，也将遵循修改后的条款内容使用本服务；若您不同意修改后的服务条款，您应立即停止使用本服务。\n2.   账户\n2.1账户安全\n2.1.1您须自行负责对您的登录名和密码保密，且须对您在该登录名和密码下发生的所有活动（包括但不限于信息披露、发布信息、网上点击同意或提交各类规则协议、网上续签协议或购买服务等）承担责任。您同意：(a)如发现任何人未经授权使用您的登录名和密码，或发生违反保密规定的任何其他情况，您会立即通知本平台管理团队或领航互联；及(b)确保您在每个上网时段结束时，以正确步骤离开网站。领航互联不能也不会对因您未能遵守本款规定而发生的任何损失或损毁负责。您理解领航互联对您的请求采取行动需要合理时间，领航互联对在采取行动前已经产生的后果（包括但不限于您的任何损失）不承担任何责任。\n2.1.2. 除非有法律规定或司法裁定，且征得本平台的同意，否则，您的登录和密码限制为本人使用，不得以任何方式转让、赠与或继承（与账户相关的财产权益除外）。\n2.1.3. 您理解并同意，领航互联有权了解您使用本平台服务产品及服务的真实背景及目的，有权要求您如实提供真实、全面、准确的信息；如果领航互联有合理理由怀疑您提供的信息不真实、您进行虚假交易，或您的行为违反本平台的网站规则的，领航互联有权暂时或永久限制您账户下所使用的所有产品及/或服务的部分或全部功能。\n2.1.4. 您理解并同意，基于运行和交易安全的需要，领航互联有权暂时停止或者限制您账号下部分或全部的资金支付功能，领航互联将通过邮件、站内信、短信或电话等方式通知您，您应及时予以关注并按照程序进行申诉等后续操作。\n2.1.5. 您理解并同意，领航互联有权按照国家司法、行政、军事、安全等机关（包括但不限于公安机关、检察机关、法院、海关、税务机关、安全部门等）的要求对您的个人信息及在本平台服务的资金、交易及账户等进行查询、冻结或扣划。\n2.2 账户注销\n2.2.1. 领航互联保留在您违反国家、地方法律法规规定或违反本平台服务条款的情况下中止或终止为您提供服务的权利。\n2.2.2. 您保证注册的账户不应影响、损害或可能影响、损害本平台、领航互联及其关联公司的合法权益，前述影响或损害本平台、领航互联及其关联公司的合法权益的行为或方式包括但不限于：\n2.2.2.1. 违反本平台公布的任何服务协议/条款、管理规范、交易规则等规范内容；\n2.2.2.2. 破坏或试图破坏本平台公平交易环境或正常交易秩序；\n2.2.2.3. 任何使用含有本平台的名称和品牌且对他人有误导嫌疑或任何使用某种中英文(全称或简称)、数字、域名等意图表示或映射与本平台具有某种关系的；\n2.2.2.4. 领航互联根据自行合理判断，认为可能是与如上行为性质相同或产生如上类似风险的其他情况。 您认可领航互联有权在您违反上述约定时有权终止向您提供服务。\n3.   服务使用守则\n为有效保障您使用本服务的合法权益，您理解并同意接受以下规则：\n3.1 您通过包括但不限于以下方式向本平台发出的指令，均视为您本人的指令，不可撤回或撤销，您应自行对本平台执行前述指令所产生的任何结果承担责任。\n3.1.1. 通过您的登录名和密码进行的所有操作；\n3.1.2. 通过与您的账号绑定的手机号码向本平台发送的全部信息；\n3.1.3. 通过与您的账号绑定的其他硬件、终端、软件、代号、编码、代码、其他账户名等有形体或无形体向本平台发送的信息；\n3.1.4. 其他本平台与您约定或本平台认可的其他方式。\n3.2 您在使用本平台服务过程中，本平台服务条款内容、页面上出现的关于交易操作的提示或本平台发送到您手机的信息（短信或电话等）内容是您使用本平台服务的相关规则，您使用本平台服务即表示您同意接受本平台服务的相关规则。您了解并同意本平台有权单方修改服务的相关规则，而无须征得您的同意，服务规则应以您使用服务时的页面提示（或发送到该手机的短信或电话等）为准，您同意并遵照服务规则是您使用本平台服务的前提。\n3.3 本平台可能会以电子邮件（或发送到您手机的短信或电话等）方式通知您服务进展情况以及提示您进行下一步的操作，但本平台不保证您能够收到或者及时收到该邮件（或发送到该手机的短信或电话等），且不对此承担任何后果。因此，在服务过程中您应当及时登录到本服务查看和进行交易操作。因您没有及时查看和对服务状态进行修改或确认或未能提交相关申请而导致的任何纠纷或损失，本平台不负任何责任。\n3.4 您授权领航互联可以通过向第三方审核您的身份和资格，取得您使用本平台服务的相关资料。\n4.   您的权利和义务\n4.1 您有权利享受本平台提供的互联网技术和信息服务，并有权利在接受本平台提供的服务时获得本平台的技术支持、咨询等服务，服务内容详见本平台服务相关产品介绍。\n4.2 您保证不会利用技术或其他手段破坏或扰乱本平台服务及本平台其他客户。\n4.3 您应尊重本平台及其他第三方的知识产权和其他合法权利，并保证在发生侵犯上述权益的违法事件时尽力保护领航互联及其股东、雇员、合作伙伴等免于因该等事件受到影响或损失；领航互联保留您侵犯本平台合法权益时终止向您提供服务并不退还任何款项的权利。\n4.4 对由于您向领航互联提供的联络方式有误以及您用于接受本平台邮件的电子邮箱安全性、稳定性不佳而导致的一切后果，您应自行承担责任，包括但不限于因您未能及时收到本平台的相关通知而导致的后果和损失。\n4.5您保证：\n您使用本平台产品或服务时将遵从国家、地方法律法规、行业惯例和社会公共道德，不会利用本平台提供的服务进行存储、发布、传播如下信息和内容：\n4.5.1违反国家法律法规政策的任何内容（信息）；\n4.5.2违反国家规定的政治宣传和/或新闻信息；\n4.5.3涉及国家秘密和/或安全的信息；\n4.5.4封建迷信和/或淫秽、色情、下流的信息或教唆犯罪的信息；\n4.5.5博彩有奖、赌博游戏；\n4.5.6违反国家民族和宗教政策的信息；\n4.5.7妨碍互联网运行安全的信息；\n4.5.8侵害他人合法权益的信息和/或其他有损于社会秩序、社会治安、公共道德的信息或内容;\n4.5.9您同时承诺不得为他人发布上述不符合国家规定和/或本服务条款约定的信息内容提供任何便利，包括但不限于设置URL、BANNER链接等;\n用户违反本协议或相关的服务条款的规定，导致或产生的任何第三方主张的任何索赔、要求或损失，包括合理的律师费，您同意赔偿本平台与合作公司、关联公司，并使之免受损害。对此，领航互联有权视用户的行为性质，采取包括但不限于删除用户发布信息内容、暂停使用许可、终止服务、限制使用、回收帐号、追究法律责任等措施。对进行违法活动、捣乱、骚扰、欺骗、其他用户以及其他违反本协议的行为，本平台有权回收其帐号。同时，领航互联会视司法部门的要求，协助调查。\n5.   本平台的权利和义务\n5.1领航互联承诺对您资料采取对外保密措施，不向第三方披露您资料，不授权第三方使用您资料，除非依据本平台服务条款或者您与本平台之间其他服务协议、合同、在线条款等规定可以提供；\n5.2. 依据法律法规的规定应当提供；\n5.3. 行政、司法等职权部门要求本平台提供；\n5.4. 您同意本平台向第三方提供；\n5.5. 本平台解决举报事件、提起诉讼而提交的；\n5.6. 本平台为防止严重违法行为或涉嫌犯罪行为发生而采取必要合理行动所必须提交的；\n6.   隐私及其他个人信息的保护\n一旦您同意本平台服务条款或使用本服务，您即同意本平台按照以下条款来使用和披露您的个人信息。\n6.1 登录名和密码\n您仅可通过您设置的密码来使用该账户，如果您泄漏了密码，您可能会丢失您的个人识别信息，并可能导致对您不利的法律后果。该账户和密码因任何原因受到潜在或现实危险时，您应该立即和本平台取得联系，在领航互联采取行动前，领航互联对此不负任何责任。\n6.2 安全\n领航互联仅按现有技术提供相应的安全措施来使本平台掌握的信息不丢失，不被滥用和变造。这些安全措施包括向其他服务器备份数据和对用户密码加密。尽管有这些安全措施，但本平台不保证这些信息的绝对安全。\n7.   系统中断或故障\n系统可能因下列状况无法正常运作，使您无法使用各项互联网服务时，领航互联不承担损害赔偿责任，该状况包括但不限于：\n7.1 本平台在系统停机维护期间。\n7.2 电信设备出现故障不能进行数据传输的。\n7.3 因台风、地震、海啸、洪水、停电、战争、恐怖袭击等不可抗力之因素，造成本平台系统障碍不能执行业务的。\n7.4 由于黑客攻击、电信部门技术调整或故障、网站升级、银行方面的问题等原因而造成的服务中断或者延迟。\n8.   责任范围及责任限制\n8.1领航互联仅对本平台服务条款中列明的责任承担范围负责。\n8.2 本服务之合作单位，所提供之服务品质及内容由该合作单位自行负责。\n8.3 您了解并同意，因您使用本服务、违反本服务条款或在您的账户下采取的任何行动，而导致的任何第三方索赔，应且仅应由您本人承担。如果由此引起本平台、领航互联及其关联公司、员工、客户和合作伙伴被第三方索赔的，您应负责处理，并承担由此造成的全部责任。\n9.   通知送达\n9.1 您理解并同意，本平台可依据自行判断，通过网页公告、电子邮件、手机短信或常规的信件传送等方式向您发出通知，且本平台可以信赖您所提供的联系信息是完整、准确且当前有效的；上述通知于发送之日视为已送达收件人。\n9.2 除非本平台服务条款另有约定或领航互联与您另行签订的协议明确规定了通知方式，您发送给本平台的通知，应当通过本平台对外正式公布的通信地址、传真号码、电子邮件地址等联系信息进行送达。\n10. 法律适用与管辖\n本服务条款之效力、解释、变更、执行与争议解决均适用中华人民共和国法律。因本服务条款产生之争议，均应依照中华人民共和国法律予以处理。\n";
    contentTView.font = [UIFont systemFontOfSize:13.0f];
    contentTView.textColor = [UIColor blackColor];
    [containerView addSubview:contentTView];
    
    myAltView = [[CustomIOS7AlertView alloc] init];
    [myAltView setContainerView:containerView];
    [myAltView setButtonTitles:@[@"同意",@"不同意"]];
    [myAltView setUseMotionEffects:true];
    [myAltView setDelegate:self];
    [myAltView show];
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

#pragma mark - CustomIOS7AlertViewDelegate

- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        exit(0);
    }
    else
    {
        [myAltView close];
        
        // 设置已登录过标志
        [[NSUserDefaults standardUserDefaults] setValue:@"isLogined" forKey:ISFIRSTLOGIN];
        
        [myLeenToast settext:@"登录成功"];
        [myLeenToast show];
        // 进入主界面
        MainBoardViewController *mainBoardViewController = [[MainBoardViewController alloc] init];
        [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:mainBoardViewController animated:YES completion:nil];
    }
}

@end
