//
//  PublishViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-14.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "PublishViewController.h"
#import "JSON.h"
#import "GTMBase64.h"

#define MAIN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define PADDING_TOP  15
#define PADDING_LEFT 10
#define PHOTO_HEIGHT 260
#define PHOTO_WIDTH  200


@interface PublishViewController ()

@end

@implementation PublishViewController


- (id)initWithViewType:(int)type
{
    self = [super init];
    if (self)
    {
        viewType = type;
        if(viewType == 1 || viewType == 3 || viewType == 5)
            self.title = @"发布信息";
        else if(viewType == 2)
            self.title = @"发表评论";
    }
    return self;
}

- (void)initData
{
    myCommon = [Common shared];
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    
    myLeenToast = [[LeenToast alloc] init];
    photoAry = [[NSMutableArray alloc] init];
}

- (void)initView
{
    CGRect frame = self.view.frame;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height + 20);
    [self.view addSubview:bgScrollView];
    
    // titleBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP;
    frame.size.width = 300;
    frame.size.height = 40;
    titleBg = [[UIImageView alloc] initWithFrame:frame];
    [titleBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:titleBg];
    
    // titleText
    frame.origin.x += 17;
    frame.origin.y += 5;
    frame.size.width = 266;
    frame.size.height = 30;
    titleText = [[UITextField alloc] initWithFrame:frame];
    titleText.placeholder = @"标题";
    titleText.returnKeyType = UIReturnKeyDone;
    titleText.font = [UIFont systemFontOfSize:15.0f];
    titleText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    titleText.delegate = self;
    [bgScrollView addSubview:titleText];
    
    // contentBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP + 10 + titleBg.frame.size.height;
    frame.size.width = 300;
    frame.size.height = 150;
    contentBg = [[UIImageView alloc] initWithFrame:frame];
    [contentBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:contentBg];
    
    // contentText
    frame.origin.x += 10;
    frame.origin.y += 5;
    frame.size.width = 280;
    frame.size.height = 140;
    contentView = [[UITextView alloc] initWithFrame:frame];
    contentView.font = [UIFont systemFontOfSize:15.0f];
    contentView.delegate = self;
    [bgScrollView addSubview:contentView];
    
    // contectTextPlaceholder
    frame.origin.x += 7;
    frame.size.height = 30;
    frame.size.width = 60;
    placeholderLbl = [[UILabel alloc] initWithFrame:frame];
    placeholderLbl.text = @"内容";
    placeholderLbl.font = [UIFont systemFontOfSize:15.0f];
    placeholderLbl.textColor = [UIColor lightGrayColor];
    [bgScrollView addSubview:placeholderLbl];
    
    // telephoneBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = contentBg.frame.origin.y + contentBg.frame.size.height + 10;
    frame.size.width = 300;
    frame.size.height = 45;
    telephoneBg = [[UIImageView alloc] initWithFrame:frame];
    [telephoneBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:telephoneBg];
    
    // telephoneText
    frame.origin.x += 17;
    frame.origin.y += 5;
    frame.size.width = 266;
    frame.size.height = 30;
    telephoneText = [[UITextField alloc] initWithFrame:frame];
    telephoneText.placeholder = @"电话";
    telephoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    telephoneText.returnKeyType = UIReturnKeyDone;
    telephoneText.font = [UIFont systemFontOfSize:15.0f];
    telephoneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    telephoneText.delegate = self;
    [bgScrollView addSubview:telephoneText];
    
    // noteBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = telephoneBg.frame.origin.y + telephoneBg.frame.size.height + 10;
    frame.size.width = 300;
    frame.size.height = 45;
    noteBg = [[UIImageView alloc] initWithFrame:frame];
    [noteBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:noteBg];
    
    // noteText
    frame.origin.x += 17;
    frame.origin.y += 5;
    frame.size.width = 266;
    frame.size.height = 30;
    noteText = [[UITextField alloc] initWithFrame:frame];
    noteText.placeholder = @"备注";
    noteText.returnKeyType = UIReturnKeyDone;
    noteText.font = [UIFont systemFontOfSize:15.0f];
    noteText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    noteText.delegate = self;
    [bgScrollView addSubview:noteText];
    
    // takePhotoBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = noteBg.frame.origin.y + noteBg.frame.size.height + 10;
    frame.size.width = 300;
    frame.size.height = 45;
    addPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addPhotoBtn.frame = frame;
    addPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [addPhotoBtn setTitle:@"添加照片" forState:UIControlStateNormal];
    [addPhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addPhotoBtn setBackgroundColor:[UIColor lightGrayColor]];
    [addPhotoBtn addTarget:self action:@selector(addPhotoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:addPhotoBtn];
    
    // 空白填充按钮
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // 隐藏键盘按钮
    UIButton *hiddenBtnItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    hiddenBtnItem.frame = CGRectMake(0.0f, 0.0f, 70.0f, 30.0f);
    [hiddenBtnItem setTitle:@"隐藏键盘" forState:UIControlStateNormal];
    [hiddenBtnItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hiddenBtnItem setBackgroundColor:[UIColor clearColor]];
    [hiddenBtnItem addTarget:self action:@selector(hiddenKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *hiddenButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hiddenBtnItem];
    
    // 在弹出小键盘上添加工具栏
    if (MAIN_SCREEN_HEIGHT > 480)
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,568,320,40)];
        else
            toolbarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,504,320,40)];
    else
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,480,320,40)];
        else
            toolbarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,416,320,40)];
    toolbarView.barStyle = UIBarStyleDefault;
    toolbarView.items = [NSArray arrayWithObjects:spaceButtonItem, hiddenButtonItem, nil];
    [self.view addSubview:toolbarView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitFunc)];
    
    [self initData];
    [self initView];
    
    // 发表评论时界面
    if(viewType == 2)
    {
        titleBg.alpha = 0;
        titleText.font = [UIFont systemFontOfSize:18.0f];
        titleText.text = myCommon.m_infoTitle;
        titleText.enabled = NO;
        titleText.textAlignment = NSTextAlignmentCenter;
//        takePhotoBtn.frame = CGRectMake(noteBg.frame.origin.x, noteBg.frame.origin.y, 300.0f, 45.0f);
//        noteBg.frame = CGRectMake(telephoneBg.frame.origin.x, telephoneBg.frame.origin.y, telephoneBg.frame.size.width, telephoneBg.frame.size.height);
//        noteText.frame = CGRectMake(telephoneText.frame.origin.x, telephoneText.frame.origin.y, telephoneText.frame.size.width, telephoneText.frame.size.height);
//        [telephoneBg removeFromSuperview];
//        [telephoneText removeFromSuperview];
    }
    
    // 获取键盘高度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击照相
- (void)addPhotoBtnClicked
{
    if(photoStatistics++ >= 6)
    {
        UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"一次最多只能传六张哦~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [myAlt show];
        
        return;
    }
    
    UIActionSheet *altSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [altSheet showInView:self.view];
}

// 提交
- (void)commitFunc
{
    [titleText resignFirstResponder];
    [contentView resignFirstResponder];
    [noteText resignFirstResponder];
    
    if([titleText.text isEqualToString:@""])
    {
        [myLeenToast settext:@"请输入标题"];
        [myLeenToast show];
    }
    else if([contentView.text isEqualToString:@""])
    {
        [myLeenToast settext:@"请输入内容"];
        [myLeenToast show];
    }
    else if([telephoneText.text isEqualToString:@""])
    {
        [myLeenToast settext:@"请输入电话"];
        [myLeenToast show];
    }
    else
    {
        // 取图片
        UIImageView *imgView;
        NSString *encodeImageStr = @"";
        NSMutableArray *encodeImageAry = [[NSMutableArray alloc] init];
        for(int i = 0; i<[photoAry count]; i++)
        {
            imgView = (UIImageView *)[photoAry objectAtIndex:i];
            NSData* imgData = UIImageJPEGRepresentation(imgView.image, 0.05f);   // 压缩图片
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];    // 找到document目录
            NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:@"public.jpg"];    // 确定图片全路径
            [imgData writeToFile:fullPathToFile atomically:NO];    // 本地存入图片
            imgData = [NSData dataWithContentsOfFile:fullPathToFile];    // 取本地图片，并转化为data格式
            encodeImageStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)[GTMBase64 stringByEncodingData:imgData], nil, (CFStringRef)@"+/", kCFStringEncodingUTF8));    // base64编码并转化格式
            [encodeImageAry addObject:encodeImageStr];
        }
        
        // 设置请求参数
        NSMutableDictionary *dicRequestData = [[NSMutableDictionary alloc] init];
        if(viewType == 1)
        {
            [dicRequestData setValue:titleText.text forKey:@"title"];
            [dicRequestData setValue:telephoneText.text forKey:@"tel"];
            [dicRequestData setValue:@"1" forKey:@"type"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE] forKey:@"tenantCode"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO] forKey:@"communityNo"];
            [dicRequestData setValue:contentView.text forKey:@"content"];
            [dicRequestData setValue:encodeImageAry forKey:@"base64Images"];
            [dicRequestData setValue:noteText.text forKey:@"remark"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERID] forKey:@"userID"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERNAME] forKey:@"userName"];
        }
        else if(viewType == 2)
        {
            [dicRequestData setValue:myCommon.m_subjectId forKey:@"ID"];
            [dicRequestData setValue:contentView.text forKey:@"content"];
            [dicRequestData setValue:encodeImageAry forKey:@"base64Images"];
            [dicRequestData setValue:noteText.text forKey:@"remark"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERID] forKey:@"userID"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERNAME] forKey:@"userName"];
            [dicRequestData setValue:telephoneText.text forKey:@"tel"];
        }
        else if(viewType == 3)
        {
            [dicRequestData setValue:titleText.text forKey:@"title"];
            [dicRequestData setValue:telephoneText.text forKey:@"tel"];
            [dicRequestData setValue:@"2" forKey:@"type"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE] forKey:@"tenantCode"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO] forKey:@"communityNo"];
            [dicRequestData setValue:contentView.text forKey:@"content"];
            [dicRequestData setValue:encodeImageAry forKey:@"base64Images"];
            [dicRequestData setValue:noteText.text forKey:@"remark"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERID] forKey:@"userID"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERNAME] forKey:@"userName"];
        }
        else if(viewType == 5)
        {
            [dicRequestData setValue:titleText.text forKey:@"title"];
            [dicRequestData setValue:telephoneText.text forKey:@"tel"];
            [dicRequestData setValue:@"3" forKey:@"type"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE] forKey:@"tenantCode"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO] forKey:@"communityNo"];
            [dicRequestData setValue:contentView.text forKey:@"content"];
            [dicRequestData setValue:encodeImageAry forKey:@"base64Images"];
            [dicRequestData setValue:noteText.text forKey:@"remark"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERID] forKey:@"userID"];
            [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERNAME] forKey:@"userName"];
        }
        // 转换成json格式
        NSString *strJsonData = [NSString stringWithFormat:@"%@",[dicRequestData JSONRepresentation]];
        NSLog(@"strJsonData = %@",strJsonData);
        
        if(HUD == nil)
        {
            HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
            [self.view addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"发布中...";
            [HUD showAnimated:YES whileExecutingBlock:^{
                // 发送登录请求
                if(viewType == 1 || viewType == 3 || viewType == 5)
                    respDic = [myCommunicationHttp sendHttpRequest:HTTP_PUBINFORMATION threadType:1 strJsonContent:strJsonData];
                else if(viewType == 2)
                    respDic = [myCommunicationHttp sendHttpRequest:HTTP_COMINFORMATION threadType:1 strJsonContent:strJsonData];
                
            } completionBlock:^{
                // 隐藏HUD
                [HUD removeFromSuperview];
                HUD = nil;
                
                if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
                {
                    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alt show];
                }
                else if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 2)
                {
                    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发表成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alt show];
                }
                else
                {
                    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alt show];
                }
            }];
        }

    }
}

//隐藏键盘
- (void)hiddenKeyBoard
{
    [contentView resignFirstResponder];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    switch (buttonIndex) {
            
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
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}

#pragma mark UIImagePickerControllerDelegate

// 照相机照完后use图片或在图片库中点击图片触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 得到图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGRect frame = self.view.frame;
    
    // 添加图片
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = addPhotoBtn.frame.origin.y;
    frame.size.width = PHOTO_WIDTH;
    frame.size.height = PHOTO_HEIGHT;
    UIImageView *photoView = [[UIImageView alloc] initWithFrame:frame];
    [photoView setImage:image];
    photoView.userInteractionEnabled = YES;
    [bgScrollView addSubview:photoView];
    
    [photoAry addObject:photoView];
    
    // 添加删除按钮
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = 40;
    frame.size.height = 40;
    UIButton *imgDelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imgDelBtn.frame = frame;
    imgDelBtn.tag = photoCount++;     // 标识删除按钮，传递到alertview
    [imgDelBtn setBackgroundImage:[UIImage imageNamed:@"delPhotoBtn"] forState:UIControlStateNormal];
    [imgDelBtn addTarget:self action:@selector(delPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [photoView addSubview:imgDelBtn];
    
    // 重定位照相按钮位置
    frame.origin.x = photoView.frame.origin.x;
    frame.origin.y = photoView.frame.origin.y + PHOTO_HEIGHT + 10;
    frame.size.width = 300;
    frame.size.height = 45;
    addPhotoBtn.frame = frame;
    
    // 增加bgScrollView的高
    bgScrollView.contentSize = CGSizeMake(320, self.view.frame.size.height - 64 + photoCount * (PHOTO_HEIGHT + 10));
    // 向上滑动bgScrollView
    [bgScrollView setContentOffset:CGPointMake(0.0f, bgScrollView.contentOffset.y + 200)];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)delPhoto:(id)sender
{
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alt show];
    UIButton *myBtn = (UIButton *)sender;
    alt.tag = myBtn.tag;
}

// 点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark UITextFieldDelegate

//开始编辑时调整键盘高度
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(keyboardHeight == 0)
        keyboardHeight = 216;
    CGRect frame = textField.frame;
    CGFloat offset = frame.origin.y - bgScrollView.contentOffset.y + frame.size.height + 70 - (self.view.frame.size.height - keyboardHeight) ;//键盘高度keyboardHeight
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //高度不够，需要调整，抬高self.view到offset的高度
    if(offset > 0)
    {
        [bgScrollView setContentOffset:CGPointMake(0.0f, bgScrollView.contentOffset.y + offset)];
    }
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    // 显示默认值
    if ([contentView.text isEqualToString:@""])
    {
        placeholderLbl.alpha = 1;
    }
    // 隐藏默认值
    else
    {
        placeholderLbl.alpha = 0;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    if ([text isEqualToString:@"\n"]) {
    //        [textView resignFirstResponder];
    //        return NO;
    //    }
    
    return YES;
}

//开始编辑时调整键盘高度
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(keyboardHeight == 0)
        keyboardHeight = 216;
    CGRect frame = textView.frame;
    CGFloat offset = frame.origin.y + frame.size.height + 62 - (self.view.frame.size.height - keyboardHeight) ;//键盘高度keyboardHeight
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //高度不够，需要调整，抬高self.view到offset的高度
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    //高度够了，若上次有抬高self.view，则需要恢复到0高度
    else
    {
        if(self.view.frame.origin.y < 0 )
        {
            CGRect rect = CGRectMake(0.0f, 0.0f,width,height);
            self.view.frame = rect;
        }
        
    }
    
    // 升起工具栏
    if (MAIN_SCREEN_HEIGHT > 480)
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView.frame = CGRectMake(0.0f, 568.0f - (keyboardHeight + 40.0f), 320.0f, 40.0f);
        else
            toolbarView.frame = CGRectMake(0.0f, 504.0f - (keyboardHeight + 40.0f), 320.0f, 40.0f);
    else
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView.frame = CGRectMake(0.0f, offset + 480.0f - (keyboardHeight + 40.0f), 320.0f, 40.0f);
        else
            toolbarView.frame = CGRectMake(0.0f, offset + 416.0f - (keyboardHeight + 40.0f), 320.0f, 40.0f);
    
    [UIView commitAnimations];
}

// 收起小键盘时操作
- (void)textViewDidEndEditing:(UITextView *)textView
{
    // 键盘消失时需要恢复self.view到0高度
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    
    // 收起工具栏
    if (MAIN_SCREEN_HEIGHT > 480)
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView.frame = CGRectMake(0.0f, 568.0f, 320.0f, 40.0f);
        else
            toolbarView.frame = CGRectMake(0.0f, 504.0f, 320.0f, 40.0f);
    else
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView.frame = CGRectMake(0.0f, 480.0f, 320.0f, 40.0f);
        else
            toolbarView.frame = CGRectMake(0.0f, 416.0f, 320.0f, 40.0f);
    
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *) noti
{
    NSDictionary *info = [noti userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyboardHeight = [value CGRectValue].size.height;
    
//    NSLog(@"keyboardHeight:%f", keyboardHeight);  //键盘高度一般216
    ///keyboardWasShown = YES;
}


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        // 设置要移除的照片为不可见
        [[photoAry objectAtIndex:alertView.tag] setAlpha:0];
        // 数组中移除照片对象
        [photoAry removeObjectAtIndex:alertView.tag];

        // 重排照片组
        [self rankPhotos];
        
        // 减少bgScrollView的高
        bgScrollView.contentSize = CGSizeMake(320, bgScrollView.contentSize.height - (PHOTO_HEIGHT + 10));
    }
}

// 重排照片组
- (void)rankPhotos
{
    CGRect frame;
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = noteBg.frame.origin.y + noteBg.frame.size.height + 10;
    frame.size.width = 300;
    frame.size.height = 45;
    addPhotoBtn.frame = frame;
    photoCount = 0;
    
    for(int i = 0; i<[photoAry count]; i++)
    {
        // 添加图片
        frame.origin.x = PADDING_LEFT;
        frame.origin.y = addPhotoBtn.frame.origin.y;
        frame.size.width = PHOTO_WIDTH;
        frame.size.height = PHOTO_HEIGHT;
        UIImageView *photoView = [photoAry objectAtIndex:i];
        photoView.frame = frame;
        [bgScrollView addSubview:photoView];
        
        // 添加删除按钮
        frame.origin.x = 0;
        frame.origin.y = 0;
        frame.size.width = 40;
        frame.size.height = 40;
        UIButton *imgDelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgDelBtn.frame = frame;
        imgDelBtn.tag = photoCount++;     // 标识删除按钮，传递到alertview
        [imgDelBtn setBackgroundImage:[UIImage imageNamed:@"delPhotoBtn"] forState:UIControlStateNormal];
        [imgDelBtn addTarget:self action:@selector(delPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [photoView addSubview:imgDelBtn];
        
        // 重定位照相按钮位置
        frame.origin.x = photoView.frame.origin.x;
        frame.origin.y = photoView.frame.origin.y + PHOTO_HEIGHT + 10;
        frame.size.width = 300;
        frame.size.height = 45;
        addPhotoBtn.frame = frame;
    }
}


@end
