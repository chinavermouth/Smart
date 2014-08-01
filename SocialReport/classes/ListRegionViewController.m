//
//  ListRegionViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-25.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ListRegionViewController.h"

@interface ListRegionViewController ()

@end

@implementation ListRegionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        return self;
    }
    return self;
}

- (void)initData
{
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    myCommon = [Common shared];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self initData];
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
            [self.tableView reloadData];
        }];
    }
}

// dismissView
- (void)dismissView
{
    [self dismissModalViewControllerAnimated:YES];
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
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    cell.textLabel.text = [[regionAry objectAtIndex:indexPath.row] valueForKey:@"DisplayName"];
    
    if([cell.textLabel.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME]])
    {
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 保存小区名字
    [[NSUserDefaults standardUserDefaults] setValue:[[regionAry objectAtIndex:indexPath.row] valueForKey:@"DisplayName"] forKey:COMDISPLAYNAME];
    // 保存小区代码
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [[regionAry objectAtIndex:indexPath.row] valueForKey:@"CommunityCode"]] forKey:COMMUNITYCODE];
    // 保存小区号
    [[NSUserDefaults standardUserDefaults] setValue:[[regionAry objectAtIndex:indexPath.row] valueForKey:@"CommunityNo"] forKey:COMMUNITYNO];
    // 保存租户号
    [[NSUserDefaults standardUserDefaults] setValue:[[regionAry objectAtIndex:indexPath.row] valueForKey:@"TenantCode"] forKey:TENANTCODE];
    
    [self dismissModalViewControllerAnimated:YES];
}

// 设置区域头customView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 20)];
    header.text = @"选择小区";
    header.textColor = [UIColor blackColor];
    header.backgroundColor = [UIColor clearColor];
    header.textAlignment = NSTextAlignmentCenter;
    header.font = [UIFont systemFontOfSize:20.0f];
    [customView addSubview:header];
    return customView;
}

// 设置区域头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}


#pragma mark MBProgressHUD methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    HUD = nil;
}


@end
