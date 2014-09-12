//
//  TeneServiceViewController.m
//  SocialReport
//
//  Created by J.H on 14-9-2.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "TeneServiceViewController.h"
#import "TenePhoneNumberCell.h"
#import "TenementViewController.h"
#import "CommunityViewController.h"

@interface TeneServiceViewController ()

@end

@implementation TeneServiceViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"物业客服";
        return self;
    }
    return self;
}

- (void)initData
{
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    myLeenToast = [[LeenToast alloc] init];
}

- (void)initView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 首页" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveFunc)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.frame;
    
    // background scrollview
    frame.size.height += 50;
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height - 64 - 50);
    [self.view addSubview:bgScrollView];
    
    // banner
    frame.origin.x = 5;
    frame.origin.y = 5;
    frame.size.width -= 2*5;
    frame.size.height = 180;
    if(SCREEN_SIZE.height < 568.0)
        frame.size.height = 150;
    UIImageView *bannerImg = [[UIImageView alloc] initWithFrame:frame];
    [bannerImg setImage:[UIImage imageNamed:@"teneBanner"]];
    [bgScrollView addSubview:bannerImg];
    
    // community name label
    frame.origin.x = 15;
    frame.origin.y += bannerImg.frame.size.height + 10;
    frame.size.width = 220;
    frame.size.height = 20;
    UILabel *commLbl = [[UILabel alloc] initWithFrame:frame];
    commLbl.text = [NSString stringWithFormat:@"小区名称：%@", [[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME]];
    commLbl.font = [UIFont systemFontOfSize:14.0f];
    commLbl.textColor = [UIColor blackColor];
    commLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:commLbl];
    
    // community name edit button
    frame.origin.x += commLbl.frame.size.width;
    frame.size.width = 30;
    UIButton *commEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commEditBtn.frame = frame;
    [commEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [commEditBtn setTitleColor:[UIColor colorWithRed:29/255.0f green:123/255.0f blue:175/255.0f alpha:1.0f] forState:UIControlStateNormal];
    commEditBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [commEditBtn addTarget:self action:@selector(commEditFunc) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:commEditBtn];
    
    // tenement name label
    frame.origin.x = 15;
    frame.origin.y += commLbl.frame.size.height;
    frame.size.width = 220;
    teneLbl = [[UILabel alloc] initWithFrame:frame];
    teneLbl.text = @"服务单位：";
    teneLbl.font = [UIFont systemFontOfSize:14.0f];
    teneLbl.textColor = [UIColor blackColor];
    teneLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:teneLbl];
    
    // tenement name edit button
    frame.origin.x += teneLbl.frame.size.width;
    frame.size.width = 30;
    UIButton *teneEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    teneEditBtn.frame = frame;
    [teneEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [teneEditBtn setTitleColor:[UIColor colorWithRed:29/255.0f green:123/255.0f blue:175/255.0f alpha:1.0f] forState:UIControlStateNormal];
    teneEditBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [teneEditBtn addTarget:self action:@selector(teneEditFunc) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:teneEditBtn];
    
    // phone number banner backgound
    frame.origin.x = 5;
    frame.origin.y += teneLbl.frame.size.height + 10;
    frame.size.width = SCREEN_SIZE.width - 2*5;
    frame.size.height = 50;
    UIView *numBannerBg = [[UIView alloc] initWithFrame:frame];
    numBannerBg.backgroundColor = [UIColor colorWithRed:243/255.0f green:245/255.0f blue:244/255.0f alpha:1.0f];
    [bgScrollView addSubview:numBannerBg];
    
    frame.origin.x = 15;
    frame.origin.y = (numBannerBg.frame.size.height - 79/3.0)/2.0;
    frame.size.width = 79/3.0;
    frame.size.height = 79/3.0;
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:frame];
    [phoneImg setImage:[UIImage imageNamed:@"tenePhone"]];
    [numBannerBg addSubview:phoneImg];
    
    frame.origin.x += phoneImg.frame.size.width;
    frame.origin.y = (numBannerBg.frame.size.height - 20.0)/2.0;
    frame.size.width = 110;
    frame.size.height = 20;
    UILabel *phoneLbl = [[UILabel alloc] initWithFrame:frame];
    phoneLbl.text = @"对外服务电话";
    phoneLbl.textAlignment = NSTextAlignmentCenter;
    phoneLbl.textColor = [UIColor blackColor];
    phoneLbl.font = [UIFont systemFontOfSize:14.0f];
    [numBannerBg addSubview:phoneLbl];
    
    frame.origin.x = SCREEN_SIZE.width - 20 - 77/3.0;
    frame.origin.y = (numBannerBg.frame.size.height - 68/3.0)/2.0;
    frame.size.width = 77/3.0;
    frame.size.height = 68/3.0;
    UIButton *addNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addNumBtn.frame = frame;
    [addNumBtn setImage:[UIImage imageNamed:@"tenePlus"] forState:UIControlStateNormal];
    [addNumBtn addTarget:self action:@selector(addNumFunc) forControlEvents:UIControlEventTouchUpInside];
    [numBannerBg addSubview:addNumBtn];
    
    // number table
    frame.origin.x = 0;
    frame.origin.y = numBannerBg.frame.origin.y + numBannerBg.frame.size.height;
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = SCREEN_SIZE.height - frame.origin.y - 64;
    numberTable = [[UITableView alloc] initWithFrame:frame];
    numberTable.dataSource = self;
    numberTable.delegate = self;
    [bgScrollView addSubview:numberTable];
}

// 添加客服电话
- (void)addNumFunc
{
    // create custom view
    CGRect frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = 220;
    frame.size.height = 190;
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    
    frame.origin.x = 10;
    frame.origin.y = 10;
    frame.size.width = 200;
    frame.size.height = 20;
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:frame];
    titleLbl.text = @"新增客服电话";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = [UIFont systemFontOfSize:15.0f];
    titleLbl.textColor = [UIColor colorWithRed:29/255.0f green:123/255.0f blue:175/255.0f alpha:1.0f];
    titleLbl.backgroundColor = [UIColor clearColor];
    [containerView addSubview:titleLbl];
    
    frame.origin.y += titleLbl.frame.size.height + 10;
    nameText = [[UITextField alloc] initWithFrame:frame];
    nameText.placeholder = @"请输入姓名";
    nameText.textAlignment = NSTextAlignmentCenter;
    nameText.font = [UIFont systemFontOfSize:14.0f];
    nameText.textColor = [UIColor blackColor];
    nameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameText.delegate = self;
    nameText.returnKeyType = UIReturnKeyNext;
    nameText.tag = 100;
    [containerView addSubview:nameText];
    
    frame.origin.y += nameText.frame.size.height + 10;
    phoneText = [[UITextField alloc] initWithFrame:frame];
    phoneText.placeholder = @"请输入手机号";
    phoneText.textAlignment = NSTextAlignmentCenter;
    phoneText.font = [UIFont systemFontOfSize:14.0f];
    phoneText.textColor = [UIColor blackColor];
    phoneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneText.delegate = self;
    phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneText.returnKeyType = UIReturnKeyNext;
    phoneText.tag = 101;
    [containerView addSubview:phoneText];
    
    frame.origin.y += phoneText.frame.size.height + 10;
    noteText = [[UITextField alloc] initWithFrame:frame];
    noteText.placeholder = @"请输入备注";
    noteText.textAlignment = NSTextAlignmentCenter;
    noteText.font = [UIFont systemFontOfSize:14.0f];
    noteText.textColor = [UIColor blackColor];
    noteText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    noteText.delegate = self;
    noteText.returnKeyType = UIReturnKeyDone;
    noteText.tag = 102;
    [containerView addSubview:noteText];
    
    frame.origin.y += noteText.frame.size.height + 10;
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame = frame;
    [createBtn setTitle:@"添 加" forState:UIControlStateNormal];
    createBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn setBackgroundColor:[UIColor lightGrayColor]];
    [createBtn addTarget:self action:@selector(addPhoneNumFunc) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:createBtn];
    
    frame.origin.y += createBtn.frame.size.height + 10;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = frame;
    [cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
    [cancelBtn addTarget:self action:@selector(cancelFunc) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:cancelBtn];
    
    myAltView = [[CustomIOS7AlertView alloc] init];
    [myAltView setContainerView:containerView];
    [myAltView setButtonTitles:nil];
    [myAltView setUseMotionEffects:true];
    [myAltView show];
    [nameText becomeFirstResponder];
}

- (void)teneEditFunc
{
    TenementViewController *tenementViewController = [[TenementViewController alloc] init];
    [self.navigationController pushViewController:tenementViewController animated:YES];
}

- (void)commEditFunc
{
    CommunityViewController *communityViewController = [[CommunityViewController alloc] init];
    [self.navigationController pushViewController:communityViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initView];
    
    // 获取主界面物业信息
    [self getAllCommunityInfo];
}

// 获取主界面物业信息
- (void)getAllCommunityInfo
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityCode=%@&tenantCode=%@&UID=%@",HTTPURL_GETALLCOMMUNITYINFO, [[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYCODE], [[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE], [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"strRequestURL = %@",strRequestURL);
    
    __block NSDictionary *respDic;
    __block MBProgressHUD *HUD;
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^
         {
             // 发送请求
             respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETALLCOMMUNITYINFO threadType:1 strJsonContent:strRequestURL];
         }
          completionBlock:^
         {
             // 隐藏HUD
             [HUD removeFromSuperview];
             HUD = nil;
             if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
             {
                 NSDictionary *dataDic = [[respDic objectForKey:@"Data"] objectAtIndex:0];
                 
                 teneLbl.text = [NSString stringWithFormat:@"服务单位：%@",[dataDic objectForKey:@"ServiceUnit"]];
                 
                 resPhoneAry = [dataDic objectForKey:@"List"];
                 
                 [numberTable reloadData];
             }
             else
             {
                 UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alt show];
             }
         }];
    }
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

// 添加物业客服电话
- (void)addPhoneNumFunc
{
    if([nameText.text isEqualToString:@""])
    {
        [myLeenToast settext:@"姓名不能为空"];
        [myLeenToast show];
        return;
    }
    else if([phoneText.text isEqualToString:@""])
    {
        [myLeenToast settext:@"手机号不能为空"];
        [myLeenToast show];
        return;
    }
    
    [nameText resignFirstResponder];
    [phoneText resignFirstResponder];
    [noteText resignFirstResponder];
    
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:nameText.text forKey:@"name"];
    [requestDic setValue:phoneText.text forKey:@"phoneCode"];
    [requestDic setValue:noteText.text forKey:@"remark"];
    [requestDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYCODE] forKey:@"communityCode"];
    [requestDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO] forKey:@"communityNo"];
    [requestDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE] forKey:@"tenantCode"];
//    NSLog(@"requestDic = %@",requestDic);
    NSString *strJsonData = [requestDic JSONRepresentation];
    
    __block MBProgressHUD *HUD;
    __block NSDictionary *responseDic = [[NSDictionary alloc] init];
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(70, 200, 180, 100)];
        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:HUD];    // 添加在myAltView所在层级之上,才能屏蔽这个层级
        HUD.labelText = @"添加中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            
            responseDic = [myCommunicationHttp sendHttpRequest:HTTP_CREATEADDRESSLIST threadType:1 strJsonContent:strJsonData];
            
        } completionBlock:^{
            
            // 隐藏HUD
            [HUD removeFromSuperview];
            HUD = nil;
            if([[[responseDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
            {
                [myAltView close];
                [self getAllCommunityInfo];    // 刷新物业客服通讯录列表
                UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [myAlt show];
            }
            else
            {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
            }
        }];
    }
}

// myAltView 取消
- (void)cancelFunc
{
    [nameText resignFirstResponder];
    [phoneText resignFirstResponder];
    [noteText resignFirstResponder];
    
    [myAltView close];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 100:
            [phoneText becomeFirstResponder];
            break;
        case 101:
            [noteText becomeFirstResponder];
            break;
        case 102:
            [noteText resignFirstResponder];
            break;
            
        default:
            break;
    }
    
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resPhoneAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"basic-cell";
    TenePhoneNumberCell *cell = (TenePhoneNumberCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(nil == cell)
    {
        cell = [[TenePhoneNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.phoneNumLbl.text = [NSString stringWithFormat:@"%@：%@",[[resPhoneAry objectAtIndex:indexPath.row] objectForKey:@"Name"], [[resPhoneAry objectAtIndex:indexPath.row] objectForKey:@"PhoneCode"]];
    [cell.rightDelBtn addTarget:self action:@selector(delPhoneNumFunc:) forControlEvents:UIControlEventTouchUpInside];
    cell.rightDelBtn.tag = indexPath.row;
    
    return cell;
}

- (void)delPhoneNumFunc:(UIButton *)sender
{
    UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    myAlt.tag = sender.tag;
    [myAlt show];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10 + 20 + 10;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if(buttonIndex == 1)
    {
        // 删除通讯录电话
        // 设置请求URL
        NSString *strRequestURL;
        strRequestURL = [NSString stringWithFormat:@"%@?id=%@&UID=%@",HTTPURL_DELETEADDRESSLIST, [[resPhoneAry objectAtIndex:alertView.tag] objectForKey:@"ID"], [[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//        NSLog(@"strRequestURL = %@",strRequestURL);
        
        __block MBProgressHUD *HUD;
        __block NSDictionary *responseDic = [[NSDictionary alloc] init];
        if(HUD == nil)
        {
            HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
            [self.view addSubview:HUD];
            HUD.labelText = @"删除中...";
            [HUD showAnimated:YES whileExecutingBlock:^
             {
                 // 发送请求
                 responseDic = [myCommunicationHttp sendHttpRequest:HTTP_DELETEADDRESSLIST threadType:1 strJsonContent:strRequestURL];
             }
              completionBlock:^
             {
                 // 隐藏HUD
                 [HUD removeFromSuperview];
                 HUD = nil;
                 if([[[responseDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
                 {
                     [self getAllCommunityInfo];    // 刷新物业客服通讯录列表
                     UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"删除成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                     [myAlt show];
                 }
                 else
                 {
                     UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alt show];
                 }
             }];
        }
    }
}

@end
