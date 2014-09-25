//
//  MainBoardViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "MainBoardViewController.h"


@interface MainBoardViewController ()

@end

@implementation MainBoardViewController

- (id)init
{
    self = [super init];
    if (self)
    {
//        self.title = @"数字物业云";
    }
    return self;
}

- (void)initData
{
    myLeenToast = [[LeenToast alloc] init];
    myCommon = [Common shared];
}

- (void)initView
{
//    self.tabBar.backgroundColor = [UIColor lightGrayColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    homePageViewController = [[HomePageViewController alloc] init];
    homePageViewController.tabBarItem.title = @"首页";
    homePageViewController.tabBarItem.image = [UIImage imageNamed:@"menu1"];
    homePageViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"menu1_selected"];
    homePageViewController.tabBarItem.tag = 1;
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
//    oaWorkViewController = [[OAWorkViewController alloc] init];
//    oaWorkViewController.tabBarItem.title = @"OA办公";
//    oaWorkViewController.tabBarItem.image = [UIImage imageNamed:@"menu2"];
//    oaWorkViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"menu2_selected"];
//    oaWorkViewController.tabBarItem.tag = 2;
//    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:oaWorkViewController];
    myAccountViewController = [[MyAccountViewController alloc] init];
    myAccountViewController.tabBarItem.title = @"我的账户";
    myAccountViewController.tabBarItem.image = [UIImage imageNamed:@"menu3"];
    myAccountViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"menu3_selected"];
    myAccountViewController.tabBarItem.tag = 3;
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:myAccountViewController];
    self.viewControllers = [NSArray arrayWithObjects:nav1,nav3, nil];
    
    // 添加左右滑动手势控制及通知
    
    leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftRecognizer];
    rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [rightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeGestureFunc) name:@"removeGestureRecognizer" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addGestureFunc) name:@"addGestureRecognizer" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    // 显示状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    
    [self initData];
    [self initView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTabBarFunc) name:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabBarFunc) name:@"showTabBarNotification" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 隐藏tabBar
- (void)hideTabBarFunc
{
    self.tabBar.hidden = YES;
}

// 显示tabBar
- (void)showTabBarFunc
{
    self.tabBar.hidden = NO;
}

// 手势控制操作
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self.view];
    
    // point.x越小越灵敏
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft && point.x > 235)
    {
        if(self.selectedIndex == 1)
        {
            self.selectedIndex = 0;
        }
        else
        {
//            if(self.selectedIndex == 0)
//            {
//                [myLeenToast settext:@"^_^，正在努力建设中..."];
//                [myLeenToast setDuration:1];
//                [myLeenToast show];
//            }
            self.selectedIndex = self.selectedIndex + 1;
        }
    }
    // point.x越大越灵敏
    else if(recognizer.direction==UISwipeGestureRecognizerDirectionRight && point.x < 135)
    {
        if(self.selectedIndex == 0)
        {
            self.selectedIndex = 1;
        }
        else
        {
//            if(self.selectedIndex == 2)
//            {
//                [myLeenToast settext:@"^_^，正在努力建设中..."];
//                [myLeenToast setDuration:1];
//                [myLeenToast show];
//            }
            self.selectedIndex = self.selectedIndex - 1;
        }
    }
}

// 移除手势
- (void)removeGestureFunc
{
    [self.view removeGestureRecognizer:leftRecognizer];
    [self.view removeGestureRecognizer:rightRecognizer];
}

// 添加手势
- (void)addGestureFunc
{
    [self.view addGestureRecognizer:leftRecognizer];
    [self.view addGestureRecognizer:rightRecognizer];
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag == 2)
    {
        [myLeenToast settext:@"^_^，正在努力建设中..."];
        [myLeenToast setDuration:1];
        [myLeenToast show];
    }
}

@end
