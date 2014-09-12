//
//  SuggestReportDetailViewController.m
//  SocialReport
//
//  Created by J.H on 14-7-1.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "SuggestReportDetailViewController.h"
#import "ReportPublishViewController.h"
#import "InfoDetailListCell.h"
#import "LoginViewController.h"

#define MARGIN_LEFT 22
#define MARGIN_TOP  10

NSString *const suggestReportDetailViewController = @"suggestReportDetailViewController";


@interface SuggestReportDetailViewController ()

@end

@implementation SuggestReportDetailViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"意见反馈详细";
    }
    
    return self;
}

- (void)initData
{
    commentFlag = NO;
    myCommon = [Common shared];
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    infoAry = [[NSMutableArray alloc] init];
    imgAry = [[NSMutableArray alloc] init];
    
    // pageControl
    pageControl = [[UIPageControl alloc] init];
    pageControl.currentPage = 0;
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回列表" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBarBtn.frame = CGRectMake(0.0f, 0.0f, 70.0f, 30.0f);
    [rightBarBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    rightBarBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    rightBarBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    rightBarBtn.backgroundColor = [UIColor clearColor];
    [rightBarBtn addTarget:self action:@selector(publishCommFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[8][2] isEqualToString:@"1"])
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    
    CGRect frame = self.view.frame;
    
    // bgScrollView
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        frame.origin.y = 0;
        frame.size.height -= self.navigationController.navigationBar.bounds.size.height + 0;
    }
    mainScrollView = [[UIScrollView alloc]initWithFrame:frame];
    mainScrollView.directionalLockEnabled = YES;
    mainScrollView.pagingEnabled = NO;
    mainScrollView.showsVerticalScrollIndicator = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    //    mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    mainScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width, frame.size.height - 64 - 49);
    [self.view addSubview:mainScrollView];
    
    frame.origin.x = MARGIN_LEFT;
    frame.origin.y = MARGIN_TOP;
    if(SYSTEM_VERSION < 7.0)
        frame.origin.y = MARGIN_TOP;
    frame.size.width = SCREEN_SIZE.width - 2 * MARGIN_LEFT;
    frame.size.height = 60;
    titleLbl = [[UILabel alloc] initWithFrame:frame];
    titleLbl.text = [NSString stringWithFormat:@"标题：%@",@""];
    titleLbl.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    titleLbl.numberOfLines = 0;
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:titleLbl];
    
    // 作者
    frame.origin.y += titleLbl.frame.size.height;
    frame.size.width = 220;
    frame.size.height = 40;
    if(SCREEN_SIZE.height < 568.0f)
        frame.size.height = 30;
    authorLbl = [[UILabel alloc] initWithFrame:frame];
    authorLbl.text = [NSString stringWithFormat:@"作者：%@",@""];
    authorLbl.textAlignment = NSTextAlignmentLeft;
    authorLbl.font = [UIFont systemFontOfSize:14.0f];
    authorLbl.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:authorLbl];
    
    // 发布时间
    frame.origin.y += authorLbl.frame.size.height;
    timeLbl = [[UILabel alloc] initWithFrame:frame];
    timeLbl.text = @"发布时间：";
    timeLbl.font = [UIFont systemFontOfSize:14.0f];
    timeLbl.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:timeLbl];
    
    // 联系人
    frame.origin.y += timeLbl.frame.size.height;
    contactLbl = [[UILabel alloc] initWithFrame:frame];
    contactLbl.text = [NSString stringWithFormat:@"联系人：%@",@""];
    contactLbl.font = [UIFont systemFontOfSize:14.0f];
    contactLbl.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:contactLbl];
    
    // 手机号码
    frame.origin.y += contactLbl.frame.size.height;
    phoneLabel = [[UILabel alloc] initWithFrame:frame];
    phoneLabel.text = [NSString stringWithFormat:@"手机号码：%@",@""];
    phoneLabel.font = [UIFont systemFontOfSize:14.0f];
    phoneLabel.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:phoneLabel];
    
    // 地址
    frame.origin.y += phoneLabel.frame.size.height;
    addressLbl = [[UILabel alloc] initWithFrame:frame];
    addressLbl.text = [NSString stringWithFormat:@"地址：%@",@""];
    addressLbl.font = [UIFont systemFontOfSize:14.0f];
    addressLbl.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:addressLbl];
    
    // email邮箱
    frame.origin.y += addressLbl.frame.size.height;
    emailLbl = [[UILabel alloc] initWithFrame:frame];
    emailLbl.text = [NSString stringWithFormat:@"邮箱：%@",@""];
    emailLbl.font = [UIFont systemFontOfSize:14.0f];
    emailLbl.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:emailLbl];
    
    // QQ号码
    frame.origin.y += emailLbl.frame.size.height;
    qqLbl = [[UILabel alloc] initWithFrame:frame];
    qqLbl.text = [NSString stringWithFormat:@"QQ号码：%@",@""];
    qqLbl.font = [UIFont systemFontOfSize:14.0f];
    qqLbl.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:qqLbl];
    
    // 状态
    frame.origin.y += qqLbl.frame.size.height;
    statusLbl = [[UILabel alloc] initWithFrame:frame];
    statusLbl.text = [NSString stringWithFormat:@"状态：%@",@""];
    statusLbl.font = [UIFont systemFontOfSize:14.0f];
    statusLbl.textColor = [UIColor redColor];
    statusLbl.backgroundColor = [UIColor clearColor];
    [mainScrollView addSubview:statusLbl];
    
    if(SYSTEM_VERSION >= 7.0)
        frame.origin.y += statusLbl.frame.size.height + 45;
    else
        frame.origin.y += statusLbl.frame.size.height + 30;
    frame.size.width = 90;
    frame.size.height = 40;
    commentListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentListBtn.frame = frame;
    [commentListBtn setTitle:@"查看咨询详细" forState:UIControlStateNormal];
    [commentListBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    commentListBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [commentListBtn addTarget:self action:@selector(reportDetailFunc) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:commentListBtn];
    
    frame.origin.y += commentListBtn.frame.size.height + 20;
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = 290 + 64 + 49;
    commentTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    commentTableView.dataSource = self;
    commentTableView.delegate = self;
    [mainScrollView addSubview:commentTableView];
    
    // 添加底部工具按钮
    frame.origin.x = 0;
    if(SYSTEM_VERSION >= 7.0)
        frame.origin.y = SCREEN_SIZE.height - 40;
    else
        frame.origin.y = SCREEN_SIZE.height-64 - 20;
    frame.size.width = (SCREEN_SIZE.width - 2*0)/3;
    frame.size.height = 40;
    callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    callBtn.frame = frame;
    [callBtn setTitle:@"打电话" forState:UIControlStateNormal];
    [callBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    callBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [callBtn addTarget:self action:@selector(callBtnFunc) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:callBtn];
    
    frame.origin.x += callBtn.frame.size.width;
    messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = frame;
    [messageBtn setTitle:@"发短信" forState:UIControlStateNormal];
    [messageBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    messageBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [messageBtn addTarget:self action:@selector(messageBtnFunc) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:messageBtn];
    
    frame.origin.x += messageBtn.frame.size.width;
    emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    emailBtn.frame = frame;
    [emailBtn setTitle:@"发邮件" forState:UIControlStateNormal];
    [emailBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    emailBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [emailBtn addTarget:self action:@selector(emailBtnFunc) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:emailBtn];
    
    // 拨打业主电话
    myToolBarDrawerView = [[ToolDrawerView alloc]initInVerticalCorner:kBottomCorner
                                                  andHorizontalCorner:kRightCorner
                                                               moving:kHorizontally];
    
    UIButton *button;
	button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tenePhone"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(telFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[8][1] isEqualToString:@"1"])
	[myToolBarDrawerView appendButton:button];
    
    [self.view addSubview:myToolBarDrawerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    pageIndex = 0;
    infoAry = [[NSMutableArray alloc] init];
    if([commentListBtn.titleLabel.text isEqualToString:@"点击返回内容"])
        [commentListBtn setTitle:@"查看咨询详细" forState:UIControlStateNormal];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 增加数据
        [self getInfoDetailFunc];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initData];
    [self initView];
    
    [commentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:suggestReportDetailViewController];
    [self addHeader];
    [self addFooter];
}

// 拨打业主电话
- (void)telFunc
{
    [myToolBarDrawerView close];
    
    NSString *phoneNum =[ NSString stringWithFormat:@"%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Tel"]];
    if(![phoneNum isEqualToString:@"<null>"]&&![phoneNum isEqualToString:@"null"])
    {
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSString *telUrl = [NSString stringWithFormat:@"tel:%@",phoneNum];
        NSURL *telURL =[NSURL URLWithString:telUrl];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebview];
    }
}

- (void)getInfoDetailFunc
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?id=%@&Index=1&pageIndex=%d&pageSize=5&UID=%@", HTTPURL_GETFEEDBACKDETAILS, myCommon.m_reportId, pageIndex++, [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    NSLog(@"strRequestURL = %@",strRequestURL);
    
    __block MBProgressHUD *HUD;
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送登录请求
            respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETFEEDBACKDETAILS threadType:1 strJsonContent:strRequestURL];
            
        } completionBlock:^{
            // 隐藏HUD
            [HUD removeFromSuperview];
            HUD = nil;
            
            if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
            {
                if([[respDic objectForKey:@"Data"] count] == 0)
                {
                    return ;
                }
                
                titleLbl.text = [NSString stringWithFormat:@"标题：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Title"]];
                authorLbl.text = [NSString stringWithFormat:@"作者：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"UserName"]];
                if([timeLbl.text isEqualToString:@"发布时间："])
                    timeLbl.text = [NSString stringWithFormat:@"发布时间：%@", [[[[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Details"] objectAtIndex:0] objectForKey:@"WriteTime"]];
                contactLbl.text = [NSString stringWithFormat:@"联系人：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Linkman"]];
                phoneLabel.text = [NSString stringWithFormat:@"手机号码：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Tel"]];
                addressLbl.text = [NSString stringWithFormat:@"地址：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Address"]];
                emailLbl.text = [NSString stringWithFormat:@"email邮箱：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Email"]];
                qqLbl.text = [NSString stringWithFormat:@"qq号码：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"QQ"]];
                statusLbl.text = [NSString stringWithFormat:@"状态：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Status"]];
                
                // 添加数据
                for (NSDictionary *tempDic in [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Details"])
                {
                    [infoAry addObject:tempDic];
                }
                
                [commentTableView reloadData];
            }
            else if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 3)
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
        }];
    }
    
}

// 上拉刷新
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = commentTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 增加数据
        [self getInfoDetailFunc];
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
    
    _footer = footer;
}

// 下拉刷新
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = commentTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        pageIndex = 0;
        infoAry = [[NSMutableArray alloc] init];
        
        // 增加数据
        [self getInfoDetailFunc];
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
    
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [commentTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
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

// 发表评论
- (void)publishCommFunc
{
    ReportPublishViewController *reportPublishViewController = [[ReportPublishViewController alloc] init];
    [self.navigationController pushViewController:reportPublishViewController animated:YES];
}

- (void)callBtnFunc
{}

- (void)messageBtnFunc
{}

- (void)emailBtnFunc
{}

// 查看故障申告详细
- (void)reportDetailFunc
{
    if(!commentFlag)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        
        if(SYSTEM_VERSION >= 7.0)
            if(SCREEN_SIZE.height >= 568)
                [mainScrollView setContentOffset:CGPointMake(0.0f, 295+64)];
            else
                [mainScrollView setContentOffset:CGPointMake(0.0f, 295)];
            else
                if(SCREEN_SIZE.height >= 568)
                    [mainScrollView setContentOffset:CGPointMake(0.0f, 295+64+40)];
                else
                    [mainScrollView setContentOffset:CGPointMake(0.0f, 295+40)];
        
        [UIView commitAnimations];
        
        [commentListBtn setTitle:@"点击返回内容" forState:UIControlStateNormal];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        
        if(SYSTEM_VERSION >= 7.0)
            if(SCREEN_SIZE.height >= 568)
                [mainScrollView setContentOffset:CGPointMake(0.0f, -64.0f)];
            else
                [mainScrollView setContentOffset:CGPointMake(0.0f, -64.0f)];
            else
                if(SCREEN_SIZE.height >= 568)
                    [mainScrollView setContentOffset:CGPointMake(0.0f, 0.0f)];
                else
                    [mainScrollView setContentOffset:CGPointMake(0.0f, 0.0f)];
        
        [UIView commitAnimations];
        
        [commentListBtn setTitle:@"查看咨询详细" forState:UIControlStateNormal];
    }
    commentFlag = !commentFlag;
    
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return InfoDetailListCell.getCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [infoAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellId";
    
    InfoDetailListCell *cell = (InfoDetailListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[InfoDetailListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.leftUserImg setImage:[UIImage imageNamed:@"person"]];
    if(indexPath.row == 0)
        cell.rightTitleLbl.text = [NSString stringWithFormat:@"%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Title"]];
    if([[[infoAry objectAtIndex:indexPath.row] objectForKey:@"Type"] intValue] == 0)
    {
        cell.leftUserLbl.text = [NSString stringWithFormat:@"居民:%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"UserName"]];
        cell.rightContentTextV.textColor = [UIColor blackColor];
    }
    else
    {
        cell.leftUserLbl.text = [NSString stringWithFormat:@"物业人员:%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"UserName"]];
        cell.rightContentTextV.textColor = [UIColor redColor];
    }
    cell.bottomTimeLbl.text = [NSString stringWithFormat:@"%@", [[infoAry objectAtIndex:indexPath.row] objectForKey:@"WriteTime"]];
    cell.rightContentTextV.text = [NSString stringWithFormat:@"    %@", [[infoAry objectAtIndex:indexPath.row] objectForKey:@"Content"]];
    if(indexPath.row != 0)
        cell.bottomRevertLbl.text = [NSString stringWithFormat:@"%ld 楼", indexPath.row+1];
    else
        cell.bottomRevertLbl.text = [NSString stringWithFormat:@"楼主"];
    
    return cell;
}

#pragma mark MBProgressHUD methods

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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    pageControl.currentPage = sender.contentOffset.x/100;
    
}

@end
