//
//  HomePageViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "HomePageViewController.h"
#import "ReportFuncViewController.h"
#import "ResidentDocViewController.h"
#import "ArrSearchViewController.h"
#import "PatrolViewController.h"
#import "FaultViewController.h"
#import "HygieneViewController.h"
#import "RentViewController.h"
#import "CheckInViewController.h"
#import "PublicReportViewController.h"
#import "TeneServiceViewController.h"
#import "ListRegionViewController.h"
#import "FaultReportViewController.h"
#import "SuggestReportViewController.h"


#define MARGIN_LEFT SCREEN_SIZE.width/4/4/2
#define MARGIN_TOP 25
#define PADDING_LEFT SCREEN_SIZE.width/4/4
#define PADDING_TOP 13
#define BTN_WIDTH SCREEN_SIZE.width/4/4*3
#define BTN_HEIGHT 90
#define BTNICON_WIDTH SCREEN_SIZE.width/4/4*3
#define BTNICON_HEIGHT 60
#define BTNLBL_WIDTH SCREEN_SIZE.width/4/4*3
#define BTNLBL_HEIGHT 30

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME];
    }
    return self;
}

- (void)initData
{
    myCommon = [Common shared];
    myLeenToast = [[LeenToast alloc] init];
}

- (void)initView
{
    CGRect frame = self.view.frame;
    
    // bgScrollView
    if(SYSTEM_VERSION < 7.0)
    {
        frame.origin.y = 0;
        frame.size.height -= self.navigationController.navigationBar.bounds.size.height + self.tabBarController.tabBar.bounds.size.height;
    }
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        bgScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width, (frame.size.height - SIGNLINE_HEIGHT - NAV_HEIGHT - TAB_HEIGHT) * 1);
    else
        bgScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width, frame.size.height * 1);
    [self.view addSubview:bgScrollView];
    
    if(SCREEN_SIZE.height >= 568.0f)
        frame.size.height = 130;
    else
        frame.size.height = 110;
    broadcastScrollView = [[UIScrollView alloc]initWithFrame:frame];
    broadcastScrollView.directionalLockEnabled = YES;
    broadcastScrollView.pagingEnabled = YES;
    broadcastScrollView.showsVerticalScrollIndicator = NO;
    broadcastScrollView.showsHorizontalScrollIndicator = NO;
    broadcastScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    broadcastScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width * 3, frame.size.height);
    broadcastScrollView.delegate = self;
    [bgScrollView addSubview:broadcastScrollView];
    
    // pageControl
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(145, frame.size.height - 15, 30, 5);
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    [bgScrollView addSubview:pageControl];
    
    UIImageView *bcImg1 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg1 setImage:[UIImage imageNamed:@"bcImg1"]];
    [broadcastScrollView addSubview:bcImg1];
    
    frame.origin.x = SCREEN_SIZE.width;
    UIImageView *bcImg2 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg2 setImage:[UIImage imageNamed:@"bcImg2"]];
    [broadcastScrollView addSubview:bcImg2];
    
    frame.origin.x = SCREEN_SIZE.width * 2;
    UIImageView *bcImg3 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg3 setImage:[UIImage imageNamed:@"bcImg3"]];
    [broadcastScrollView addSubview:bcImg3];
    
//    frame.origin.x = SCREEN_SIZE.width * 3;
//    UIImageView *bcImg4 = [[UIImageView alloc] initWithFrame:frame];
//    [bcImg4 setImage:[UIImage imageNamed:@"bcImg1"]];
//    [broadcastScrollView addSubview:bcImg4];
//    
//    frame.origin.x = SCREEN_SIZE.width* 4;
//    UIImageView *bcImg5 = [[UIImageView alloc] initWithFrame:frame];
//    [bcImg5 setImage:[UIImage imageNamed:@"bcImg1"]];
//    [broadcastScrollView addSubview:bcImg5];
    
    // 应用视图
    frame.origin.x = 0;
    frame.origin.y += frame.size.height;
    frame.size.width = SCREEN_SIZE.width;
    if(SYSTEM_VERSION >= 7.0)
        frame.size.height = bgScrollView.frame.size.height - frame.size.height - SIGNLINE_HEIGHT - NAV_HEIGHT - TAB_HEIGHT;
    else
        frame.size.height = bgScrollView.frame.size.height - frame.size.height;
    appScrollView = [[UIScrollView alloc]initWithFrame:frame];
    appScrollView.directionalLockEnabled = YES;
    appScrollView.pagingEnabled = NO;
    appScrollView.showsVerticalScrollIndicator = YES;
    appScrollView.showsHorizontalScrollIndicator = NO;
    appScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    if(SCREEN_SIZE.height >= 568.0f)
        appScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width, frame.size.height);
    else
        appScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width, frame.size.height*1.2);
    appScrollView.delegate = self;
    [bgScrollView addSubview:appScrollView];
    
    // 公告通知按钮
    frame.origin.x = MARGIN_LEFT;
    frame.origin.y = MARGIN_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reportBtn.frame = frame;
    reportBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [reportBtn addTarget:self action:@selector(reportFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[0][0] isEqualToString:@"1"])
    [appScrollView addSubview:reportBtn];
    
    // 添加图标
    UIImageView *icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"report"]];
    [reportBtn addSubview:icoImg];
    
    // 添加文字
    UILabel *icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"通知公告"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [reportBtn addSubview:icoLbl];
    
//    // 发布通知按钮
//    frame.origin.x = MARGIN_LEFT + BTN_WIDTH + PADDING_LEFT;
//    frame.origin.y = MARGIN_TOP;
//    frame.size.width = BTN_WIDTH;
//    frame.size.height = BTN_HEIGHT;
//    UIButton *publicReportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    publicReportBtn.frame = frame;
//    publicReportBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//    [publicReportBtn addTarget:self action:@selector(publicReportFunc) forControlEvents:UIControlEventTouchUpInside];
//    [appScrollView addSubview:publicReportBtn];
//    
//    // 添加图标
//    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
//    [icoImg setImage:[UIImage imageNamed:@"publicReport"]];
//    [publicReportBtn addSubview:icoImg];
//    
//    // 添加文字
//    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
//    [icoLbl setText:@"发布通知"];
//    icoLbl.textColor = [UIColor blackColor];
//    icoLbl.font = [UIFont systemFontOfSize:12.0f];
//    icoLbl.textAlignment = NSTextAlignmentCenter;
//    icoLbl.backgroundColor = [UIColor clearColor];
//    [publicReportBtn addSubview:icoLbl];
    
    // 欠费查询按钮
    frame.origin.x = MARGIN_LEFT + BTN_WIDTH + PADDING_LEFT;
    frame.origin.y = MARGIN_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *arrSeaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    arrSeaBtn.frame = frame;
    arrSeaBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [arrSeaBtn addTarget:self action:@selector(arrSeaFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[1][0] isEqualToString:@"1"])
    [appScrollView addSubview:arrSeaBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"arrSea"]];
    [arrSeaBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"欠费查询"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [arrSeaBtn addSubview:icoLbl];

    // 安防巡查按钮
    frame.origin.x = MARGIN_LEFT + BTN_WIDTH*2 + PADDING_LEFT*2;
    frame.origin.y = MARGIN_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *patrolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    patrolBtn.frame = frame;
    patrolBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [patrolBtn addTarget:self action:@selector(patrolFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[2][0] isEqualToString:@"1"])
    [appScrollView addSubview:patrolBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"patrol"]];
    [patrolBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"安防巡查"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [patrolBtn addSubview:icoLbl];
    
    // 故障申告按钮
    frame.origin.x = MARGIN_LEFT + BTN_WIDTH*3 + PADDING_LEFT*3;
    frame.origin.y = MARGIN_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *faultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faultBtn.frame = frame;
    faultBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [faultBtn addTarget:self action:@selector(faultFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[3][0] isEqualToString:@"1"])
    [appScrollView addSubview:faultBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"fault"]];
    [faultBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"故障申告"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [faultBtn addSubview:icoLbl];
    
    // 环境卫生按钮
    frame.origin.x = MARGIN_LEFT;
    frame.origin.y = MARGIN_TOP + BTN_HEIGHT + PADDING_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *hygieneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hygieneBtn.frame = frame;
    hygieneBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [hygieneBtn addTarget:self action:@selector(hygieneFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[4][0] isEqualToString:@"1"])
    [appScrollView addSubview:hygieneBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"hygiene"]];
    [hygieneBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"环境卫生"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [hygieneBtn addSubview:icoLbl];

//    // 出租出售按钮
//    frame.origin.x = MARGIN_LEFT + BTN_WIDTH*2 + PADDING_LEFT*2;
//    frame.origin.y = MARGIN_TOP + BTN_HEIGHT + PADDING_TOP;
//    frame.size.width = BTN_WIDTH;
//    frame.size.height = BTN_HEIGHT;
//    UIButton *rentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rentBtn.frame = frame;
//    rentBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//    [rentBtn addTarget:self action:@selector(rentFunc) forControlEvents:UIControlEventTouchUpInside];
//    [appScrollView addSubview:rentBtn];
//    
//    // 添加图标
//    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
//    [icoImg setImage:[UIImage imageNamed:@"rent"]];
//    [rentBtn addSubview:icoImg];
//    
//    // 添加文字
//    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
//    [icoLbl setText:@"出租出售"];
//    icoLbl.textColor = [UIColor blackColor];
//    icoLbl.font = [UIFont systemFontOfSize:12.0f];
//    icoLbl.textAlignment = NSTextAlignmentCenter;
//    icoLbl.backgroundColor = [UIColor clearColor];
//    [rentBtn addSubview:icoLbl];
//
//    // 访客登记按钮
//    frame.origin.x = MARGIN_LEFT + BTN_WIDTH*3 + PADDING_LEFT*3;
//    frame.origin.y = MARGIN_TOP + BTN_HEIGHT + PADDING_TOP;
//    frame.size.width = BTN_WIDTH;
//    frame.size.height = BTN_HEIGHT;
//    UIButton *checkInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    checkInBtn.frame = frame;
//    checkInBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//    [checkInBtn addTarget:self action:@selector(checkInFunc) forControlEvents:UIControlEventTouchUpInside];
//    [appScrollView addSubview:checkInBtn];
//    
//    // 添加图标
//    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
//    [icoImg setImage:[UIImage imageNamed:@"checkIn"]];
//    [checkInBtn addSubview:icoImg];
//    
//    // 添加文字
//    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
//    [icoLbl setText:@"访客登记"];
//    icoLbl.textColor = [UIColor blackColor];
//    icoLbl.font = [UIFont systemFontOfSize:12.0f];
//    icoLbl.textAlignment = NSTextAlignmentCenter;
//    icoLbl.backgroundColor = [UIColor clearColor];
//    [checkInBtn addSubview:icoLbl];
    
    // 用户档案按钮
    frame.origin.x = MARGIN_LEFT + BTN_WIDTH + PADDING_LEFT;
    frame.origin.y = MARGIN_TOP + BTN_HEIGHT + PADDING_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *residentDocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    residentDocBtn.frame = frame;
    residentDocBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [residentDocBtn addTarget:self action:@selector(residentDocFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[5][0] isEqualToString:@"1"])
    [appScrollView addSubview:residentDocBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"residentDoc"]];
    [residentDocBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"用户档案"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [residentDocBtn addSubview:icoLbl];
    
    // 故障处理按钮
    frame.origin.x = MARGIN_LEFT + BTN_WIDTH*2 + PADDING_LEFT*2;
    frame.origin.y = MARGIN_TOP + BTN_HEIGHT + PADDING_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *faultDecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faultDecBtn.frame = frame;
    faultDecBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [faultDecBtn addTarget:self action:@selector(faultDecFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[6][0] isEqualToString:@"1"])
    [appScrollView addSubview:faultDecBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"faultDecBtn"]];
    [faultDecBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"故障处理"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [faultDecBtn addSubview:icoLbl];
    
    // 意见反馈按钮
    frame.origin.x = MARGIN_LEFT + BTN_WIDTH*3 + PADDING_LEFT*3;
    frame.origin.y = MARGIN_TOP + BTN_HEIGHT + PADDING_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *suggestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    suggestBtn.frame = frame;
    suggestBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [suggestBtn addTarget:self action:@selector(suggestFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[7][0] isEqualToString:@"1"])
    [appScrollView addSubview:suggestBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"suggestBtn"]];
    [suggestBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"意见反馈"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [suggestBtn addSubview:icoLbl];
    
    // 物业信息按钮
    frame.origin.x = MARGIN_LEFT;
    frame.origin.y = MARGIN_TOP + BTN_HEIGHT*2 + PADDING_TOP*2;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *tenementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tenementBtn.frame = frame;
    tenementBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [tenementBtn addTarget:self action:@selector(tenementFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[8][0] isEqualToString:@"1"])
    [appScrollView addSubview:tenementBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"tenement"]];
    [tenementBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"物业客服"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [tenementBtn addSubview:icoLbl];

}

- (void)viewWillAppear:(BOOL)animated
{
    // 图片轮播动画
    timer =  [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(broadcastingImg) userInfo:nil repeats:YES];
    
    self.title = [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addGestureRecognizer" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initData];
    [self initView];
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME])
    {
        UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未选择小区，请先选择一个小区~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [myAlt show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 图片轮播动画
- (void)broadcastingImg
{
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"broadcastingImages" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(broadcastScrollView.contentOffset.x < 2 * SCREEN_SIZE.width)
        [broadcastScrollView setContentOffset:CGPointMake(broadcastScrollView.contentOffset.x + SCREEN_SIZE.width, 0.0f)];
    else
        [broadcastScrollView setContentOffset:CGPointMake(0.0f, 0.0f)];
    [UIView commitAnimations];
}

// 通知公告
- (void)reportFunc
{
    ReportFuncViewController *reportFuncViewController = [[ReportFuncViewController alloc] init];
    [self.navigationController pushViewController:reportFuncViewController animated:YES];
}

// 用户档案
- (void)residentDocFunc
{
    myCommon.m_buildingNo = nil;
    myCommon.m_buildingName = nil;
    myCommon.m_roomNo = nil;
    myCommon.m_clientNo = nil;
    myCommon.m_clientName = nil;
    
    ResidentDocViewController *residentDocSearchViewController = [[ResidentDocViewController alloc] init];
    [self.navigationController pushViewController:residentDocSearchViewController animated:YES];
}

// 欠费查询
- (void)arrSeaFunc
{
    myCommon.m_buildingNo = nil;
    myCommon.m_buildingName = nil;
    myCommon.m_roomNo = nil;
    
    ArrSearchViewController *arrSearchViewController = [[ArrSearchViewController alloc] init];
    [self.navigationController pushViewController:arrSearchViewController animated:YES];
}

// 安防巡查
- (void)patrolFunc
{
    PatrolViewController *patrolViewController = [[PatrolViewController alloc] init];
    [self.navigationController pushViewController:patrolViewController animated:YES];
}

// 故障申告
- (void)faultFunc
{
    FaultViewController *faultViewController = [[FaultViewController alloc] init];
    [self.navigationController pushViewController:faultViewController animated:YES];
}

// 环境卫生
- (void)hygieneFunc
{
    HygieneViewController *hygieneViewController = [[HygieneViewController alloc] init];
    [self.navigationController pushViewController:hygieneViewController animated:YES];
}

// 出租出售
- (void)rentFunc
{
    [myLeenToast settext:@"^_^，当前小区暂未开通此功能..."];
    [myLeenToast setDuration:1];
    [myLeenToast show];
//    RentViewController *rentViewController = [[RentViewController alloc] init];
//    [self.navigationController pushViewController:rentViewController animated:YES];
}

// 访客登记
- (void)checkInFunc
{
    [myLeenToast settext:@"^_^，当前小区暂未开通此功能..."];
    [myLeenToast setDuration:1];
    [myLeenToast show];
    //    CheckInViewController *checkInViewController = [[CheckInViewController alloc] init];
    //    [self.navigationController pushViewController:checkInViewController animated:YES];
}

// 发布通知
- (void)publicReportFunc
{
    PublicReportViewController *publicReportViewController = [[PublicReportViewController alloc] init];
    [self.navigationController pushViewController:publicReportViewController animated:YES];
}

// 物业信息
- (void)tenementFunc
{
    TeneServiceViewController *teneServiceViewController = [[TeneServiceViewController alloc] init];
    [self.navigationController pushViewController:teneServiceViewController animated:YES];
}

// 故障处理
- (void)faultDecFunc
{
    FaultReportViewController *faultReportViewController = [[FaultReportViewController alloc] init];
    [self.navigationController pushViewController:faultReportViewController animated:YES];
}

// 意见反馈
- (void)suggestFunc
{
    SuggestReportViewController *suggestReportViewController = [[SuggestReportViewController alloc] init];
    [self.navigationController pushViewController:suggestReportViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // 第一屏
    if(broadcastScrollView.contentOffset.x == 0)
    {
        pageControl.currentPage = 0;
    }
    // 第二屏
    else if(broadcastScrollView.contentOffset.x == SCREEN_SIZE.width)
    {
        pageControl.currentPage = 1;
    }
    // 第三屏
    else if(broadcastScrollView.contentOffset.x == SCREEN_SIZE.width * 2)
    {
        pageControl.currentPage = 2;
    }
//    // 第四屏
//    else if(broadcastScrollView.contentOffset.x == SCREEN_SIZE.width * 3)
//    {
//        pageControl.currentPage = 3;
//    }
//    // 第五屏
//    else if(broadcastScrollView.contentOffset.x == SCREEN_SIZE.width * 4)
//    {
//        pageControl.currentPage = 4;
//    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        ListRegionViewController *listRegionViewController = [[ListRegionViewController alloc] init];
        [self presentViewController:listRegionViewController animated:YES completion:nil];
    }
}

@end
