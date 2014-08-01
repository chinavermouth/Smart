//
//  ListPersonViewController.m
//  SocialReport
//
//  Created by J.H on 14-3-28.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ListPersonViewController.h"

@interface ListPersonViewController ()

@end

@implementation ListPersonViewController

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
        // 列出人员
        [self listPerson];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listPerson
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityNo=%@&roomNo=%@&tenantCode=%@&UID=%@",HTTPURL_LISTPERSON,[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO],myCommon.m_roomNo,[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    NSLog(@"strRequestURL = %@",strRequestURL);
    
    // 发送请求
    strRespString = [myCommunicationHttp sendHttpRequest:HTTP_LISTPERSON threadType:1 strJsonContent:strRequestURL];
    
    personAry = [[NSMutableArray alloc] init];
    if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
    {
        for (NSDictionary *tempDic in [strRespString objectForKey:@"Data"])
        {
            // 添加未迁出数据
            if([[tempDic objectForKey:@"CurrentClient"] intValue] == 1)
                [personAry addObject:tempDic];
        }
        [self.tableView reloadData];
    }
    // 无人员信息
    if([personAry count] == 0)
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此房间暂无可迁出人员!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        // 1秒后dismissView
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(popView) userInfo:nil repeats:NO];
    }
}

// popView
- (void)popView
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [personAry count];
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"  %@          身份证号：%@", [[personAry objectAtIndex:indexPath.row] valueForKey:@"ClientName"], [[personAry objectAtIndex:indexPath.row] valueForKey:@"CertificateNo"]];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    
    if([[[personAry objectAtIndex:indexPath.row] valueForKey:@"ClientName"] isEqualToString:myCommon.m_clientName])
    {
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 保存用户编号
    myCommon.m_clientNo = [[personAry objectAtIndex:indexPath.row] valueForKey:@"ClientNo"];
    // 保存默认用户名称
    myCommon.m_clientName = [[personAry objectAtIndex:indexPath.row] valueForKey:@"ClientName"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
