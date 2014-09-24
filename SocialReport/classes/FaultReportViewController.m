//
//  FaultReportViewController.m
//  PersonalSocialReport
//
//  Created by J.H on 14-6-20.
//  Copyright (c) 2014年 J.H. All rights reserved.
//

#import "FaultReportViewController.h"
#import "InfoListCell2.h"
#import "LoginViewController.h"
#import "FaultReportDetailViewController.h"

NSString *const faultReportCellIdentifier = @"faultReportCellIdentifier";


@interface FaultReportViewController ()

@end

@implementation FaultReportViewController

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
        self.title = @"故障处理";
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
    
    // 集成刷新控件
    [faultReportTable registerClass:[UITableViewCell class] forCellReuseIdentifier:faultReportCellIdentifier];
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
    strRequestURL = [NSString stringWithFormat:@"%@?communityCode=%@&Type=%@&Index=1&pageIndex=%d&pageSize=7&UID=%@", HTTPURL_GETFEEDBACKS, [[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYCODE],@"故障申告", pageIndex++, [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"getReportInfo strRequestURL = %@",strRequestURL);
    
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
                         UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未发布故障处理，请点击发布~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[faultListData objectAtIndex:indexPath.row] objectForKey:@"ImageList"] count])
        return InfoListCell2.getCellHeight;
    else
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
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.topLbl.text = [NSString stringWithFormat:@"%@", [[faultListData objectAtIndex:indexPath.row] objectForKey:@"Content"]];
    cell.middleLbl.text = [NSString stringWithFormat:@"发布于:%@", [[faultListData objectAtIndex:indexPath.row] objectForKey:@"WriteTime"]];
    cell.bottomLbl1.text = [NSString stringWithFormat:@"更新于:%@", [[faultListData objectAtIndex:indexPath.row] objectForKey:@"LastUpdated"]];
    cell.bottomLbl2.text = [NSString stringWithFormat:@"状态:%@", [[faultListData objectAtIndex:indexPath.row] objectForKey:@"Status"]];
    
    NSInteger imageCount = [[[faultListData objectAtIndex:indexPath.row] objectForKey:@"ImageList"] count];
    
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
        imageUrl = [NSString stringWithFormat:@"%@%@", HTTPURL_IMAGEDATABASE, [[[[faultListData objectAtIndex:indexPath.row] objectForKey:@"ImageList"] objectAtIndex:i] objectForKey:@"Src"]];
//        NSLog(@"imageUrl: %@",imageUrl);
        
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myCommon.m_reportId = [[faultListData objectAtIndex:indexPath.row] objectForKey:@"ID"];
    myCommon.m_reportTitle = [[faultListData objectAtIndex:indexPath.row] objectForKey:@"Title"];
    myCommon.m_reportStatus = [[faultListData objectAtIndex:indexPath.row] objectForKey:@"Status"];

    FaultReportDetailViewController *faultReportDetailViewController = [[FaultReportDetailViewController alloc] init];
    [self.navigationController pushViewController:faultReportDetailViewController animated:YES];
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
