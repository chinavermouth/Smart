//
//  ResidentDocSearchViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-3-5.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ResidentDocViewController.h"
#import "ListBuildingViewController.h"
#import "ListRoomViewController.h"
#import "MoveInViewController.h"
#import "MoveOutViewController.h"
#import "APCell.h"
#import "PersonInfoDetailViewController.h"

#define MAIN_SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define PADDING_LEFT 10
#define PADDING_TOP 5
#define TEXTPADDING_LEFT 15
#define IMAGE_CELL_HEIGHT 40


@interface ResidentDocViewController ()

@end

@implementation ResidentDocViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"住户档案";
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
    frame.size.height += 50;
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height - 64 - 50);
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
    
    // yet moved out search
    frame.origin.x = PADDING_LEFT + 5;
    frame.origin.y = searchRoomNumBtn.frame.origin.y + searchRoomNumBtn.frame.size.height + PADDING_TOP + 5;
    frame.size.width = 90;
    frame.size.height = 30;
    UIButton *yetMovedOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yetMovedOutBtn.frame = frame;
    [yetMovedOutBtn setTitle:@"住户迁出" forState:UIControlStateNormal];
    yetMovedOutBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [yetMovedOutBtn setBackgroundImage:[UIImage imageNamed:@"searchInfo_bg"] forState:UIControlStateNormal];
    [yetMovedOutBtn addTarget:self action:@selector(yetMovedSearchFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[1][2] isEqualToString:@"1"])
        [bgScrollView addSubview:yetMovedOutBtn];
    
    // has moved out search
    frame.origin.x += yetMovedOutBtn.frame.size.width + 10;
    UIButton *hasMovedOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hasMovedOutBtn.frame = frame;
    [hasMovedOutBtn setTitle:@"已迁出查询" forState:UIControlStateNormal];
    hasMovedOutBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [hasMovedOutBtn setBackgroundImage:[UIImage imageNamed:@"searchInfo_bg"] forState:UIControlStateNormal];
    [hasMovedOutBtn addTarget:self action:@selector(hasMovedSearchFunc) forControlEvents:UIControlEventTouchUpInside];
    if([myCommon.m_userPermissionAry[1][3] isEqualToString:@"1"])
        [bgScrollView addSubview:hasMovedOutBtn];
    
    // editBtn
    frame.origin.x += hasMovedOutBtn.frame.size.width + 40;
    frame.size.width = 50;
    frame.size.height = 30;
    editBtn = [[UIButton alloc] initWithFrame:frame];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editBtn setTitle:@"迁出" forState:UIControlStateNormal];
    [editBtn setBackgroundImage:[UIImage imageNamed:@"editBtn_bg@2x.png"] forState:UIControlStateNormal];
    [editBtn setBackgroundImage:[UIImage imageNamed:@"editBtn_bg_h@2x.png"] forState:UIControlStateHighlighted];
    [editBtn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    editBtn.alpha = 0;
    [bgScrollView addSubview:editBtn];
    
    // contentShowBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y += yetMovedOutBtn.frame.size.height + PADDING_TOP;
    frame.size.width = MAIN_SCREEN_SIZE.width - 2*PADDING_LEFT;
    if (SYSTEM_VERSION >= 7.0)
        frame.size.height = bgScrollView.frame.size.height - frame.origin.y - 44 - 10;
    else
        frame.size.height = bgScrollView.frame.size.height - frame.origin.y - 44 - 10 + 64;
    UIImageView *contentShowBg = [[UIImageView alloc] initWithFrame:frame];
    [contentShowBg setImage:[UIImage imageNamed:@""]];
//    contentShowBg.backgroundColor = [UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1.0f];
    [bgScrollView addSubview:contentShowBg];
    
    // myTableView
    frame.origin.y += 15;
    frame.size.width = contentShowBg.frame.size.width;
    frame.size.height = contentShowBg.frame.size.height - 90;
    myTableView = [[UITableView alloc]initWithFrame:frame];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1.0f];
    [bgScrollView addSubview:myTableView];
}

// 设置小区、楼宇和房号标签
- (void)viewWillAppear:(BOOL)animated
{
    searchLbl.text = [NSString stringWithFormat:@"当前小区为：       %@", [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME]];
    searchBuildingVauleLbl.text = myCommon.m_buildingName;
    searchRoomNumVauleLbl.text = myCommon.m_roomNo;
//    editBtn.alpha = 0;
//    personInfoArr = [[NSMutableArray alloc] init];
//    [myTableView reloadData];
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    myCommon = [Common shared];
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    
    [self initView];
    
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 首页" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    if([myCommon.m_userPermissionAry[1][1] isEqualToString:@"1"])
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"住户迁入" style:UIBarButtonItemStylePlain target:self action:@selector(moveInBtnClicked)];
    
    searchBuildingVauleLbl.text = @"";
    searchRoomNumVauleLbl.text = @"";
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

// 未迁出查询
- (void)yetMovedSearchFunc
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
    
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityNo=%@&roomNo=%@&tenantCode=%@&currentClient=TRUE&UID=%@",HTTPURL_LISTPERSON,[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO],searchRoomNumVauleLbl.text,[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"strRequestURL = %@",strRequestURL);
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"查询中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送登录请求
            strRespString = [myCommunicationHttp sendHttpRequest:HTTP_LISTPERSON threadType:1 strJsonContent:strRequestURL];
            
        } completionBlock:^{
            // 隐藏HUD
            [HUD removeFromSuperview];
            HUD = nil;
            
            personInfoArr = [[NSMutableArray alloc] init];
            if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
            {
                [personInfoArr addObjectsFromArray:[strRespString objectForKey:@"Data"]];
            }
            
            if ([personInfoArr count] == 0)
            {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此房间无人居住!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
                [alt show];
                editBtn.alpha = 0;
            }
            else
            {
                editBtn.alpha = 1;
            }
            
            [myTableView reloadData];
        }];
    }
}

// 已迁出查询
- (void)hasMovedSearchFunc
{
    editBtn.alpha = 0;
    
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
    
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityNo=%@&roomNo=%@&tenantCode=%@&currentClient=FALSE&UID=%@",HTTPURL_LISTPERSON,[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO],searchRoomNumVauleLbl.text,[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    //    NSLog(@"strRequestURL = %@",strRequestURL);
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"查询中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送登录请求
            strRespString = [myCommunicationHttp sendHttpRequest:HTTP_LISTPERSON threadType:1 strJsonContent:strRequestURL];
            
        } completionBlock:^{
            // 隐藏HUD
            [HUD removeFromSuperview];
            HUD = nil;
            
            personInfoArr = [[NSMutableArray alloc] init];
            if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
            {
                [personInfoArr addObjectsFromArray:[strRespString objectForKey:@"Data"]];
            }
            
            if ([personInfoArr count] == 0)
            {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此房间无已迁出信息!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,  nil];
                [alt show];
            }
            
            [myTableView reloadData];
        }];
    }
}

// 迁入
- (void)moveInBtnClicked
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
    
    MoveInViewController *residentDocViewController= [[MoveInViewController alloc] init];
    [self.navigationController pushViewController:residentDocViewController animated:YES];
}

// 迁出
- (void)moveOutBtnClicked
{
    MoveOutViewController *moveOutViewController = [[MoveOutViewController alloc] init];
    [self.navigationController pushViewController:moveOutViewController animated:YES];
}

// 迁出按钮
- (void)editBtnClicked
{
    if([editBtn.titleLabel.text isEqualToString:@"迁出"])
    {
        [myTableView setEditing:YES];
        [editBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    else if([editBtn.titleLabel.text isEqualToString:@"完成"])
    {
        [myTableView setEditing:NO];
        [editBtn setTitle:@"迁出" forState:UIControlStateNormal];
    }
}

#pragma mark - Table view delegate

// 删除提示按钮汉化
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[personInfoArr objectAtIndex:indexPath.row] objectForKey:@"CurrentClient"] intValue] == 1)
        return @"迁出";
    else
        return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([personInfoArr count] > 0)
        return 1;
    else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [personInfoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellId";
    
    APCell *cell = (APCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[APCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.apAddressLabel.text = [NSString stringWithFormat:@"%@   身份证号：%@", [[personInfoArr objectAtIndex:indexPath.row] valueForKey:@"ClientName"], [[personInfoArr objectAtIndex:indexPath.row] valueForKey:@"CertificateNo"]];

    if(![[[personInfoArr objectAtIndex:indexPath.row] valueForKey:@"MobilePhone"] isEqual:[NSNull null]])
        cell.apDistanceLabel.text = [NSString stringWithFormat:@"联系方式：%@",[[personInfoArr objectAtIndex:indexPath.row] valueForKey:@"MobilePhone"]];
    else
        cell.apDistanceLabel.text = @"联系方式：暂无";

    return cell;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    PersonInfoDetailViewController *personInfoDetailViewController = [[PersonInfoDetailViewController alloc] initWithPersonInfoDetail:[personInfoArr objectAtIndex:indexPath.row]];
//    [self.navigationController pushViewController:personInfoDetailViewController animated:YES];
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
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
        else if([[[personInfoArr objectAtIndex:indexPath.row] objectForKey:@"CurrentClient"] intValue] == 0)
        {
//            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前用户已迁出!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alt show];
            return ;
        }
        // NSDate转成NSString
        NSDate *now = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC+8"]];     //设置中国时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *nowDate = [dateFormatter stringFromDate:now];
        // 设置请求URL
        NSString *strRequestURL;
        strRequestURL = [NSString stringWithFormat:@"%@?clientNo=%@&roomNo=%@&outDate=%@&tenantCode=%@&UID=%@", HTTPURL_MOVEOUT, [[personInfoArr objectAtIndex:indexPath.row] objectForKey:@"ClientNo"], myCommon.m_roomNo,nowDate,[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//        NSLog(@"strRequestURL = %@",strRequestURL);
        
        // 发送登录请求
        strRespString = [myCommunicationHttp sendHttpRequest:HTTP_MOVEOUT threadType:1 strJsonContent:strRequestURL];
        
        // 必须在数据源里删除后
        [personInfoArr removeObjectAtIndex:indexPath.row];
        // 再在界面显示里删除
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self yetMovedSearchFunc];
        
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


#pragma mark MBProgressHUD methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
