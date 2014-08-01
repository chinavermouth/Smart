//
//  MoveOutViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "MoveOutViewController.h"
#import "ListRoomViewController.h"
#import "ListBuildingViewController.h"
#import "ListPersonViewController.h"

#define MAIN_SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define PADDING_LEFT 10
#define PADDING_TOP 5
#define TEXTPADDING_LEFT 15

#define IMAGE_CELL_HEIGHT 40
#define IMAGE_CELL_WIDTH MAIN_SCREEN_SIZE.width - 2*PADDING_LEFT


@interface MoveOutViewController ()

@end

@implementation MoveOutViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"人员迁出";
    }
    return self;
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
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height - 64);
    [self.view addSubview:bgScrollView];
    
    // searchLbl
    frame.origin.x = 20;
    frame.origin.y = 15;
    frame.size.width = 280;
    frame.size.height = 30;
    searchLbl = [[UILabel alloc] initWithFrame:frame];
    searchLbl.text = @"";
    searchLbl.textColor = [UIColor blueColor];
    searchLbl.font = [UIFont systemFontOfSize:18.0f];
    [bgScrollView addSubview:searchLbl];
    
    // searchBuildingBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y += searchLbl.frame.size.height + PADDING_TOP;
    frame.size.width = IMAGE_CELL_WIDTH;
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
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UIButton *searchRoomNumBtn = [[UIButton alloc]initWithFrame:frame];
    searchRoomNumBtn.backgroundColor = [UIColor clearColor];
    [searchRoomNumBtn setTitle:@"" forState:UIControlStateNormal];
    [searchRoomNumBtn addTarget:self action:@selector(searchRoomNumBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchRoomNumBtn setBackgroundImage:[UIImage imageNamed:@"box3.png"] forState:UIControlStateNormal];
    [searchRoomNumBtn setBackgroundImage:[UIImage imageNamed:@"box3_h.png"] forState:UIControlStateHighlighted];
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
    
    // searchPersonBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = searchRoomNumBtn.frame.origin.y + searchRoomNumBtn.frame.size.height;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UIButton *searchPersonBtn = [[UIButton alloc]initWithFrame:frame];
    searchPersonBtn.backgroundColor = [UIColor clearColor];
    [searchPersonBtn setTitle:@"" forState:UIControlStateNormal];
    [searchPersonBtn addTarget:self action:@selector(searchPersonBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchPersonBtn setBackgroundImage:[UIImage imageNamed:@"box2.png"] forState:UIControlStateNormal];
    [searchPersonBtn setBackgroundImage:[UIImage imageNamed:@"box2_h.png"] forState:UIControlStateHighlighted];
    [bgScrollView addSubview:searchPersonBtn];
    
    // searchPersonLbl
    frame.origin.x += TEXTPADDING_LEFT;
    frame.origin.y = searchPersonBtn.frame.origin.y;
    frame.size.width = 80;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UILabel *searchPersonLbl = [[UILabel alloc] initWithFrame:frame];
    searchPersonLbl.backgroundColor = [UIColor clearColor];
    searchPersonLbl.textAlignment = NSTextAlignmentLeft;
    searchPersonLbl.font = [UIFont systemFontOfSize:16.0f];
    searchPersonLbl.text = @"请选择人员";
    [bgScrollView addSubview:searchPersonLbl];
    
    // searchPersonVauleLbl
    frame.origin.x += searchPersonLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    searchPersonVauleLbl = [[UILabel alloc] initWithFrame:frame];
    searchPersonVauleLbl.backgroundColor = [UIColor clearColor];
    searchPersonVauleLbl.textAlignment = NSTextAlignmentCenter;
    searchPersonVauleLbl.font = [UIFont systemFontOfSize:16.0f];
    searchPersonVauleLbl.text = @"";
    [bgScrollView addSubview:searchPersonVauleLbl];
    
    // searchPersonIco
    frame.origin.x = searchPersonBtn.frame.origin.x + searchPersonBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    UIImageView *searchPersonIco = [[UIImageView alloc] initWithFrame:frame];
    searchPersonIco.image = [UIImage imageNamed:@"arrow"];
    [bgScrollView addSubview:searchPersonIco];
    
    // btConnDeviceBtn
    frame.origin.x = 0;
    frame.origin.y = bgScrollView.frame.size.height;
    frame.size.width = 320;
    frame.size.height = 45;
    UIButton *moveOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moveOutBtn.frame = frame;
    moveOutBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [moveOutBtn setTitle:@"迁 出" forState:UIControlStateNormal];
    [moveOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moveOutBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [moveOutBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [moveOutBtn addTarget:self action:@selector(moveOutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moveOutBtn];
}

// 设置小区、楼宇和房号标签
- (void)viewWillAppear:(BOOL)animated
{
    searchLbl.text = [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME];
    searchBuildingVauleLbl.text = myCommon.m_buildingName;
    searchRoomNumVauleLbl.text = myCommon.m_roomNo;
    searchPersonVauleLbl.text = myCommon.m_clientName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    myCommon = [Common shared];
    
    [self initView];
    
    myCommunicationHttp = [[CommunicationHttp alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 选择楼宇
- (void)searchBuildingBtnClicked
{
    ListBuildingViewController *listBuildingViewController = [[ListBuildingViewController alloc] init];
    [self.navigationController pushViewController:listBuildingViewController animated:YES];
    
    searchRoomNumVauleLbl.text = nil;
    myCommon.m_roomNo = nil;
    searchPersonVauleLbl.text = nil;
    myCommon.m_clientNo = nil;
    myCommon.m_clientName = nil;
}

// 选择房间
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
    
    searchPersonVauleLbl.text = nil;
    myCommon.m_clientNo = nil;
    myCommon.m_clientName = nil;
}

// 选择人员
- (void)searchPersonBtnClicked
{
    if(searchBuildingVauleLbl.text == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先选择楼宇!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        
        return ;
    }
    if(searchRoomNumVauleLbl.text == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先选择房号!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        
        return ;
    }
    
    ListPersonViewController *listPersonViewController =[[ListPersonViewController alloc] init];
    [self.navigationController pushViewController:listPersonViewController animated:YES];
}

// 人员迁出
- (void)moveOutBtnClicked
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
    else if(searchPersonVauleLbl.text  == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择人员!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return ;
    }
    
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要迁出?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alt show];
    

}


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        // NSDate转成NSString
        NSDate *now = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC+8"]];     //设置中国时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *nowDate = [dateFormatter stringFromDate:now];
        // 设置请求URL
        NSString *strRequestURL;
        strRequestURL = [NSString stringWithFormat:@"%@?clientNo=%@&roomNo=%@&outDate=%@&tenantCode=%@&UID=%@", HTTPURL_MOVEOUT, myCommon.m_clientNo, myCommon.m_roomNo,nowDate,[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
        NSLog(@"moveOut strRequestURL = %@",strRequestURL);
        
        // 发送登录请求
        strRespString = [myCommunicationHttp sendHttpRequest:HTTP_MOVEOUT threadType:1 strJsonContent:strRequestURL];
        
        searchPersonVauleLbl.text = nil;
        myCommon.m_clientNo = nil;
        myCommon.m_clientName = nil;
        
        if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
        {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"迁出成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alt show];
        }
        else
        {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"迁出失败，请重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alt show];
        }
    }
}

//#pragma mark UIActionSheetDelegate
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if(buttonIndex > 0)
//    {
//        searchPersonVauleLbl.text = [[personInfoDic allValues] objectAtIndex:buttonIndex - 1];
//        // 保存客户ID
//        personID = [[personInfoDic allKeys] objectAtIndex:buttonIndex - 1];
////        NSLog(@"personID = %@, searchPersonVauleLbl.text = %@",personID,searchPersonVauleLbl.text);
//    }
//}


@end
