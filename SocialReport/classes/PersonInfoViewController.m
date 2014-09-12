//
//  PersonInfoViewController.m
//  SocialReport
//
//  Created by J.H on 14-9-10.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "PersonInfoViewController.h"

@interface PersonInfoViewController ()

@end

@implementation PersonInfoViewController


- (id)initWithUserID:(NSString *) userId
{
    self = [super init];
    if (self)
    {
        _userID = userId;
        self.title = @"个人信息";
    }
    
    return self;
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.frame;
    
    // background scrollview
    frame.size.height += 50;
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height-50);
    [self.view addSubview:bgScrollView];
    
    frame.origin.x = (SCREEN_SIZE.width - 80)/2;
    frame.origin.y = 20;
    frame.size.width = 75;
    frame.size.height = 75;
    UIImageView *personImg = [[UIImageView alloc] initWithFrame:frame];
    [personImg setImage:[UIImage imageNamed:@"person"]];
    [bgScrollView addSubview:personImg];
    
    frame.origin.x = 30;
    frame.origin.y += personImg.frame.size.height + 30;
    frame.size.width = SCREEN_SIZE.width - 2*30;
    frame.size.height = 20;
    userNameLbl = [[UILabel alloc] initWithFrame:frame];
    userNameLbl.text = @"用户名：";
    userNameLbl.font = [UIFont systemFontOfSize:15.0f];
    userNameLbl.textColor = [UIColor blackColor];
    userNameLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:userNameLbl];
    
    frame.origin.y += userNameLbl.frame.size.height + 15;
    telephoneLbl = [[UILabel alloc] initWithFrame:frame];
    telephoneLbl.text = @"电话：";
    telephoneLbl.font = [UIFont systemFontOfSize:15.0f];
    telephoneLbl.textColor = [UIColor blackColor];
    telephoneLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:telephoneLbl];
    
    frame.origin.y += telephoneLbl.frame.size.height + 15;
    emailLbl = [[UILabel alloc] initWithFrame:frame];
    emailLbl.text = @"邮箱：";
    emailLbl.font = [UIFont systemFontOfSize:15.0f];
    emailLbl.textColor = [UIColor blackColor];
    emailLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:emailLbl];
}

- (void)initData
{
    myCommunicationHttp = [[CommunicationHttp alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initView];
    
    [self getUserInfo];
}

- (void)getUserInfo
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?userID=%@&UID=%@",HTTPURL_GETUSERINFO,_userID,[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    
    __block NSDictionary *respDic;
    __block MBProgressHUD *HUD;
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^
         {
             // 发送请求
             respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETUSERINFO threadType:1 strJsonContent:strRequestURL];
         }
          completionBlock:^
         {
             // 隐藏HUD
             [HUD removeFromSuperview];
             HUD = nil;
             if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
             {
                 userNameLbl.text = [NSString stringWithFormat:@"用户名：%@",[[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UserName"]];
                 telephoneLbl.text = [NSString stringWithFormat:@"电话：%@",[[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UserMob"]];
                 emailLbl.text = [NSString stringWithFormat:@"邮箱：%@",[[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Email"]];;
                 
             }
             else
             {
                 UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alt show];
             }
         }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
