//
//  ChooseRegionViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-9.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ChooseRegionViewController.h"

@interface ChooseRegionViewController ()

@end

@implementation ChooseRegionViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"选择小区";
        return self;
    }
    return self;
}

- (void)initData
{
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    myCommon = [Common shared];
}

- (void)initView
{
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = SCREEN_SIZE.height - 60;
    mainTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    [self.view addSubview:mainTable];
    
    frame.origin.x = 10;
    frame.origin.y = mainTable.frame.origin.y + mainTable.frame.size.height + 15;
    if(SYSTEM_VERSION < 7.0)
        frame.origin.y = mainTable.frame.origin.y + mainTable.frame.size.height + 15 - 35;
    frame.size.width = 71;
    frame.size.height = 30;
    UIButton *chooseAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseAllBtn.frame = frame;
    [chooseAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [chooseAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chooseAllBtn setBackgroundColor:[UIColor lightGrayColor]];
    [chooseAllBtn addTarget:self action:@selector(chooseAllFunc) forControlEvents:UIControlEventTouchUpInside];
    chooseAllBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:chooseAllBtn];
    
    frame.origin.x += chooseAllBtn.frame.size.width + 5;
    UIButton *reverseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reverseBtn.frame = frame;
    [reverseBtn setTitle:@"反选" forState:UIControlStateNormal];
    [reverseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reverseBtn setBackgroundColor:[UIColor lightGrayColor]];
    [reverseBtn addTarget:self action:@selector(reverseFunc) forControlEvents:UIControlEventTouchUpInside];
    reverseBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:reverseBtn];
    
    frame.origin.x += reverseBtn.frame.size.width + 5;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = frame;
    [cancelBtn setTitle:@"取消选择" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
    [cancelBtn addTarget:self action:@selector(cancelFunc) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:cancelBtn];
    
    frame.origin.x += cancelBtn.frame.size.width + 5;
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = frame;
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setBackgroundColor:[UIColor lightGrayColor]];
    [okBtn addTarget:self action:@selector(chooseOkFunc) forControlEvents:UIControlEventTouchUpInside];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:okBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initData];
    [self initView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 列出小区
        [self listRegion];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listRegion
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?userID=%@&UID=%@",HTTPURL_LISTREGION,[[NSUserDefaults standardUserDefaults] objectForKey:USERID],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    //    NSLog(@"strRequestURL = %@",strRequestURL);
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送请求
            strRespString = [myCommunicationHttp sendHttpRequest:HTTP_LISTREGION threadType:1 strJsonContent:strRequestURL];
            
        } completionBlock:^{
            // 隐藏HUD
            [HUD removeFromSuperview];
            HUD = nil;
            
            regionAry = [[NSMutableArray alloc] init];
            if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
            {
                for (NSDictionary *tempDic in [strRespString objectForKey:@"Data"])
                {
                    [regionAry addObject:tempDic];
                }
            }
            // 无楼宇信息
            if([regionAry count] == 0)
            {
                // 1秒后dismissView
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissView) userInfo:nil repeats:NO];
            }
            [mainTable reloadData];
        }];
    }
}

// dismissView
- (void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 全选
- (void)chooseAllFunc
{
    UITableViewCell *tempCell;
    for(int i=0; i<[regionAry count]; i++)
    {
        tempCell = [mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if(tempCell.accessoryType != UITableViewCellAccessoryCheckmark)
        {
            tempCell.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:250/255.0 alpha:1.0];
            tempCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

// 反选
- (void)reverseFunc
{
    UITableViewCell *tempCell;
    for(int i=0; i<[regionAry count]; i++)
    {
        tempCell = [mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if(tempCell.accessoryType != UITableViewCellAccessoryCheckmark)
        {
            tempCell.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:250/255.0 alpha:1.0];
            tempCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            tempCell.backgroundColor = [UIColor whiteColor];
            tempCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

// 取消选择
- (void)cancelFunc
{
    UITableViewCell *tempCell;
    for(int i=0; i<[regionAry count]; i++)
    {
        tempCell = [mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if(tempCell.accessoryType == UITableViewCellAccessoryCheckmark)
        {
            tempCell.backgroundColor = [UIColor whiteColor];
            tempCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

// 确定选择
- (void)chooseOkFunc
{
    UITableViewCell *tempCell;
    myCommon.m_commCodeAry = [[NSMutableArray alloc] initWithObjects:nil];
    myCommon.m_commNoAry = [[NSMutableArray alloc] initWithObjects:nil];
    myCommon.m_commNameAry = [[NSMutableArray alloc] initWithObjects:nil];
    
    for(int i=0; i<[regionAry count]; i++)
    {
        tempCell = [mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if(tempCell.accessoryType == UITableViewCellAccessoryCheckmark)
        {
            // 保存小区信息
            [myCommon.m_commCodeAry addObject:[[regionAry objectAtIndex:i] valueForKey:@"CommunityCode"]];
            [myCommon.m_commNoAry addObject:[[regionAry objectAtIndex:i] valueForKey:@"CommunityNo"]];
            [myCommon.m_commNameAry addObject:[[regionAry objectAtIndex:i] valueForKey:@"DisplayName"]];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return [regionAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [[regionAry objectAtIndex:indexPath.row] valueForKey:@"DisplayName"];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:250/255.0 alpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}


#pragma mark MBProgressHUD methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    HUD = nil;
}


@end
