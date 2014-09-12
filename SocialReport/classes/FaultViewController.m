//
//  FaultViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-17.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "FaultViewController.h"
#import "PublishViewController.h"
#import "InfoListCell.h"
#import "FaultDetailViewController.h"


@interface FaultViewController ()

@end

@implementation FaultViewController

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
        self.title = @"故障申告";
    }
    return self;
}

- (void)initView
{
    CGRect frame;
    
    // 信息列表
    frame.origin.x = 0;
    if(SYSTEM_VERSION >= 7.0)
        frame.origin.y = 64;
    else
        frame.origin.y = 0;
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = SCREEN_SIZE.height - frame.origin.y;
    infoTableView = [[UITableView alloc]initWithFrame:frame];
    infoTableView.delegate = self;
    infoTableView.dataSource = self;
    [self.view addSubview:infoTableView];
}

- (void)initData
{
    myCommon = [Common shared];
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    
    infoAry = [[NSMutableArray alloc] init];
    pageIndex = 0;
    flag = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
    
    [self initData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initView];
        [self byFirstTimeFunc];
        
        NSString *const CellIdentifier = @"cellIdentifier";
        [infoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        [self addHeader];
        [self addFooter];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    myCommon = [Common shared];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 首页" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    if([myCommon.m_userPermissionAry[4][1] isEqualToString:@"1"])
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishFunc)];
    
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

// 发布新信息或评论
- (void)publishFunc
{
    // 根据页面类型加载不同界面
    PublishViewController *publishViewController = [[PublishViewController alloc] initWithViewType:3];
    [self.navigationController pushViewController:publishViewController animated:YES];
}

// 按原始时间排序
- (void)byFirstTimeFunc
{
    // 首次进入时初始化数据
    if(flag != 0)
    {
        infoAry = [[NSMutableArray alloc] init];
        pageIndex = 0;
        flag = 0;
    }
    
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityNo=%@&tenantCode=%@&type=2&Index=2&pageIndex=%@&pageSize=10&UID=%@",HTTPURL_GETINFORMATION,[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO],[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE], [NSString stringWithFormat:@"%d", pageIndex++], [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"strRequestURL = %@",strRequestURL);
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送登录请求
            respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETINFORMATION threadType:1 strJsonContent:strRequestURL];
            
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
                
                // 添加数据
                for (NSDictionary *tempDic in [respDic objectForKey:@"Data"])
                {
                    [infoAry addObject:tempDic];
                }
                
                [infoTableView reloadData];
            }
            else
            {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
            }
        }];
    }
}

// 按最后时间排序
- (void)byLastTimeFunc
{
    // 首次进入时初始化数据
    if(flag != 1)
    {
        infoAry = [[NSMutableArray alloc] init];
        pageIndex = 0;
        flag = 1;
    }
    
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityNo=%@&tenantCode=%@&type=2&Index=1&pageIndex=%@&pageSize=10&UID=%@",HTTPURL_GETINFORMATION,[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO],[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE],[NSString stringWithFormat:@"%d", pageIndex++], [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    //    NSLog(@"strRequestURL = %@",strRequestURL);
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送登录请求
            respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETINFORMATION threadType:1 strJsonContent:strRequestURL];
            
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
                
                // 添加数据
                for (NSDictionary *tempDic in [respDic objectForKey:@"Data"])
                {
                    [infoAry addObject:tempDic];
                }
                
                [infoTableView reloadData];
            }
            else
            {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
            }
        }];
    }
}

// 上拉刷新
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = infoTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 增加数据
        if(flag == 0)
        {
            [self byFirstTimeFunc];
        }
        else
        {
            [self byLastTimeFunc];
        }
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
    
    _footer = footer;
}

// 下拉刷新
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = infoTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        infoAry = [[NSMutableArray alloc] init];
        pageIndex = 0;
        
        // 增加数据
        if(flag == 0)
        {
            [self byFirstTimeFunc];
        }
        else
        {
            [self byLastTimeFunc];
        }
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
    
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [infoTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [infoAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellId";
    
    InfoListCell *cell = (InfoListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[InfoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.leftUserImg setImage:[UIImage imageNamed:@"person"]];
    [cell.leftUserLbl setText:[NSString stringWithFormat:@"%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"UserName"]]];
    cell.rightTitleLbl.text = [NSString stringWithFormat:@"%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"Title"]];
    cell.rightContentLbl.text = [NSString stringWithFormat:@"%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"Content"]];
    cell.bottomTimeLbl.text = [NSString stringWithFormat:@"%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"IssuesTime"]];
    cell.bottomRevertLbl.text = [NSString stringWithFormat:@"%d条回复", [[[infoAry objectAtIndex:indexPath.row] objectForKey:@"Count"] intValue]-1];
    NSInteger imageCount = [[[infoAry objectAtIndex:indexPath.row] objectForKey:@"ImageList"] count];
    
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
        imageUrl = [NSString stringWithFormat:@"%@%@", HTTPURL_IMAGEDATABASE, [[[[infoAry objectAtIndex:indexPath.row] objectForKey:@"ImageList"] objectAtIndex:i] objectForKey:@"Src"]];
        NSLog(@"imageUrl: %@",imageUrl);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];    // 找到document目录
        NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:[imageUrl substringFromIndex:35]];    // 确定图片全路径
        [myCommon checkImageMemoryCache];   // 检查图片内存缓存,超过50则清理
        if([myCommon.m_imageCacheDic objectForKey:imageUrl])
        {
            [imageBtn setImage:[myCommon.m_imageCacheDic objectForKey:imageUrl] forState:UIControlStateNormal];
            [cell.rightImgScrollView addSubview:imageBtn];
        }
        else if([NSData dataWithContentsOfFile:fullPathToFile])
        {
            [myCommon.m_imageCacheDic setValue:[UIImage imageWithData:[NSData dataWithContentsOfFile:fullPathToFile]] forKey:imageUrl];    // 将图片写入内存缓存,以后直接用内存访问
            [imageBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:fullPathToFile]] forState:UIControlStateNormal];
            [cell.rightImgScrollView addSubview:imageBtn];
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
                                                  [cell.rightImgScrollView addSubview:imageBtn];
                                              });
                           });
        }
    }
    
    cell.rightImgScrollView.contentSize = CGSizeMake(imageCount * (90 + 10), 67.5);        // 调整scrollview contentsize 大小
    
    return cell;
}

// 显示大图
- (void)showImageFunc:(id)sender
{
    showImageBtn = (UIButton *)sender;
    
    [self.browserView show];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 保存主题ID
    myCommon.m_subjectId = [[infoAry objectAtIndex:indexPath.row] objectForKey:@"ID"];
    // 保存信息title
    myCommon.m_infoTitle = [[infoAry objectAtIndex:indexPath.row] objectForKey:@"Title"];
    
    FaultDetailViewController *faultDetailViewController = [[FaultDetailViewController alloc] init];
    [self.navigationController pushViewController:faultDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return InfoListCell.getCellHeight;
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
	return @"@故障申告";
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
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
