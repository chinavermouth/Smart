//
//  TenementViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "TenementViewController.h"
#import "APCell2.h"
#import "JSON.h"
#import "GTMBase64.h"
#import "UIImageView+WebCache.h"


@interface TenementViewController ()

@end

@implementation TenementViewController

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
        self.title = @"单位信息";
        return self;
    }
    return self;
}

- (void)initData
{
    myCommon =[Common shared];
    
    NSArray* property1 = [[NSArray alloc] initWithObjects:@"公司Logo", @"名称", @"地址", @"社区代码", @"简介",nil];
    NSArray* property2 = [[NSArray alloc] initWithObjects:@"移动电话", @"固定电话", @"联系人", nil];
    NSArray* property3 = [[NSArray alloc] initWithObjects:@"网址", @"邮箱", @"更新时间", nil];
    properties = [[NSArray alloc] initWithObjects: property1, property2, property3, nil];
    
    NSMutableArray* value1 = [[NSMutableArray alloc] initWithObjects:@"", @"名称2", @"地址2", @"社区代码2", @"简介2",nil];
    NSMutableArray* value2 = [[NSMutableArray alloc] initWithObjects:@"移动电话2", @"固定电话2", @"联系人2", nil];
    NSMutableArray* value3 = [[NSMutableArray alloc] initWithObjects:@"网址2", @"邮箱2", @"更新时间2", nil];
    values = [[NSMutableArray alloc] initWithObjects: value1, value2, value3, nil];
    
//    NSLog(@"values = %@", values);
    // 设置默认图片
    logoImg = nil;
    encodeImageStr = @"";
    myLeenToast = [[LeenToast alloc] init];
    
    [self getCommunityInfo];     // 获取社区信息
}

- (void)initView
{
    mainTable.backgroundColor = [UIColor whiteColor];
    
    CGRect frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
    if (SYSTEM_VERSION >= 7.0)
    {
        frame.origin.y = 64;
    }
    frame.size.width = SCREEN_SIZE.width;
    frame.size.height = SCREEN_SIZE.height;
    mainTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.contentSize = CGSizeMake(SCREEN_SIZE.width, SCREEN_SIZE.height * 2);
    mainTable.dataSource = self;
    mainTable.delegate = self;
    [self.view addSubview:mainTable];

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 物业客服" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveFunc)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        myCommunicationHttp = [[CommunicationHttp alloc] init];
        [self initData];        // 初始化表数据
        // 获取键盘高度通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    });
    
}

- (void)backFunc
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 保存社区信息
- (void)saveFunc
{
    [mainTable setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    [mainTable resignFirstResponder];
    APCell2 *tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    [tempCell.rightTextView resignFirstResponder];
    tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    {
        nameStr = tempCell.rightTextField.text;
        [tempCell.rightTextField resignFirstResponder];
    }
    tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    {
        addressStr = tempCell.rightTextField.text;
        [tempCell.rightTextField resignFirstResponder];
    }
    tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    {
        codeStr = tempCell.rightTextField.text;
        [tempCell.rightTextField resignFirstResponder];
    }
    tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    {
        moblieStr = tempCell.rightTextField.text;
        [tempCell.rightTextField resignFirstResponder];
    }
    tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    {
        phoneStr = tempCell.rightTextField.text;
        [tempCell.rightTextField resignFirstResponder];
    }
    tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    {
        contectStr = tempCell.rightTextField.text;
        [tempCell.rightTextField resignFirstResponder];
    }
    tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    {
        websiteStr = tempCell.rightTextField.text;
        [tempCell.rightTextField resignFirstResponder];
    }
    tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    {
        emailStr = tempCell.rightTextField.text;
        [tempCell.rightTextField resignFirstResponder];
    }
    
    // 设置请求参数
    NSMutableDictionary *dicRequestData = [[NSMutableDictionary alloc] init];
    [dicRequestData setValue:nameStr forKey:@"displayName"];
    [dicRequestData setValue:addressStr forKey:@"address"];
    [dicRequestData setValue:moblieStr forKey:@"tel"];
    [dicRequestData setValue:phoneStr forKey:@"phoneNum"];
    [dicRequestData setValue:[[values objectAtIndex:0] objectAtIndex:4] forKey:@"summary"];
    [dicRequestData setValue:@"" forKey:@"content"];
    [dicRequestData setValue:encodeImageStr forKey:@"logoBase64Image"];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE] forKey:@"tenantCode"];
    [dicRequestData setValue:emailStr forKey:@"email"];
    [dicRequestData setValue:@"" forKey:@"createTime"];
    [dicRequestData setValue:contectStr forKey:@"contact"];
    [dicRequestData setValue:websiteStr forKey:@"uRL"];
    [dicRequestData setValue:codeStr forKey:@"code"];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERID] forKey:@"userID"];
    
    // 转换成json格式
    NSString *strJsonData = [NSString stringWithFormat:@"%@",[dicRequestData JSONRepresentation]];
    NSLog(@"保存社区 strJsonData = %@",strJsonData);
    
    // 发送请求
   __block NSDictionary *respDic = [[NSDictionary alloc] init];
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"保存中...";
        [HUD showAnimated:YES whileExecutingBlock:^
         {
             respDic = [myCommunicationHttp sendHttpRequest:HTTP_CREATEORUPDATETENANTINFO threadType:1 strJsonContent:strJsonData];
         }
          completionBlock:^
         {
             // 隐藏HUD
             [HUD removeFromSuperview];
             HUD = nil;
             if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
             {
                 UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                 [myAlt show];
                 return ;
             }
             else
             {
                 UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alt show];
             }
         }];
    }
}

// 获取社区信息
- (void)getCommunityInfo
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?userID=%@&UID=%@",HTTPURL_GETTENANTINFO,[[NSUserDefaults standardUserDefaults] objectForKey:USERID],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
//    NSLog(@"strRequestURL = %@",strRequestURL);
    
    __block NSDictionary *respDic;
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^
        {
            // 发送请求
            respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETTENANTINFO threadType:1 strJsonContent:strRequestURL];
        }
        completionBlock:^
        {
             // 隐藏HUD
            [HUD removeFromSuperview];
            HUD = nil;
            if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
            {
                NSDictionary *dataDic = [[respDic objectForKey:@"Data"] objectAtIndex:0];
        
                NSMutableArray *value1 = [[NSMutableArray alloc] initWithObjects:[dataDic objectForKey:@"LogoUrl"],[dataDic objectForKey:@"DisplayName"],[dataDic objectForKey:@"Address"], [dataDic objectForKey:@"Code"], [dataDic objectForKey:@"Summary"], nil];
                NSMutableArray *value2 = [[NSMutableArray alloc] initWithObjects:[dataDic objectForKey:@"Tel"], [dataDic objectForKey:@"PhoneNum"], [dataDic objectForKey:@"Contact"], nil];
                NSMutableArray *value3 = [[NSMutableArray alloc] initWithObjects:[dataDic objectForKey:@"URL"], [dataDic objectForKey:@"Email"], [dataDic objectForKey:@"LastUpdated"],nil];
                values = [[NSMutableArray alloc] initWithObjects:value1, value2, value3,nil];
        
                [self initView];
//                [mainTable reloadData];
            }
            else
            {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
            }
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [properties count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * strobj = [properties objectAtIndex:section];
    return [strobj count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"basic-cell";
    APCell2 *cell = (APCell2 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(nil == cell)
    {
        cell = [[APCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.leftLbl.text = [[properties objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.rightTextField.text = [NSString stringWithFormat:@"%@", [[values objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    cell.rightTextField.delegate = self;
    cell.rightImgBtn.alpha = 0;
    cell.rightTextView.alpha = 0;
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        cell.rightTextField.text = @"";
        cell.rightTextField.backgroundColor = [UIColor clearColor];
        cell.rightTextField.enabled = NO;
        cell.rightImgBtn.alpha = 1;
        if(logoImg)
            [cell.rightImgBtn setImage:logoImg forState:UIControlStateNormal];
        else
        {
            NSString *imgUrl = [NSString stringWithFormat:@"%@%@", HTTPURL_IMAGEDATABASE, [[values objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
//            NSLog(@"imgUrl = %@", imgUrl);
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            manager.tag = indexPath.row;
            UIImage *cachedImage = [manager imageWithURL:[NSURL URLWithString:imgUrl]]; // 将需要缓存的图片加载进来
            if (cachedImage)
            {
                [cell.rightImgBtn setImage:cachedImage forState:UIControlStateNormal];
            }
            else
            {
                [manager downloadWithURL:[NSURL URLWithString:imgUrl] delegate:self];
            }

        }
        [cell.rightImgBtn addTarget:self action:@selector(setPerImg) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(indexPath.section == 0 && indexPath.row == 4)
    {
        cell.rightTextField.text = @"";
        cell.rightTextField.alpha = 0;
        cell.rightImgBtn.alpha = 0;
        cell.rightTextView.alpha = 1;
        cell.rightTextView.delegate = self;
        cell.rightTextView.text = [[values objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    else if(indexPath.section == 2 && indexPath.row == 2)
    {
        cell.rightTextField.textColor = [UIColor lightGrayColor];
        cell.rightTextField.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
        [cell.rightTextField setEnabled:NO];
    }
    
    return cell;
}

#pragma mark - SDWebImageManagerDelegate

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    APCell2 *tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:imageManager.tag inSection:0]];
    [tempCell.rightImgBtn setImage:image forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        return 70.0f;
    }
    else if(indexPath.section == 0 && indexPath.row == 4)
    {
        return 90.0f;
    }
    else
        return 30.0f;
}

// 设置个人图片
- (void)setPerImg
{
    UIActionSheet *altSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [altSheet showInView:self.view];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

#pragma mark UITextFieldDelegate

//开始编辑时调整键盘高度
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [mainTable setContentOffset:CGPointMake(0.0f, mainTable.contentOffset.y + 30.0f) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) keyboardWillShow:(NSNotification *) noti
{
    NSDictionary *info = [noti userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyboardHeight = [value CGRectValue].size.height;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [mainTable setContentOffset:CGPointMake(0.0f, 70.0f) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [[values objectAtIndex:0] setObject:textView.text atIndex:4];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    switch (buttonIndex) {
            
//        case 0:
//        {
//            [self.browserView show];
//            return ;
//        }
        case 0:
        {
            // 判断相机是否可用，不可用将sourceType设定为相片库
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        }
        case 1:
        {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            break;
        }
            
        default:
            return ;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentModalViewController:picker animated:YES];//进入照相界面
}


#pragma mark UIImagePickerControllerDelegate

// 照相机照完后use图片或在图片库中点击图片触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 得到图片
    logoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(logoImg, 0.1f);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"logo.jpg"];
    [data writeToFile:fullPathToFile atomically:NO];
    
    data = [NSData dataWithContentsOfFile:fullPathToFile];
    NSString *encodeStr = [GTMBase64 stringByEncodingData:data];     // 保存base64编码
    encodeImageStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)encodeStr, nil, (CFStringRef)@"+/", kCFStringEncodingUTF8));
    
    // 只更新sec0,row0这一行
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [mainTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    mainTable.frame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - AGPhotoBrowserDataSource

- (NSInteger)numberOfPhotosForPhotoBrowser:(AGPhotoBrowserView *)photoBrowser
{
	return 1;
}

- (UIImage *)photoBrowser:(AGPhotoBrowserView *)photoBrowser imageAtIndex:(NSInteger)index
{
    APCell2 *tempCell = (APCell2 *)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImageView *tempImageView;
    tempImageView = tempCell.rightImgBtn.imageView;
	return tempImageView.image;
}

- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser titleForImageAtIndex:(NSInteger)index
{
	return @"数字物业云";
}

- (NSString *)photoBrowser:(AGPhotoBrowserView *)photoBrowser descriptionForImageAtIndex:(NSInteger)index
{
	return @"@物业信息";
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
