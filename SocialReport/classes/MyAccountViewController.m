//
//  MyAccountViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "MyAccountViewController.h"
#import "LoginViewController.h"
#import "ListRegionViewController.h"
#import "AboutSoftwareViewController.h"

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


@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"数字物业云(我的账户)";
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
    broadcastScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width, frame.size.height);
    [bgScrollView addSubview:broadcastScrollView];
    
    UIImageView *bcImg1 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg1 setImage:[UIImage imageNamed:@"person_bg"]];
    [broadcastScrollView addSubview:bcImg1];
    
    frame.origin.x = 40;
    frame.origin.y = 20;
    frame.size.width = 55;
    frame.size.height = 55;
    UIButton *personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personBtn.frame = frame;
    [personBtn setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    [bgScrollView addSubview:personBtn];
    
    frame.origin.x += personBtn.frame.size.width + 20;
    frame.size.width = 120;
    frame.size.height = 30;
    UILabel *currentUserLbl = [[UILabel alloc] initWithFrame:frame];
    currentUserLbl.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USERNAME]];
    currentUserLbl.font = [UIFont systemFontOfSize:14.0f];
    currentUserLbl.textColor = [UIColor blackColor];
    currentUserLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:currentUserLbl];
    
    frame.origin.y += currentUserLbl.frame.size.height;
    frame.size.width = 150;
    currentRegionLbl = [[UILabel alloc] initWithFrame:frame];
    currentRegionLbl.text = [NSString stringWithFormat:@"位置：%@", [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME]];
    currentRegionLbl.font = [UIFont systemFontOfSize:13.0f];
    currentRegionLbl.textColor = [UIColor whiteColor];
    currentRegionLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:currentRegionLbl];
    
    frame.origin.y += currentRegionLbl.frame.size.height + 5;
    frame.size.width = 55;
    frame.size.height = 18;
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = frame;
    [exitBtn setTitle:@"安全退出" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    exitBtn.backgroundColor = [UIColor whiteColor];
    [exitBtn addTarget:self action:@selector(exitFunc) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:exitBtn];
    
    // 应用视图
    frame.origin.x = 0;
    frame.origin.y = broadcastScrollView.frame.origin.y + broadcastScrollView.frame.size.height;
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
    [bgScrollView addSubview:appScrollView];
    
    // 列出小区按钮
    frame.origin.x = MARGIN_LEFT;
    frame.origin.y = MARGIN_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *listRegionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    listRegionBtn.frame = frame;
    listRegionBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [listRegionBtn addTarget:self action:@selector(listRegionFunc) forControlEvents:UIControlEventTouchUpInside];
    [appScrollView addSubview:listRegionBtn];
    
    // 添加图标
    UIImageView *icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"listRegion"]];
    [listRegionBtn addSubview:icoImg];
    
    // 添加文字
    UILabel *icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"列出小区"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [listRegionBtn addSubview:icoLbl];
    
    // 版本更新按钮
    frame.origin.x = MARGIN_LEFT + BTN_WIDTH + PADDING_LEFT;
    frame.origin.y = MARGIN_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *checkVersonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkVersonBtn.frame = frame;
    checkVersonBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [checkVersonBtn addTarget:self action:@selector(checkVersonFunc) forControlEvents:UIControlEventTouchUpInside];
    [appScrollView addSubview:checkVersonBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"checkVerson"]];
    [checkVersonBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"版本更新"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [checkVersonBtn addSubview:icoLbl];

    // 关于物业云按钮
    frame.origin.x = MARGIN_LEFT + BTN_WIDTH*2 + PADDING_LEFT*2;
    frame.origin.y = MARGIN_TOP;
    frame.size.width = BTN_WIDTH;
    frame.size.height = BTN_HEIGHT;
    UIButton *aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutBtn.frame = frame;
    aboutBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [aboutBtn addTarget:self action:@selector(aboutFunc) forControlEvents:UIControlEventTouchUpInside];
    [appScrollView addSubview:aboutBtn];
    
    // 添加图标
    icoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BTNICON_WIDTH, BTNICON_HEIGHT)];
    [icoImg setImage:[UIImage imageNamed:@"about"]];
    [aboutBtn addSubview:icoImg];
    
    // 添加文字
    icoLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, BTNICON_HEIGHT, BTNLBL_WIDTH, BTNLBL_HEIGHT)];
    [icoLbl setText:@"关于物业云"];
    icoLbl.textColor = [UIColor blackColor];
    icoLbl.font = [UIFont systemFontOfSize:12.0f];
    icoLbl.textAlignment = NSTextAlignmentCenter;
    icoLbl.backgroundColor = [UIColor clearColor];
    [aboutBtn addSubview:icoLbl];

}

- (void)viewWillAppear:(BOOL)animated
{
    currentRegionLbl.text = [NSString stringWithFormat:@"位置：%@", [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addGestureRecognizer" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
//    [timer invalidate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//// 图片轮播动画
//- (void)broadcastingImg
//{
//    NSTimeInterval animationDuration = 0.3f;
//    [UIView beginAnimations:@"broadcastingImages" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    if(broadcastScrollView.contentOffset.x < 4 * SCREEN_SIZE.width)
//        [broadcastScrollView setContentOffset:CGPointMake(broadcastScrollView.contentOffset.x + SCREEN_SIZE.width, 0.0f)];
//    else
//        [broadcastScrollView setContentOffset:CGPointMake(0.0f, 0.0f)];
//    [UIView commitAnimations];
//}

- (void)exitFunc
{
    UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出数字物业云？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [myAlt show];
}

- (void)listRegionFunc
{
    ListRegionViewController *listRegionViewController = [[ListRegionViewController alloc] init];
    [self presentModalViewController:listRegionViewController animated:YES];
}

- (void)checkVersonFunc
{
    UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:nil message:@"恭喜您，当前是最新版本~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [myAlt show];
}

- (void)aboutFunc
{
    AboutSoftwareViewController *aboutSoftwareViewController = [[AboutSoftwareViewController alloc] init];
    [self.navigationController pushViewController:aboutSoftwareViewController animated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [self presentModalViewController:loginViewController animated:YES];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"isNotLogined" forKey:ISFIRSTLOGIN];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:COMDISPLAYNAME];
    }
}

@end
