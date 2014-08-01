//
//  NightPatrolViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "Common.h"

@interface NightPatrolViewController : UIViewController <ZBarReaderViewDelegate>
{
    NSTimer *timer;     //每隔几秒启动计时器
    
    UITextField *twoDimCodeText;
    ZBarReaderView *myReaderView;
    UILabel *moveLine;
}

@end
