//
//  PatrolViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-16.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"
#import "MJRefresh.h"
#import "AGPhotoBrowserView.h"


@interface PatrolViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, AGPhotoBrowserDelegate, AGPhotoBrowserDataSource>
{
    Common *myCommon;
    MBProgressHUD *HUD;
    CommunicationHttp *myCommunicationHttp;
    NSDictionary *respDic;        // 回复数据
    NSMutableArray *infoAry;      // 信息列表数组
    int pageIndex;        // 页码
    int flag;       // 标记使用何种排序方式
    
    UITableView *infoTableView;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    UIButton *showImageBtn;       // 显示大图按钮
}

@property (nonatomic, strong) AGPhotoBrowserView *browserView;

@end
