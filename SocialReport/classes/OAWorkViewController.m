//
//  OAWorkViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "OAWorkViewController.h"

@interface OAWorkViewController ()

@end

@implementation OAWorkViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"数字物业云(OA办公)";
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
    broadcastScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width * 5, frame.size.height);
    broadcastScrollView.delegate = self;
    [bgScrollView addSubview:broadcastScrollView];
    
    // pageControl
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(135, frame.size.height - 15, 50, 5);
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    [bgScrollView addSubview:pageControl];
    
    currentRegionLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 200.0f, 30.0f)];
    currentRegionLbl.text = [NSString stringWithFormat:@"位置：%@", [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME]];
    currentRegionLbl.font = [UIFont systemFontOfSize:13.0f];
    currentRegionLbl.textColor = [UIColor whiteColor];
    currentRegionLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:currentRegionLbl];
    
    UIImageView *bcImg1 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg1 setImage:[UIImage imageNamed:@"bcImg1"]];
    [broadcastScrollView addSubview:bcImg1];
    
    frame.origin.x = SCREEN_SIZE.width;
    UIImageView *bcImg2 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg2 setImage:[UIImage imageNamed:@"bcImg1"]];
    [broadcastScrollView addSubview:bcImg2];
    
    frame.origin.x = SCREEN_SIZE.width * 2;
    UIImageView *bcImg3 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg3 setImage:[UIImage imageNamed:@"bcImg1"]];
    [broadcastScrollView addSubview:bcImg3];
    
    frame.origin.x = SCREEN_SIZE.width * 3;
    UIImageView *bcImg4 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg4 setImage:[UIImage imageNamed:@"bcImg1"]];
    [broadcastScrollView addSubview:bcImg4];
    
    frame.origin.x = SCREEN_SIZE.width* 4;
    UIImageView *bcImg5 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg5 setImage:[UIImage imageNamed:@"bcImg1"]];
    [broadcastScrollView addSubview:bcImg5];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // 图片轮播动画
    timer =  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(broadcastingImg) userInfo:nil repeats:YES];
    
    currentRegionLbl.text = [NSString stringWithFormat:@"位置：%@", [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME]];
    
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
    if(broadcastScrollView.contentOffset.x < 4 * SCREEN_SIZE.width)
        [broadcastScrollView setContentOffset:CGPointMake(broadcastScrollView.contentOffset.x + SCREEN_SIZE.width, 0.0f)];
    else
        [broadcastScrollView setContentOffset:CGPointMake(0.0f, 0.0f)];
    [UIView commitAnimations];
}

#pragma mark UIScrollViewDelegate

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
    // 第四屏
    else if(broadcastScrollView.contentOffset.x == SCREEN_SIZE.width * 3)
    {
        pageControl.currentPage = 3;
    }
    // 第五屏
    else if(broadcastScrollView.contentOffset.x == SCREEN_SIZE.width * 4)
    {
        pageControl.currentPage = 4;
    }
}

@end
