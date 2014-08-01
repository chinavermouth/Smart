//
//  ReportFuncViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-13.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"


@interface ReportFuncViewController : UITableViewController <MBProgressHUDDelegate>
{
    NSDictionary *respDic;        // 回复数据
    CommunicationHttp *myCommunicationHttp;
    Common *myCommon;
    NSString *subjectId;          // 主题ID
    NSMutableArray *reportAry;      // 通知公告列表数组
    MBProgressHUD *HUD;
    
    int pageIndex;        // 页码
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end
