//
//  MainBoardViewController.h
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeenToast.h"
#import "HomePageViewController.h"
#import "OAWorkViewController.h"
#import "MyAccountViewController.h"
#import "Common.h"


@interface MainBoardViewController : UITabBarController
{
    UISwipeGestureRecognizer *leftRecognizer;
    UISwipeGestureRecognizer *rightRecognizer;
    LeenToast *myLeenToast;
    Common *myCommon;
    
    HomePageViewController *homePageViewController;
    OAWorkViewController *oaWorkViewController;
    MyAccountViewController *myAccountViewController;
}

@end
