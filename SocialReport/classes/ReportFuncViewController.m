//
//  ReportFuncViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-13.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ReportFuncViewController.h"
#import "ReportDetailViewController.h"
#import "PublicReportViewController.h"
#import "ReportListCell.h"

NSString *const CellIdentifier = @"cellIdentifier";


@interface ReportFuncViewController ()

@end

@implementation ReportFuncViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.title = @"公告通知";
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;    // 取消tableviewcell分割线
        return self;
    }
    return self;
}

- (void)initData
{
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    myCommon = [Common shared];
    
    reportAry = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 首页" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    if([myCommon.m_userPermissionAry[0][1] isEqualToString:@"1"])
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        [self listReports];
        [self addHeader];
        [self addFooter];
    });
    
    UIImageView *headViewImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reportFunc"]];
    headViewImg.frame = CGRectMake(0, 0, 320, 200);
    self.tableView.tableHeaderView = headViewImg;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backFunc
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 发布新通知公告
- (void)addNew
{
    PublicReportViewController *publicReportViewController = [[PublicReportViewController alloc] init];
    [self.navigationController pushViewController:publicReportViewController animated:YES];
}

- (void)listReports
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityCode=%@&type=0&pageIndex=%@&pageSize=10&UID=%@",HTTPURL_LISTREPORT,[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYCODE], [NSString stringWithFormat:@"%d",pageIndex++], [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    NSLog(@"strRequestURL = %@",strRequestURL);
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送请求
            respDic = [myCommunicationHttp sendHttpRequest:HTTP_LISTREPORT threadType:1 strJsonContent:strRequestURL];
            
        } completionBlock:^{
            // 隐藏HUD
            [HUD removeFromSuperview];
            HUD = nil;
            
            if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
            {
                for (NSDictionary *tempDic in [respDic objectForKey:@"Data"])
                {
                    [reportAry addObject:tempDic];
                }
            }
            
            if([reportAry count] == 0)
            {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该小区没有通知公告信息 !" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
            }
            else
            {
                [self.tableView reloadData];
            }
        }];
    }
}

// 上拉刷新
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 增加数据
        [self listReports];
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
    
    _footer = footer;
}

// 下拉刷新
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        reportAry = [[NSMutableArray alloc] init];
        pageIndex = 0;
        
        // 增加数据
        [self listReports];
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
//    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
//        // 刷新完毕就会回调这个Block
//        NSLog(@"%@----刷新完毕", refreshView.class);
//    };
//    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
//        // 控件的刷新状态切换了就会调用这个block
//        switch (state) {
//            case MJRefreshStateNormal:
//                NSLog(@"%@----切换到：普通状态", refreshView.class);
//                break;
//                
//            case MJRefreshStatePulling:
//                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
//                break;
//                
//            case MJRefreshStateRefreshing:
//                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
//                break;
//            default:
//                break;
//        }
//    };
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [reportAry count];
}

// 设置单元格cell高
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [ReportListCell getCellHeight];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ReportListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.titleLbl.text = [NSString stringWithFormat:@"%@", [[reportAry objectAtIndex:indexPath.row] valueForKey:@"Title"]];
    cell.timeLbl.text = [NSString stringWithFormat:@"%@", [[reportAry objectAtIndex:indexPath.row] valueForKey:@"IssuesTime"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 保存主题ID
    subjectId = [[reportAry objectAtIndex:indexPath.row] valueForKey:@"ID"];
    
    ReportDetailViewController *reportDetailViewController = [[ReportDetailViewController alloc] initWithSubjectId:subjectId];
    [self.navigationController pushViewController:reportDetailViewController animated:YES];
}


#pragma mark MBProgressHUD methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    HUD = nil;
}


@end
