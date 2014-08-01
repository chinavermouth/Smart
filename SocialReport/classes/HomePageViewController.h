//
//  HomePageViewController.h
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "LeenToast.h"

@interface HomePageViewController : UIViewController <UIScrollViewDelegate, UIAlertViewDelegate>
{
    NSTimer *timer;
    Common *myCommon;
    LeenToast *myLeenToast;
    
    UIScrollView *bgScrollView;
    UIScrollView *broadcastScrollView;      // 轮播动画
    UIPageControl *pageControl;     // 分页控制器
    UIScrollView *appScrollView;        // 应用视图
    UILabel *currentRegionLbl;      // 当前小区
}

@end
