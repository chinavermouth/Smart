//
//  FaultReportViewController.h
//  PersonalSocialReport
//
//  Created by J.H on 14-6-20.
//  Copyright (c) 2014年 J.H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"
#import "AGPhotoBrowserView.h"


@interface FaultReportViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, UIAlertViewDelegate, AGPhotoBrowserDelegate, AGPhotoBrowserDataSource>
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    NSMutableArray *faultListData;
    CommunicationHttp *myCommunicationHttp;
    int pageIndex;
    Common *myCommon;
    
    UITableView *faultReportTable;
    UIButton *showImageBtn;       // 显示大图按钮
}

@property (nonatomic, strong) AGPhotoBrowserView *browserView;

@end
