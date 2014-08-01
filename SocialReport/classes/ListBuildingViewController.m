//
//  ListBuildingViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-28.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ListBuildingViewController.h"

@interface ListBuildingViewController ()

@end

@implementation ListBuildingViewController

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
        // 列出楼宇
        [self listBuilding];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listBuilding
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityNo=%@&tenantCode=%@&UID=%@",HTTPURL_LISTBUILDING, [[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO], [[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE], [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"strRequestURL = %@",strRequestURL);
    
    // 发送登录请求
    strRespString = [myCommunicationHttp sendHttpRequest:HTTP_LISTBUILDING threadType:1 strJsonContent:strRequestURL];
    
    buildingAry = [[NSMutableArray alloc] init];
    if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
    {
        for (NSDictionary *tempDic in [strRespString objectForKey:@"Data"])
        {
            [buildingAry addObject:tempDic];
        }
        [self.tableView reloadData];
    }
    // 无楼宇信息
    if([buildingAry count] == 0)
    {
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
    return [buildingAry count];
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
    
    cell.textLabel.text = [[buildingAry objectAtIndex:indexPath.row] valueForKey:@"DisplayName"];
    
    if([cell.textLabel.text isEqualToString:myCommon.m_buildingName])
    {
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 保存默认选择楼宇
    myCommon.m_buildingName = [[buildingAry objectAtIndex:indexPath.row] valueForKey:@"DisplayName"];
    // 保存楼宇代码
    myCommon.m_buildingNo = [[buildingAry objectAtIndex:indexPath.row] valueForKey:@"BuildIngNo"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//// 设置区域头customView
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//{
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
//    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 20)];
//    header.text = @"选择楼宇";
//    header.textColor = [UIColor blackColor];
//    header.backgroundColor = [UIColor clearColor];
//    header.textAlignment = NSTextAlignmentCenter;
//    header.font = [UIFont systemFontOfSize:20.0f];
//    [customView addSubview:header];
//    return customView;
//}
//
//// 设置区域头高
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50.0f;
//}

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
