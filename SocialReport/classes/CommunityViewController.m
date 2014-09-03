//
//  CommunityViewController.m
//  SocialReport
//
//  Created by J.H on 14-9-3.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "CommunityViewController.h"
#import "GTMBase64.h"

#define LABEL_WIDTH 115
#define TEXT_WIDTH  185

@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"小区信息";
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveFunc)];
    
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
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height + 200);
    [self.view addSubview:bgScrollView];
    
    // add photo button
    frame.origin.x = (bgScrollView.frame.size.width - 90)/2;
    frame.origin.y = 10;
    frame.size.width = 90;
    frame.size.height = 90;
    addPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addPhotoBtn.frame = frame;
    [addPhotoBtn setImage:[UIImage imageNamed:@"addPhoto"] forState:UIControlStateNormal];
    [addPhotoBtn addTarget:self action:@selector(addPhotoFunc) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:addPhotoBtn];
    
    // community name label
    frame.origin.x = 10;
    frame.origin.y += addPhotoBtn.frame.size.height + 15;
    frame.size.width = LABEL_WIDTH;
    frame.size.height = 20;
    UILabel *communityNameLbl = [[UILabel alloc] initWithFrame:frame];
    communityNameLbl.text = @"小区名称：";
    communityNameLbl.font = [UIFont systemFontOfSize:14.0f];
    communityNameLbl.textColor = [UIColor lightGrayColor];
    communityNameLbl.backgroundColor = [UIColor clearColor];
    communityNameLbl.textAlignment = NSTextAlignmentRight;
    [bgScrollView addSubview:communityNameLbl];
    
    // community name text
    frame.origin.x += communityNameLbl.frame.size.width;
    frame.size.width = TEXT_WIDTH;
    frame.size.height = 20;
    commText = [[UITextField alloc] initWithFrame:frame];
    commText.font = [UIFont systemFontOfSize:14.0f];
    commText.textColor = [UIColor blackColor];
    commText.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    commText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    commText.delegate = self;
    commText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:commText];
    
    // separate line
    frame.origin.x = 5;
    frame.origin.y += commText.frame.size.height + 5;
    frame.size.width = bgScrollView.frame.size.width - 2*5;
    frame.size.height = 1;
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:frame];
    [lineImg setImage:[UIImage imageNamed:@"grayLine"]];
    [bgScrollView addSubview:lineImg];
    
    // address label
    frame.origin.x = 10;
    frame.origin.y += lineImg.frame.size.height + 5;
    frame.size.width = LABEL_WIDTH;
    frame.size.height = 20;
    UILabel *addressLbl = [[UILabel alloc] initWithFrame:frame];
    addressLbl.text = @"地址：";
    addressLbl.font = [UIFont systemFontOfSize:14.0f];
    addressLbl.textColor = [UIColor lightGrayColor];
    addressLbl.backgroundColor = [UIColor clearColor];
    addressLbl.textAlignment = NSTextAlignmentRight;
    [bgScrollView addSubview:addressLbl];
    
    // address text
    frame.origin.x += addressLbl.frame.size.width;
    frame.size.width = TEXT_WIDTH;
    frame.size.height = 20;
    addressText = [[UITextField alloc] initWithFrame:frame];
    addressText.font = [UIFont systemFontOfSize:14.0f];
    addressText.textColor = [UIColor blackColor];
    addressText.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    addressText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    addressText.delegate = self;
    addressText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:addressText];
    
    // separate line
    frame.origin.x = 5;
    frame.origin.y += addressText.frame.size.height + 5;
    frame.size.width = bgScrollView.frame.size.width - 2*5;
    frame.size.height = 1;
    lineImg = [[UIImageView alloc] initWithFrame:frame];
    [lineImg setImage:[UIImage imageNamed:@"grayLine"]];
    [bgScrollView addSubview:lineImg];
    
    // principal label
    frame.origin.x = 10;
    frame.origin.y += lineImg.frame.size.height + 5;
    frame.size.width = LABEL_WIDTH;
    frame.size.height = 20;
    UILabel *principalLbl = [[UILabel alloc] initWithFrame:frame];
    principalLbl.text = @"负责人：";
    principalLbl.font = [UIFont systemFontOfSize:14.0f];
    principalLbl.textColor = [UIColor lightGrayColor];
    principalLbl.backgroundColor = [UIColor clearColor];
    principalLbl.textAlignment = NSTextAlignmentRight;
    [bgScrollView addSubview:principalLbl];
    
    // principal text
    frame.origin.x += principalLbl.frame.size.width;
    frame.size.width = TEXT_WIDTH;
    frame.size.height = 20;
    principalText = [[UITextField alloc] initWithFrame:frame];
    principalText.font = [UIFont systemFontOfSize:14.0f];
    principalText.textColor = [UIColor blackColor];
    principalText.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    principalText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    principalText.delegate = self;
    principalText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:principalText];
    
    // separate line
    frame.origin.x = 5;
    frame.origin.y += principalText.frame.size.height + 5;
    frame.size.width = bgScrollView.frame.size.width - 2*5;
    frame.size.height = 1;
    lineImg = [[UIImageView alloc] initWithFrame:frame];
    [lineImg setImage:[UIImage imageNamed:@"grayLine"]];
    [bgScrollView addSubview:lineImg];
    
    // principal phone label
    frame.origin.x = 10;
    frame.origin.y += lineImg.frame.size.height + 5;
    frame.size.width = LABEL_WIDTH;
    frame.size.height = 20;
    UILabel *principalPhoneLbl = [[UILabel alloc] initWithFrame:frame];
    principalPhoneLbl.text = @"负责人电话：";
    principalPhoneLbl.textAlignment = NSTextAlignmentRight;
    principalPhoneLbl.font = [UIFont systemFontOfSize:14.0f];
    principalPhoneLbl.textColor = [UIColor lightGrayColor];
    principalPhoneLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:principalPhoneLbl];
    
    // principal phone text
    frame.origin.x += principalPhoneLbl.frame.size.width;
    frame.size.width = TEXT_WIDTH;
    frame.size.height = 20;
    principalPhoneText = [[UITextField alloc] initWithFrame:frame];
    principalPhoneText.font = [UIFont systemFontOfSize:14.0f];
    principalPhoneText.textColor = [UIColor blackColor];
    principalPhoneText.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    principalPhoneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    principalPhoneText.delegate = self;
    principalPhoneText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:principalPhoneText];
    
    // separate line
    frame.origin.x = 5;
    frame.origin.y += principalPhoneText.frame.size.height + 5;
    frame.size.width = bgScrollView.frame.size.width - 2*5;
    frame.size.height = 1;
    lineImg = [[UIImageView alloc] initWithFrame:frame];
    [lineImg setImage:[UIImage imageNamed:@"grayLine"]];
    [bgScrollView addSubview:lineImg];
    
    // office phone label
    frame.origin.x = 10;
    frame.origin.y += lineImg.frame.size.height + 5;
    frame.size.width = LABEL_WIDTH;
    frame.size.height = 20;
    UILabel *officePhoneLbl = [[UILabel alloc] initWithFrame:frame];
    officePhoneLbl.text = @"办公室电话：";
    officePhoneLbl.textAlignment = NSTextAlignmentRight;
    officePhoneLbl.font = [UIFont systemFontOfSize:14.0f];
    officePhoneLbl.textColor = [UIColor lightGrayColor];
    officePhoneLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:officePhoneLbl];
    
    // office phone text
    frame.origin.x += officePhoneLbl.frame.size.width;
    frame.size.width = TEXT_WIDTH;
    frame.size.height = 20;
    officePhoneText = [[UITextField alloc] initWithFrame:frame];
    officePhoneText.font = [UIFont systemFontOfSize:14.0f];
    officePhoneText.textColor = [UIColor blackColor];
    officePhoneText.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    officePhoneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    officePhoneText.delegate = self;
    officePhoneText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:officePhoneText];
    
    // separate line
    frame.origin.x = 5;
    frame.origin.y += officePhoneText.frame.size.height + 5;
    frame.size.width = bgScrollView.frame.size.width - 2*5;
    frame.size.height = 1;
    lineImg = [[UIImageView alloc] initWithFrame:frame];
    [lineImg setImage:[UIImage imageNamed:@"grayLine"]];
    [bgScrollView addSubview:lineImg];
    
    // duty room label
    frame.origin.x = 10;
    frame.origin.y += lineImg.frame.size.height + 5;
    frame.size.width = LABEL_WIDTH;
    frame.size.height = 20;
    UILabel *dutyRoomLbl = [[UILabel alloc] initWithFrame:frame];
    dutyRoomLbl.text = @"保安值班室电话：";
    dutyRoomLbl.textAlignment = NSTextAlignmentRight;
    dutyRoomLbl.font = [UIFont systemFontOfSize:14.0f];
    dutyRoomLbl.textColor = [UIColor lightGrayColor];
    dutyRoomLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:dutyRoomLbl];
    
    // duty room text
    frame.origin.x += dutyRoomLbl.frame.size.width;
    frame.size.width = TEXT_WIDTH;
    frame.size.height = 20;
    dutyRoomText = [[UITextField alloc] initWithFrame:frame];
    dutyRoomText.font = [UIFont systemFontOfSize:14.0f];
    dutyRoomText.textColor = [UIColor blackColor];
    dutyRoomText.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    dutyRoomText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    dutyRoomText.delegate = self;
    dutyRoomText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:dutyRoomText];
    
    // separate line
    frame.origin.x = 5;
    frame.origin.y += dutyRoomText.frame.size.height + 5;
    frame.size.width = bgScrollView.frame.size.width - 2*5;
    frame.size.height = 1;
    lineImg = [[UIImageView alloc] initWithFrame:frame];
    [lineImg setImage:[UIImage imageNamed:@"grayLine"]];
    [bgScrollView addSubview:lineImg];
    
    // work time label
    frame.origin.x = 10;
    frame.origin.y += lineImg.frame.size.height + 5;
    frame.size.width = LABEL_WIDTH;
    frame.size.height = 20;
    UILabel *workTimeLbl = [[UILabel alloc] initWithFrame:frame];
    workTimeLbl.text = @"上班时间：";
    workTimeLbl.textAlignment = NSTextAlignmentRight;
    workTimeLbl.font = [UIFont systemFontOfSize:14.0f];
    workTimeLbl.textColor = [UIColor lightGrayColor];
    workTimeLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:workTimeLbl];
    
    // work time text
    frame.origin.x += workTimeLbl.frame.size.width;
    frame.size.width = TEXT_WIDTH;
    frame.size.height = 20;
    workTimeText = [[UITextField alloc] initWithFrame:frame];
    workTimeText.font = [UIFont systemFontOfSize:14.0f];
    workTimeText.textColor = [UIColor blackColor];
    workTimeText.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    workTimeText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    workTimeText.delegate = self;
    workTimeText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:workTimeText];
    
    // separate line
    frame.origin.x = 5;
    frame.origin.y += workTimeText.frame.size.height + 5;
    frame.size.width = bgScrollView.frame.size.width - 2*5;
    frame.size.height = 1;
    lineImg = [[UIImageView alloc] initWithFrame:frame];
    [lineImg setImage:[UIImage imageNamed:@"grayLine"]];
    [bgScrollView addSubview:lineImg];
    
    // community summary label
    frame.origin.x = 10;
    frame.origin.y += lineImg.frame.size.height + 5;
    frame.size.width = LABEL_WIDTH;
    frame.size.height = 20;
    UILabel *commSummaryLbl = [[UILabel alloc] initWithFrame:frame];
    commSummaryLbl.text = @"小区简介：";
    commSummaryLbl.textAlignment = NSTextAlignmentRight;
    commSummaryLbl.font = [UIFont systemFontOfSize:14.0f];
    commSummaryLbl.textColor = [UIColor lightGrayColor];
    commSummaryLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:commSummaryLbl];
    
    // work time textView
    frame.origin.x += commSummaryLbl.frame.size.width;
    frame.size.width = TEXT_WIDTH;
    frame.size.height = 100;
    commSummaryText = [[UITextView alloc] initWithFrame:frame];
    commSummaryText.font = [UIFont systemFontOfSize:14.0f];
    commSummaryText.textColor = [UIColor blackColor];
    commSummaryText.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    commSummaryText.delegate = self;
    [bgScrollView addSubview:commSummaryText];
}

// 添加小区logo
- (void)addPhotoFunc
{
    UIActionSheet *altSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [altSheet showInView:self.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initView];
    
    [self getCommunityInfo];
}

// 获取小区信息
- (void)getCommunityInfo
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?communityCode=%@&UID=%@",HTTPURL_GETCOMMUNITYINFO,[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYCODE],[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    NSLog(@"strRequestURL = %@",strRequestURL);
    
    __block MBProgressHUD *HUD;
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^
         {
             // 发送请求
             respDic = [myCommunicationHttp sendHttpRequest:HTTP_GETCOMMUNITYINFO threadType:1 strJsonContent:strRequestURL];
         }
          completionBlock:^
         {
             // 隐藏HUD
             [HUD removeFromSuperview];
             HUD = nil;
             if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
             {
                 NSDictionary *dataDic = [[respDic objectForKey:@"Data"] objectAtIndex:0];
                 
                 commText.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"Name"]];
                 addressText.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"CommunityName"]];
                 principalText.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"Leader"]];
                 principalPhoneText.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"LeaderPhone"]];
                 officePhoneText.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"OfficePhone"]];
                 dutyRoomText.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"SecurityRoomPhone"]];
                 workTimeText.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"OperateTime"]];
                 commSummaryText.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"Summary"]];
                 
                 if(![[dataDic objectForKey:@"LogoUrl"] isEqual:[NSNull null]] && ![[dataDic objectForKey:@"LogoUrl"] isEqualToString:@""])
                 {
                     NSString *strUrl = [NSString stringWithFormat:@"%@%@", HTTPURL_IMAGEDATABASE, [dataDic objectForKey:@"LogoUrl"]];
                     [addPhotoBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]]] forState:UIControlStateNormal];
                 }
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

// 保存小区信息
- (void)saveFunc
{
    if([commText.text isEqualToString:@""])
    {
        [myLeenToast settext:@"小区名称不能为空"];
        [myLeenToast show];
        return;
    }
    else if([addressText.text isEqualToString:@""])
    {
        [myLeenToast settext:@"地址不能为空"];
        [myLeenToast show];
        return;
    }
    
    [commText resignFirstResponder];
    [addressText resignFirstResponder];
    [principalText resignFirstResponder];
    [principalPhoneText resignFirstResponder];
    [officePhoneText resignFirstResponder];
    [dutyRoomText resignFirstResponder];
    [workTimeText resignFirstResponder];
    [commSummaryText resignFirstResponder];
    
    // 设置请求URL
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setValue:[[[respDic objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"ID"] forKey:@"ID"];
    [requestDic setValue:commText.text forKey:@"Name"];
    [requestDic setValue:principalText.text forKey:@"Leader"];
    [requestDic setValue:principalPhoneText.text forKey:@"LeaderPhone"];
    [requestDic setValue:commSummaryText.text forKey:@"Summary"];
    [requestDic setValue:dutyRoomText.text forKey:@"SecurityRoomPhone"];
    [requestDic setValue:officePhoneText.text forKey:@"OfficePhone"];
    [requestDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYCODE] forKey:@"CommunityCode"];
    [requestDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO] forKey:@"CommunityNo"];
    [requestDic setValue:workTimeText.text forKey:@"OperateTime"];
    [requestDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMDISPLAYNAME] forKey:@"CommunityName"];
    [requestDic setValue:encodeImageStr forKey:@"Base64Image"];
    
    NSLog(@"HTTPURL_CREATEORUPDATECOMMINFO requestDic = %@",requestDic);
    NSString *strJsonData = [requestDic JSONRepresentation];
    
    __block MBProgressHUD *HUD;
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.labelText = @"保存中...";
        [HUD showAnimated:YES whileExecutingBlock:^
         {
             // 发送请求
             respDic = [myCommunicationHttp sendHttpRequest:HTTP_CREATEORUPDATECOMMINFO threadType:1 strJsonContent:strJsonData];
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
             }
             else
             {
                 UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alt show];
             }
         }];
    }
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    switch (buttonIndex)
    {
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
    [addPhotoBtn setImage:logoImg forState:UIControlStateNormal];
    NSData *data = UIImageJPEGRepresentation(logoImg, 0.1f);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"logo.jpg"];
    [data writeToFile:fullPathToFile atomically:NO];
    
    data = [NSData dataWithContentsOfFile:fullPathToFile];
    NSString *encodeStr = [GTMBase64 stringByEncodingData:data];     // 保存base64编码
    encodeImageStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)encodeStr, nil, (CFStringRef)@"+/", kCFStringEncodingUTF8));
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


@end
