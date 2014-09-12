//
//  AboutSoftwareViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-11.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "AboutSoftwareViewController.h"
#import "UserProtocolViewController.h"

@interface AboutSoftwareViewController ()

@end

@implementation AboutSoftwareViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"关于物业云";
    }
    return self;
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"用户协议" style:UIBarButtonItemStylePlain target:self action:@selector(protocolFunc)];
    
    CGRect frame = self.view.frame;
    
    // bgScrollView
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        frame.origin.y = 0;
        frame.size.height -= self.navigationController.navigationBar.bounds.size.height;
    }
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height);
    [self.view addSubview:bgScrollView];
    
    frame.origin.x = 130;
    frame.origin.y = 5;
    frame.size.width = 60;
    frame.size.height = 60;
    UIImageView *icoImgView = [[UIImageView alloc] initWithFrame:frame];
    [icoImgView setImage:[UIImage imageNamed:@"icon-120"]];
    [bgScrollView addSubview:icoImgView];
    
    frame.origin.x = 0;
    frame.origin.y += icoImgView.frame.size.height + 10;
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = 100;
    UILabel *logoLbl = [[UILabel alloc] initWithFrame:frame];
    logoLbl.text =  [NSString stringWithFormat:@"数字物业云\nwww.pmsaas.net\n云平台助力企业迈向成功的彼岸\n版本：%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    logoLbl.font = [UIFont systemFontOfSize:15.0f];
    logoLbl.numberOfLines = 5;
    logoLbl.backgroundColor = [UIColor clearColor];
    logoLbl.textAlignment = NSTextAlignmentCenter;
    [bgScrollView addSubview:logoLbl];
    
    frame.origin.x = 16;
    frame.origin.y += logoLbl.frame.size.height;
    frame.size.width = 290;
    frame.size.height = 190;
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:frame];
    contentLbl.text = @"       数字物业云(www.pmsaas.net)成立于2010年。本软件是由领航互联公司自主开发，非经由本公司授权开发并正式发布的其它任何由本软件衍生的软件均属非法。\n       本软件适用于IOS6及以上版本，如果在其他的手机系统上使用本软件，对于出现的任何问题，领航互联不承担任何责任。本软件使用过程中产生的数据流量费用，由运营商收取。";
    contentLbl.font = [UIFont systemFontOfSize:13.0f];
    contentLbl.numberOfLines = 15;
    contentLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:contentLbl];
    
    frame.origin.y += contentLbl.frame.size.height;
    frame.size.height = 100;
    UILabel *copyrightLbl = [[UILabel alloc] initWithFrame:frame];
    copyrightLbl.text = @"网址:http://www.pmsaas.cn\n领航互联服务热线:0592-5807033\n厦门领航互联信息技术有限公司版权所有\nCopyright 2014 All Rights Reserved";
    copyrightLbl.font = [UIFont systemFontOfSize:12.0f];
    copyrightLbl.textAlignment = NSTextAlignmentCenter;
    copyrightLbl.numberOfLines = 5;
    copyrightLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:copyrightLbl];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backFunc
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)protocolFunc
{
    UserProtocolViewController *userProtocolViewController = [[UserProtocolViewController alloc] init];
    [self.navigationController pushViewController:userProtocolViewController animated:YES];
}

@end
