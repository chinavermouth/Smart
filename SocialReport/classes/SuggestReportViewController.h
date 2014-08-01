//
//  SuggestReportViewController.h
//  SocialReport
//
//  Created by J.H on 14-7-1.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"

@interface SuggestReportViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, UIAlertViewDelegate>
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    NSMutableArray *faultListData;
    CommunicationHttp *myCommunicationHttp;
    int pageIndex;
    Common *myCommon;
    
    UITableView *faultReportTable;
}
@end
