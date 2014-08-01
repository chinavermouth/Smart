//
//  FaultReportDetailViewController.m
//  PersonalSocialReport
//
//  Created by J.H on 14-6-23.
//  Copyright (c) 2014年 J.H. All rights reserved.
//

#import "FaultReportDetailViewController.h"
#import "ReportPublishViewController.h"
#import "InfoDetailListCell.h"
#import "LoginViewController.h"

#define MARGIN_LEFT 22
#define MARGIN_TOP  10

NSString *const faultReportCellId = @"cellIdentifier";

@interface FaultReportDetailViewController ()

@end

@implementation FaultReportDetailViewController

#pragma mark - browserView Getters

- (AGPhotoBrowserView *)browserView
{
	if (!_browserView) {
		_browserView = [[AGPhotoBrowserView alloc] initWithFrame:CGRectZero];
		_browserView.delegate = self;
		_browserView.dataSource = self;
	}
	
	return _browserView;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"故障处理详细";
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
    frame.size.width = 200;
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
    timeLbl.text = [NSString stringWithFormat:@"发布时间：%@",@""];
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
    [commentListBtn setTitle:@"查看申报详细" forState:UIControlStateNormal];
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
    [self.view addSubview:callBtn];
    
    frame.origin.x += callBtn.frame.size.width;
    messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = frame;
    [messageBtn setTitle:@"发短信" forState:UIControlStateNormal];
    [messageBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    messageBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [messageBtn addTarget:self action:@selector(messageBtnFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageBtn];
    
    frame.origin.x += messageBtn.frame.size.width;
    emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    emailBtn.frame = frame;
    [emailBtn setTitle:@"发邮件" forState:UIControlStateNormal];
    [emailBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    emailBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [emailBtn addTarget:self action:@selector(emailBtnFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailBtn];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    pageIndex = 0;
    infoAry = [[NSMutableArray alloc] init];
    if([commentListBtn.titleLabel.text isEqualToString:@"点击返回内容"])
        [commentListBtn setTitle:@"查看申报详细" forState:UIControlStateNormal];
    
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
    
    [commentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:faultReportCellId];
    [self addHeader];
    [self addFooter];
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
                timeLbl.text = [NSString stringWithFormat:@"发布时间：%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"WriteTime"]];
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
        
        [commentListBtn setTitle:@"查看申报详细" forState:UIControlStateNormal];
    }
    commentFlag = !commentFlag;

}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[infoAry objectAtIndex:indexPath.row] objectForKey:@"ImageUrl"] count])
        return InfoDetailListCell.getCellHeight;
    else
        return InfoDetailListCell.getCellHeight - 5*2 - 67.5 - 5;
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
    if(indexPath.row == 0)
        cell.lineOneLbl.text = [NSString stringWithFormat:@"%@", [[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Title"]];
    if([[[infoAry objectAtIndex:indexPath.row] objectForKey:@"Type"] intValue] == 0)
    {
        cell.lineTwoLeftLbl.text = [NSString stringWithFormat:@"居民:%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"UserName"]];
        cell.lineThreeRightText.textColor = [UIColor blackColor];
    }
    else
    {
        cell.lineTwoLeftLbl.text = [NSString stringWithFormat:@"物业人员:%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"UserName"]];
        cell.lineThreeRightText.textColor = [UIColor redColor];
    }
    cell.lineTwoRightLbl.text = [NSString stringWithFormat:@"%@", [[infoAry objectAtIndex:indexPath.row] objectForKey:@"WriteTime"]];
    cell.lineThreeRightText.text = [NSString stringWithFormat:@"    %@", [[infoAry objectAtIndex:indexPath.row] objectForKey:@"Content"]];
    cell.lineFourLeftLbl.text = [NSString stringWithFormat:@"电话:%@", [[infoAry objectAtIndex:indexPath.row] objectForKey:@"Tel"]];
    if(indexPath.row != 0)
        cell.lineFourRightLbl.text = [NSString stringWithFormat:@"%d 楼", indexPath.row+1];
    else
        cell.lineFourRightLbl.text = [NSString stringWithFormat:@"楼主"];
    
    // 设置异步加载图片,并做内存和本地缓存
    NSInteger imageCount = [[[infoAry objectAtIndex:indexPath.row] objectForKey:@"ImageUrl"] count];
    
    UIButton *imageBtn;
    CGRect frame;
    NSString *imageUrl;
    __block UIImage *tempImage;
    for(int i = 0; i < imageCount; i++)
    {
        frame.origin.x = i * (90 + 10);
        frame.origin.y = 0;
        frame.size.width = 90;
        frame.size.height = 67.5;
        imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = frame;
        [imageBtn addTarget:self action:@selector(showImageFunc:) forControlEvents:UIControlEventTouchUpInside];
        imageUrl = [NSString stringWithFormat:@"%@%@", HTTPURL_IMAGEDATABASE, [[[[infoAry objectAtIndex:indexPath.row] objectForKey:@"ImageUrl"] objectAtIndex:i] objectForKey:@"Src"]];
        NSLog(@"imageUrl: %@",imageUrl);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];    // 找到document目录
        NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:[imageUrl substringFromIndex:35]];    // 确定图片全路径
        [myCommon checkImageMemoryCache];   // 检查图片内存缓存,超过50则清理
        if([myCommon.m_imageCacheDic objectForKey:imageUrl])
        {
            [imageBtn setImage:[myCommon.m_imageCacheDic objectForKey:imageUrl] forState:UIControlStateNormal];
            [cell.imageScrollView addSubview:imageBtn];
        }
        else if([NSData dataWithContentsOfFile:fullPathToFile])
        {
            [myCommon.m_imageCacheDic setValue:[UIImage imageWithData:[NSData dataWithContentsOfFile:fullPathToFile]] forKey:imageUrl];    // 将图片写入内存缓存,以后直接用内存访问
            [imageBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:fullPathToFile]] forState:UIControlStateNormal];
            [cell.imageScrollView addSubview:imageBtn];
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                           ^{
                               
                               tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
                               [myCommon.m_imageCacheDic setValue:tempImage forKey:imageUrl];    // 将图片写入内存缓存
                               [UIImageJPEGRepresentation(tempImage, 0.05f) writeToFile:fullPathToFile atomically:NO];    // 图片存入本地
                               
                               dispatch_async(dispatch_get_main_queue(),
                                              ^{
                                                  [imageBtn setImage:tempImage forState:UIControlStateNormal];
                                                  [cell.imageScrollView addSubview:imageBtn];
                                              });
                           });
        }
    }
    
    cell.imageScrollView.contentSize = CGSizeMake(imageCount * (90 + 10), 67.5);        // 调整scrollview contentsize 大小
    
    return cell;
}

// 显示大图
- (void)showImageFunc:(id)sender
{
    showImageBtn = (UIButton *)sender;
    
    [self.browserView show];
}

#pragma mark - AGPhotoBrowserDataSource

- (NSInteger)numberOfPhotosForPhotoBrowser:(AGPhotoBrowserView *)photoBrowser
{
	return 1;
}

- (UIImage *)photoBrowser:(AGPhotoBrowserView *)photoBrowser imageAtIndex:(NSInteger)index
{
    return showImageBtn.imageView.image;
}

- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser titleForImageAtIndex:(NSInteger)index
{
	return @"数字物业云";
}

- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser descriptionForImageAtIndex:(NSInteger)index
{
	return @"@故障处理";
}

- (BOOL)photoBrowser:(AGPhotoBrowserView *)photoBrowser willDisplayActionButtonAtIndex:(NSInteger)index
{
    return NO;
}

#pragma mark - AGPhotoBrowserDelegate

- (void)photoBrowser:(AGPhotoBrowserView *)photoBrowser didTapOnDoneButton:(UIButton *)doneButton
{
	[self.browserView hideWithCompletion:^(BOOL finished)
     {
         
     }];
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
        [self presentModalViewController:nav animated:YES];
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
