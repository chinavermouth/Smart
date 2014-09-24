//
//  FaultReportDetailViewController.h
//  PersonalSocialReport
//
//  Created by J.H on 14-6-23.
//  Copyright (c) 2014年 J.H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MBProgressHUD.h"
#import "LeenToast.h"
#import "CommunicationHttp.h"
#import "JSON.h"
#import "MJRefresh.h"
#import "AGPhotoBrowserView.h"
#import "ToolDrawerView.h"


@interface FaultReportDetailViewController : UIViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, AGPhotoBrowserDelegate, AGPhotoBrowserDataSource, UIGestureRecognizerDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>
{
    UIScrollView  *mainScrollView;
    LeenToast *myLeenToast;
    CommunicationHttp *myCommunicationHttp;
    int keyboardHeight;     //键盘高度
    int pageIndex;        // 页码
    BOOL commentFlag;     // 评论标记
    Common *myCommon;
    NSMutableArray *infoAry;
    NSDictionary *respDic;
    NSMutableArray *imgAry;  // 存储图片数组，用于浏览
    ToolDrawerView *myToolBarDrawerView;
    NSString *phoneNum;
    
    UILabel *titleLbl;       // 标题
    UILabel *authorLbl;      // 作者
    UILabel *timeLbl;        // 发布时间
    UILabel *newTimeLbl;     // 更新时间
    UILabel *contactLbl;     // 联系人
    UILabel *phoneLabel;     // 手机号码
    UILabel *addressLbl;     // 地址
    UILabel *emailLbl;       // email邮箱
    UILabel *qqLbl;          // QQ号码
    UILabel *statusLbl;      // 状态(正在处理、已处理)
    UIButton *callBtn;
    UIButton *messageBtn;
    UIButton *emailBtn;
    UIButton *commentListBtn;
    UITableView *commentTableView;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    UIPageControl *pageControl;
    UIButton *cellImgBtn;
    UIButton *showImageBtn;       // 显示大图按钮
}

@property (nonatomic, strong) AGPhotoBrowserView *browserView;

@end
