//
//  ListRegionViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-25.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"
#import "MBProgressHUD.h"


@interface ListRegionViewController : UITableViewController <MBProgressHUDDelegate>
{
    NSDictionary *strRespString;        // 回复数据
    CommunicationHttp *myCommunicationHttp;
    NSMutableArray *regionAry;      // 小区列表数据
    Common *myCommon;
    MBProgressHUD *HUD;
}

@end
