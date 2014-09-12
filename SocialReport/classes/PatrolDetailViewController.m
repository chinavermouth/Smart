//
//  PatrolDetailViewController.m
//  SocialReport
//
//  Created by J.H on 14-4-21.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "PatrolDetailViewController.h"
#import "Common.h"
#import "InfoDetailListCell.h"
#import "PublishViewController.h"
#import "PersonInfoViewController.h"

@interface PatrolDetailViewController ()

@end

@implementation PatrolDetailViewController

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
        self.title = @"详细信息";
    }
    return self;
}

- (void)initData
{
    myCommon = [Common shared];
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    
    infoAry = [[NSMutableArray alloc] init];
    pageIndex = 0;
}

- (void)initView
{
    CGRect frame = self.view.frame;
    
    // bgScrollView
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        frame.size.height -= 45;
    else
    {
        frame.origin.y = 0;
        frame.size.height -= self.navigationController.navigationBar.bounds.size.height + 45;
    }
    UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    bgScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width, frame.size.height - 64);
    [self.view addSubview:bgScrollView];
    
    // picScrollView
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = SCREEN_SIZE.width * 0.75;
    UIScrollView *picScrollView = [[UIScrollView alloc] initWithFrame:frame];
    picScrollView.directionalLockEnabled = YES;
    picScrollView.pagingEnabled = YES;
    picScrollView.showsVerticalScrollIndicator = NO;
    picScrollView.showsHorizontalScrollIndicator = NO;
    picScrollView.contentSize = CGSizeMake(SCREEN_SIZE.width * 3, picScrollView.frame.size.height - 64);
    [bgScrollView addSubview:picScrollView];
    
    UIImageView *bcImg1 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg1 setImage:[UIImage imageNamed:@"Default"]];
    [picScrollView addSubview:bcImg1];
    
    frame.origin.x = SCREEN_SIZE.width;
    UIImageView *bcImg2 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg2 setImage:[UIImage imageNamed:@"Default"]];
    [picScrollView addSubview:bcImg2];
    
    frame.origin.x = SCREEN_SIZE.width * 2;
    UIImageView *bcImg3 = [[UIImageView alloc] initWithFrame:frame];
    [bcImg3 setImage:[UIImage imageNamed:@"Default"]];
    [picScrollView addSubview:bcImg3];
    
    
    
    // bottomView
    frame.origin.x = 0;
    frame.origin.y = bgScrollView.frame.size.height;
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = 45;
    UIView *bottomView = [[UIView alloc] initWithFrame:frame];
    bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getInfoDetailFunc];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    myCommon = [Common shared];
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    if([myCommon.m_userPermissionAry[3][2] isEqualToString:@"1"])
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表评论" style:UIBarButtonItemStylePlain target:self action:@selector(addRecordFunc)];
    
    NSString *const CellIdentifier = @"cellIdentifier";
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    // 下拉刷新
    [self addHeader];
    
    // 上拉刷新
    [self addFooter];
}

- (void)getInfoDetailFunc
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?ID=%@&tenantCode=%@&Index=1&pageIndex=%d&pageSize=5&UID=%@", HTTPURL_GETINFORDETAIL, myCommon.m_subjectId, [[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE], pageIndex++, [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"strRequestURL = %@",strRequestURL);
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送登录请求
            respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETINFORDETAIL threadType:1 strJsonContent:strRequestURL];
            
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
                
                [self.tableView reloadData];
            }
            else
            {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
            }
        }];
    }

}

// 追加评论
- (void)addRecordFunc
{
    PublishViewController *commentViewController =[[PublishViewController alloc] initWithViewType:2];
    [self.navigationController pushViewController:commentViewController animated:YES];
}

// 上拉刷新
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
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
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        // 初始化数据
        infoAry = [[NSMutableArray alloc] init];
        pageIndex = 0;
        
        // 获取最新信息
        [self getInfoDetailFunc];
        // 加载数据,结束加载
        [self doneWithView:refreshView];
    };
    
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
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
    
    cell.leftUserBtn.tag = indexPath.row;
    [cell.leftUserBtn addTarget:self action:@selector(personInfoFunc:) forControlEvents:UIControlEventTouchUpInside];
    [cell.leftUserImg setImage:[UIImage imageNamed:@"person"]];
    [cell.leftUserLbl setText:[NSString stringWithFormat:@"%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"UserName"]]];
    if(indexPath.row == 0)
        cell.rightTitleLbl.text = myCommon.m_infoTitle;
    cell.rightContentTextV.text = [NSString stringWithFormat:@"%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"Content"]];
    cell.bottomTimeLbl.text = [NSString stringWithFormat:@"%@",[[infoAry objectAtIndex:indexPath.row] objectForKey:@"IssuesTime"]];
    if(indexPath.row != 0)
        cell.bottomRevertLbl.text = [NSString stringWithFormat:@"%ld 楼", indexPath.row+1];
    else
        cell.bottomRevertLbl.text = [NSString stringWithFormat:@"楼主"];
    
    // 设置异步加载图片,并做内存和本地缓存
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

- (void)personInfoFunc:(UIButton *)sender
{
    PersonInfoViewController *personInfoViewController = [[PersonInfoViewController alloc] initWithUserID:[[infoAry objectAtIndex:sender.tag] objectForKey:@"UserID"]];
    [self.navigationController pushViewController:personInfoViewController animated:YES];
}

// 显示大图
- (void)showImageFunc:(id)sender
{
    showImageBtn = (UIButton *)sender;
    
    [self.browserView show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return InfoDetailListCell.getCellHeight;
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
	return @"@安防巡查";
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


@end
