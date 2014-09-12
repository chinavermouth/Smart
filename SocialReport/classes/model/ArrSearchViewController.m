//
//  ArrSearchViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-16.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ArrSearchViewController.h"
#import "ListBuildingViewController.h"
#import "ListRoomViewController.h"

#define MAIN_SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define PADDING_LEFT 10
#define PADDING_TOP 5
#define TEXTPADDING_LEFT 15
#define IMAGE_CELL_HEIGHT 40

@interface ArrSearchViewController ()

@end

@implementation ArrSearchViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"欠费查询";
    }
    return self;
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.frame;
    
    // bgScrollView
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        frame.origin.y = 0;
        frame.size.height -= self.navigationController.navigationBar.bounds.size.height;
    }
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height - 64);
    [self.view addSubview:bgScrollView];
    
    //searchImg
    frame.origin.x = 20;
    frame.origin.y = 18;
    frame.size.width = 20;
    frame.size.height = 20;
    UIImageView *searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"currentRegion"]];
    searchImg.frame = frame;
    [bgScrollView addSubview:searchImg];
    
    // searchLbl
    frame.origin.x = 20 + searchImg.frame.size.width + 10;
    frame.origin.y = 15;
    frame.size.width = 280;
    frame.size.height = 30;
    searchLbl = [[UILabel alloc] initWithFrame:frame];
    searchLbl.text = @"";
    //    searchLbl.textColor = [UIColor blueColor];
    searchLbl.font = [UIFont systemFontOfSize:18.0f];
    searchLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:searchLbl];
    
    // searchBuildingBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y += searchLbl.frame.size.height + PADDING_TOP;
    frame.size.width = MAIN_SCREEN_SIZE.width - 2*PADDING_LEFT;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UIButton *searchBuildingBtn = [[UIButton alloc]initWithFrame:frame];
    searchBuildingBtn.backgroundColor = [UIColor clearColor];
    [searchBuildingBtn setTitle:@"" forState:UIControlStateNormal];
    [searchBuildingBtn addTarget:self action:@selector(searchBuildingBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchBuildingBtn setBackgroundImage:[UIImage imageNamed:@"box1.png"] forState:UIControlStateNormal];
    [searchBuildingBtn setBackgroundImage:[UIImage imageNamed:@"box1_h.png"] forState:UIControlStateHighlighted];
    [bgScrollView addSubview:searchBuildingBtn];
    
    // searchBuildingLbl
    frame.origin.x += TEXTPADDING_LEFT;
    frame.origin.y = searchBuildingBtn.frame.origin.y;
    frame.size.width = 80;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UILabel *searchBuildingLbl = [[UILabel alloc] initWithFrame:frame];
    searchBuildingLbl.backgroundColor = [UIColor clearColor];
    searchBuildingLbl.textAlignment = NSTextAlignmentLeft;
    searchBuildingLbl.font = [UIFont systemFontOfSize:16.0f];
    searchBuildingLbl.text = @"请选择楼宇";
    [bgScrollView addSubview:searchBuildingLbl];
    
    // searchBuildingVauleLbl
    frame.origin.x += searchBuildingLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    searchBuildingVauleLbl = [[UILabel alloc] initWithFrame:frame];
    searchBuildingVauleLbl.backgroundColor = [UIColor clearColor];
    searchBuildingVauleLbl.textAlignment = NSTextAlignmentCenter;
    searchBuildingVauleLbl.font = [UIFont systemFontOfSize:16.0f];
    searchBuildingVauleLbl.text = @"";
    [bgScrollView addSubview:searchBuildingVauleLbl];
    
    // searchBuildingIco
    frame.origin.x = searchBuildingBtn.frame.origin.x + searchBuildingBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    UIImageView *searchBuildingIco = [[UIImageView alloc] initWithFrame:frame];
    searchBuildingIco.image = [UIImage imageNamed:@"arrow"];
    [bgScrollView addSubview:searchBuildingIco];
    
    // searchRoomNumBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = searchBuildingBtn.frame.origin.y + searchBuildingBtn.frame.size.height;
    frame.size.width = searchBuildingBtn.frame.size.width;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UIButton *searchRoomNumBtn = [[UIButton alloc]initWithFrame:frame];
    searchRoomNumBtn.backgroundColor = [UIColor clearColor];
    [searchRoomNumBtn setTitle:@"" forState:UIControlStateNormal];
    [searchRoomNumBtn addTarget:self action:@selector(searchRoomNumBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchRoomNumBtn setBackgroundImage:[UIImage imageNamed:@"box2.png"] forState:UIControlStateNormal];
    [searchRoomNumBtn setBackgroundImage:[UIImage imageNamed:@"box2_h.png"] forState:UIControlStateHighlighted];
    [bgScrollView addSubview:searchRoomNumBtn];
    
    // searchRoomNumLbl
    frame.origin.x += TEXTPADDING_LEFT;
    frame.origin.y = searchRoomNumBtn.frame.origin.y;
    frame.size.width = 80;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UILabel *searchRoomNumLbl = [[UILabel alloc] initWithFrame:frame];
    searchRoomNumLbl.backgroundColor = [UIColor clearColor];
    searchRoomNumLbl.textAlignment = NSTextAlignmentLeft;
    searchRoomNumLbl.font = [UIFont systemFontOfSize:16.0f];
    searchRoomNumLbl.text = @"请选择房号";
    [bgScrollView addSubview:searchRoomNumLbl];
    
    // searchRoomNumVauleLbl
    frame.origin.x += searchRoomNumLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    searchRoomNumVauleLbl = [[UILabel alloc] initWithFrame:frame];
    searchRoomNumVauleLbl.backgroundColor = [UIColor clearColor];
    searchRoomNumVauleLbl.textAlignment = NSTextAlignmentCenter;
    searchRoomNumVauleLbl.font = [UIFont systemFontOfSize:16.0f];
    searchRoomNumVauleLbl.text = @"";
    [bgScrollView addSubview:searchRoomNumVauleLbl];
    
    // searchRoomNumIco
    frame.origin.x = searchRoomNumBtn.frame.origin.x + searchRoomNumBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    UIImageView *searchRoomNumIco = [[UIImageView alloc] initWithFrame:frame];
    searchRoomNumIco.image = [UIImage imageNamed:@"arrow"];
    [bgScrollView addSubview:searchRoomNumIco];
    
    // searchInfoBtn
    frame.origin.x = PADDING_LEFT + 5;
    frame.origin.y = searchRoomNumBtn.frame.origin.y + searchRoomNumBtn.frame.size.height + PADDING_TOP + 5;
    frame.size.width = 110;
    frame.size.height = 30;
    UIButton *searchInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchInfoBtn.frame = frame;
    [searchInfoBtn setTitle:@"查询欠费信息" forState:UIControlStateNormal];
    searchInfoBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [searchInfoBtn setBackgroundImage:[UIImage imageNamed:@"searchInfo_bg"] forState:UIControlStateNormal];
    [searchInfoBtn addTarget:self action:@selector(searchInfoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[2][1] isEqualToString:@"1"])
    [bgScrollView addSubview:searchInfoBtn];
    
    // contentShowBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y += searchInfoBtn.frame.size.height + PADDING_TOP;
    frame.size.width = MAIN_SCREEN_SIZE.width - 2*PADDING_LEFT;
    frame.size.height = bgScrollView.frame.size.height - frame.origin.y - 44 - 10;
    UIImageView *contentShowBg = [[UIImageView alloc] initWithFrame:frame];
    [contentShowBg setImage:[UIImage imageNamed:@"box"]];
    if([myCommon.m_userPermissionAry[2][1] isEqualToString:@"1"])
    [bgScrollView addSubview:contentShowBg];
    
    // contentTextView
    frame.origin.x += 5;
    frame.origin.y += 15;
    frame.size.width = contentShowBg.frame.size.width - 2*5;
    frame.size.height = contentShowBg.frame.size.height;
    contentTextView = [[UITextView alloc] initWithFrame:frame];
    contentTextView.font = [UIFont systemFontOfSize:16.0f];
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.editable = NO;       // 设置不可编辑
    contentTextView.text = @"欠费情况";
    contentTextView.textColor = [UIColor redColor];
    if([myCommon.m_userPermissionAry[2][1] isEqualToString:@"1"])
    [bgScrollView addSubview:contentTextView];

}

// 设置小区、楼宇和房号标签
- (void)viewWillAppear:(BOOL)animated
{
    searchLbl.text = [NSString stringWithFormat:@"当前小区为：       %@", [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME]];
    searchBuildingVauleLbl.text = myCommon.m_buildingName;
    searchRoomNumVauleLbl.text = myCommon.m_roomNo;
    
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
}

- (void)initData
{
    myCommon = [Common shared];
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    
    searchBuildingVauleLbl.text = @"";
    searchRoomNumVauleLbl.text = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initData];
    [self initView];
    
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 首页" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
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

// 设置楼宇
- (void)searchBuildingBtnClicked
{
    ListBuildingViewController *listBuildingViewController = [[ListBuildingViewController alloc] init];
    [self.navigationController pushViewController:listBuildingViewController animated:YES];
    
    searchRoomNumVauleLbl.text = nil;
    myCommon.m_roomNo = nil;
}

// 设置房间
- (void)searchRoomNumBtnClicked
{
    if(searchBuildingVauleLbl.text == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先选择楼宇!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        
        return ;
    }
    
    ListRoomViewController *listRoomViewController = [[ListRoomViewController alloc] init];
    [self.navigationController pushViewController:listRoomViewController animated:YES];
}

// 查询欠费信息
- (void)searchInfoBtnClicked
{
    if(searchBuildingVauleLbl.text == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择楼宇!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return ;
    }
    else if(searchRoomNumVauleLbl.text == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择房间号!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return ;
    }
    else
    {
        // 设置请求URL
        NSString *strRequestURL;
        strRequestURL = [NSString stringWithFormat:@"%@?roomNo=%@&buildNo=%@&communityNo=%@&tenantCode=%@&UID=%@",HTTPURL_ARRSEARCH,myCommon.m_roomNo,myCommon.m_buildingNo,[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO],[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//        NSLog(@"strRequestURL = %@",strRequestURL);
        
        if(HUD == nil)
        {
            HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
            [self.view addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"查询中...";
            [HUD showAnimated:YES whileExecutingBlock:^{
                // 发送登录请求
                strRespString = [myCommunicationHttp sendHttpRequest:HTTP_ARRSEARCH threadType:1 strJsonContent:strRequestURL];
                
            } completionBlock:^{
                // 隐藏HUD
                [HUD removeFromSuperview];
                HUD = nil;

                arrInfoStr = [[NSMutableString alloc] init];
                
                if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
                {
                    for (NSDictionary *tempDic in [strRespString objectForKey:@"Data"])
                    {
                        [arrInfoStr appendString:@"    "];
                        [arrInfoStr appendString:[tempDic objectForKey:@"Name"]];
                        [arrInfoStr appendString:@"\n"];
                    }
                }
                contentTextView.text = arrInfoStr;
            }];
        }
    }
}


#pragma mark MBProgressHUD methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    NSLog(@"Hud:%@",hud);
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
