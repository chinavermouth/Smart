//
//  SuggestReportViewController.m
//  SocialReport
//
//  Created by J.H on 14-7-1.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "SuggestReportViewController.h"
#import "InfoListCell2.h"
#import "LoginViewController.h"
#import "SuggestReportDetailViewController.h"

NSString *const suggestReportCellIdentifier = @"suggestReportCellIdentifier";


@interface SuggestReportViewController ()

@end

@implementation SuggestReportViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"意见反馈";
    }
    return self;
}

- (void)initData
{
    pageIndex = 0;
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    faultListData = [[NSMutableArray alloc] init];
    myCommon = [Common shared];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 首页" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    CGRect frame;
    
    // faultReportTable
    frame.origin.x = 0;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        frame.origin.y = 0;
    else
        frame.origin.y = 0;
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = SCREEN_SIZE.height - frame.origin.y;
    faultReportTable = [[UITableView alloc]initWithFrame:frame];
    faultReportTable.delegate = self;
    faultReportTable.dataSource = self;
    [self.view addSubview:faultReportTable];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
    
    pageIndex = 0;
    faultListData = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getReportInfo];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initData];
    [self initView];
    
    [faultReportTable registerClass:[UITableViewCell class] forCellReuseIdentifier:suggestReportCellIdentifier];
    [self addHeader];
    [self addFooter];
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

// 获取故障申告列表
- (void)getReportInfo
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityCode=%@&Type=%@&Index=1&pageIndex=%d&pageSize=7&UID=%@", HTTPURL_GETFEEDBACKS, [[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYCODE],@"咨询建议", pageIndex++, [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    NSLog(@"getReportInfo strRequestURL = %@",strRequestURL);
    
    __block NSMutableDictionary *dicRespData;
    
    __block MBProgressHUD *HUD;
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^
         {
             // 发送请求
             dicRespData = [[NSMutableDictionary alloc] initWithDictionary:[myCommunicationHttp sendHttpRequest:HTTP_GETFEEDBACKS threadType:1 strJsonContent:strRequestURL]];
             
         } completionBlock:^{
             // 隐藏HUD
             [HUD removeFromSuperview];
             HUD = nil;
             if([dicRespData objectForKey:@"Info"])
             {
                 if([[[dicRespData objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
                 {
                     for (NSDictionary *tempDic in [dicRespData objectForKey:@"Data"])
                     {
                         [faultListData addObject:tempDic];
                     }
                     if([faultListData count] == 0)
                     {
                         UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未发布意见反馈，请点击发布~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                         [myAlt show];
                     }
                     [faultReportTable reloadData];
                 }
                 else if([[[dicRespData objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 3)
                 {
                     UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:nil message:@"登录超时，请重新登录~" delegate:self cancelButtonTitle:@"我再逛逛~" otherButtonTitles:@"登录", nil];
                     [myAlt show];
                     return ;
                 }
                 else
                 {
                     UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:nil message:@"登录超时，请重新登录~" delegate:self cancelButtonTitle:@"我再逛逛~" otherButtonTitles:@"登录", nil];
                     [myAlt show];
                     return ;
                 }
             }
             else
             {
                 UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:nil message:@"网络有问题哦，请检查网络~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [myAlt show];
                 return ;
             }
         }];
    }
    
}

// 上拉刷新
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = faultReportTable;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 增加数据
        [self getReportInfo];
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
    
    _footer = footer;
}

// 下拉刷新
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = faultReportTable;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        pageIndex = 0;
        faultListData = [[NSMutableArray alloc] init];
        
        // 增加数据
        [self getReportInfo];
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
    
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [faultReportTable reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}


#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return InfoListCell2.getCellHeight - 3*4 - 67.5 - 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [faultListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    InfoListCell2 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[InfoListCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    cell.topLbl.text = [NSString stringWithFormat:@"%@", [[faultListData objectAtIndex:indexPath.row] objectForKey:@"Content"]];
    cell.middleLbl.text = [NSString stringWithFormat:@"发布于:%@", [[faultListData objectAtIndex:indexPath.row] objectForKey:@"WriteTime"]];
    cell.bottomLbl1.text = [NSString stringWithFormat:@"更新于:%@", [[faultListData objectAtIndex:indexPath.row] objectForKey:@"LastUpdated"]];
    cell.bottomLbl2.text = [NSString stringWithFormat:@"状态:%@", [[faultListData objectAtIndex:indexPath.row] objectForKey:@"Status"]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myCommon.m_reportId = [[faultListData objectAtIndex:indexPath.row] objectForKey:@"ID"];
    myCommon.m_reportTitle = [[faultListData objectAtIndex:indexPath.row] objectForKey:@"Title"];
    myCommon.m_reportStatus = [[faultListData objectAtIndex:indexPath.row] objectForKey:@"Status"];
    
    SuggestReportDetailViewController *suggestReportDetailViewController = [[SuggestReportDetailViewController alloc] init];
    [self.navigationController pushViewController:suggestReportDetailViewController animated:YES];
}

#pragma mark - MBProgressHUD methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else if(buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
