//
//  PublicReportViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "PublicReportViewController.h"
#import "ChooseRegionViewController.h"

#define PADDING_TOP  15
#define PADDING_LEFT 10


@interface PublicReportViewController ()

@end

@implementation PublicReportViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"发布通知";
    }
    return self;
}

- (void)initData
{
    myCommon = [Common shared];
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    myLeenToast = [[LeenToast alloc] init];
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
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height + 150);
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
    titleText.font = [UIFont systemFontOfSize:14.0f];
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
    contentView.font = [UIFont systemFontOfSize:14.0f];
    contentView.delegate = self;
    [bgScrollView addSubview:contentView];
    
    // contectTextPlaceholder
    frame.origin.x += 7;
    frame.size.height = 30;
    frame.size.width = 60;
    placeholderLbl = [[UILabel alloc] initWithFrame:frame];
    placeholderLbl.text = @"内容";
    placeholderLbl.font = [UIFont systemFontOfSize:14.0f];
    placeholderLbl.textColor = [UIColor lightGrayColor];
    [bgScrollView addSubview:placeholderLbl];
    
    // selRegionBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = contentBg.frame.origin.y + contentBg.frame.size.height + 5;
    frame.size.width = 100;
    frame.size.height = 26;
    UIButton *selRegionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selRegionBtn.frame = frame;
    [selRegionBtn setTitle:@"点击选择小区" forState:UIControlStateNormal];
    [selRegionBtn setBackgroundColor:[UIColor lightGrayColor]];
    [selRegionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selRegionBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [selRegionBtn addTarget:self action:@selector(chooseRegionFunc) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:selRegionBtn];
    
    // selRegionViewBg
    frame.origin.y = selRegionBtn.frame.origin.y + selRegionBtn.frame.size.height + 5;
    frame.size.width = 300;
    frame.size.height = 100;
    UIImageView *selRegionViewBg = [[UIImageView alloc] initWithFrame:frame];
    [selRegionViewBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:selRegionViewBg];
    
    // selRegionView
    frame.origin.x += 10;
    frame.origin.y += 5;
    frame.size.width = 280;
    frame.size.height = 90;
    selRegionView = [[UITextView alloc] initWithFrame:frame];
    selRegionView.text = @"selRegionView\nselRegionView\n";
    selRegionView.textColor = [UIColor blackColor];
    selRegionView.font = [UIFont systemFontOfSize:13.0f];
    selRegionView.editable = NO;
    [bgScrollView addSubview:selRegionView];
    
    // expirationBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = selRegionViewBg.frame.origin.y + selRegionViewBg.frame.size.height + 10;
    frame.size.width = 300;
    frame.size.height = 40;
    UIImageView *expirationBg = [[UIImageView alloc] initWithFrame:frame];
    [expirationBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:expirationBg];
    
    // expirationLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 70;
    UILabel *expirationLbl = [[UILabel alloc] initWithFrame:frame];
    expirationLbl.text = @"过期时间";
    expirationLbl.textAlignment = NSTextAlignmentCenter;
    expirationLbl.textColor = [UIColor blackColor];
    expirationLbl.font = [UIFont systemFontOfSize:14.0f];
    [bgScrollView addSubview:expirationLbl];
    
    // expirationValueLbl
    frame.origin.x += expirationLbl.frame.size.width + 10;
    frame.size.width = 120;
    expirationValueLbl = [[UILabel alloc] initWithFrame:frame];
    // NSDate转成NSString
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC+8"]];     //设置中国时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    nowDate = [dateFormatter stringFromDate:now];
    expirationValueLbl.text = nowDate;
    expirationValueLbl.font = [UIFont systemFontOfSize:14.0f];
    expirationValueLbl.textColor = [UIColor blackColor];
    expirationValueLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:expirationValueLbl];
    
    // expirationValueBtn
    frame.origin.x += expirationValueLbl.frame.size.width;
    frame.origin.y += 5;
    frame.size.width = 80;
    frame.size.height = 30;
    UIButton *expirationValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    expirationValueBtn.frame = frame;
    expirationValueBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [expirationValueBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [expirationValueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [expirationValueBtn setBackgroundColor:[UIColor lightGrayColor]];
    [expirationValueBtn addTarget:self action:@selector(expirationValueBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:expirationValueBtn];
    
    // reportTypeBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = expirationBg.frame.origin.y + expirationBg.frame.size.height + 10;
    frame.size.width = 300;
    frame.size.height = 40;
    UIImageView *reportTypeBg = [[UIImageView alloc] initWithFrame:frame];
    [reportTypeBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:reportTypeBg];
    
    // reportTypeLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 100;
    UILabel *reportTypeLbl = [[UILabel alloc] initWithFrame:frame];
    reportTypeLbl.text = @"发布业主通知";
    reportTypeLbl.textAlignment = NSTextAlignmentCenter;
    reportTypeLbl.textColor = [UIColor blackColor];
    reportTypeLbl.font = [UIFont systemFontOfSize:14.0f];
    [bgScrollView addSubview:reportTypeLbl];
    
    // reportTypeSwitch
    frame.origin.x += reportTypeLbl.frame.size.width + 120;
    frame.origin.y += 5;
    reportTypeSwitch = [[UISwitch alloc] initWithFrame:frame];
    [bgScrollView addSubview:reportTypeSwitch];
    
    // pushMessageBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = reportTypeBg.frame.origin.y + reportTypeBg.frame.size.height + 10;
    frame.size.width = 300;
    frame.size.height = 40;
    UIImageView *pushMessageBg = [[UIImageView alloc] initWithFrame:frame];
    [pushMessageBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:pushMessageBg];
    
    // pushMessageLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 100;
    UILabel *pushMessageLbl = [[UILabel alloc] initWithFrame:frame];
    pushMessageLbl.text = @"发送推送信息";
    pushMessageLbl.textAlignment = NSTextAlignmentCenter;
    pushMessageLbl.textColor = [UIColor blackColor];
    pushMessageLbl.font = [UIFont systemFontOfSize:14.0f];
    [bgScrollView addSubview:pushMessageLbl];
    
    // pushMessageSwitch
    frame.origin.x += pushMessageLbl.frame.size.width + 120;
    frame.origin.y += 5;
    pushMessageSwitch = [[UISwitch alloc] initWithFrame:frame];
    [bgScrollView addSubview:pushMessageSwitch];
    
    // reportBtn
    frame.origin.x = PADDING_LEFT + 5;
    frame.origin.y = pushMessageBg.frame.origin.y + pushMessageBg.frame.size.height + 15;
    frame.size.width = 290;
    frame.size.height = 35;
    UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reportBtn.frame = frame;
    [reportBtn setTitle:@"发布通知" forState:UIControlStateNormal];
    [reportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reportBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [reportBtn setBackgroundColor:[UIColor lightGrayColor]];
    [reportBtn addTarget:self action:@selector(publishFunc) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:reportBtn];
    
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
    if (SCREEN_SIZE.height > 480)
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
    
    // UIActionSheet上添加UIDatePicker
    myDatePicker = [[UIDatePicker alloc] init];
    myDatePicker.datePickerMode = UIDatePickerModeDate;
    [myDatePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)viewWillAppear:(BOOL)animated
{
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
    
    if([myCommon.m_commNameAry count] == 0)
    {
        selRegionView.text = @"将通知发布到以下小区";
    }
    else
    {
        NSMutableString *tempStr = [[NSMutableString alloc] init];
        [tempStr appendString:@"将通知发布到以下小区\n"];
        for(int i=0;i<[myCommon.m_commNameAry count];i++)
        {
            [tempStr appendString:[NSString stringWithFormat:@"==>%@\n",[myCommon.m_commNameAry objectAtIndex:i]]];
        }
        selRegionView.text = tempStr;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    myCommon.m_commCodeAry = [[NSMutableArray alloc] initWithObjects:nil];
    myCommon.m_commNoAry = [[NSMutableArray alloc] initWithObjects:nil];
    myCommon.m_commNameAry = [[NSMutableArray alloc] initWithObjects:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initData];
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    [self initView];
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

//隐藏键盘
- (void)hiddenKeyBoard
{
    [contentView resignFirstResponder];
}

- (void)expirationValueBtnClicked
{
    myActionSheet = [[UIActionSheet alloc] initWithTitle:@"选择日期" delegate:nil cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:@"", nil];
    [myActionSheet addSubview:myDatePicker];
    
    myDatePicker.tag = 1;
    myDatePicker.date = [[NSDate alloc] init];
    [myActionSheet showInView:self.view];
}

// 日期改变
-(void)dateChanged:(id)sender
{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC+8"]];     //设置中国时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate;
    strDate = [dateFormatter stringFromDate:date];
    expirationValueLbl.text = strDate;
}

- (void)chooseRegionFunc
{
    ChooseRegionViewController *chooseRegionViewController = [[ChooseRegionViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:chooseRegionViewController] animated:YES completion:nil];
}

// 发布通知
- (void)publishFunc
{
    if([titleText.text isEqualToString:@""])
    {
        [myLeenToast settext:@"标题不可以为空"];
        [myLeenToast show];
        return ;
    }
    else if([contentView.text isEqualToString:@""])
    {
        [myLeenToast settext:@"内容不可以为空"];
        [myLeenToast show];
        return ;
    }
    else if([myCommon.m_commNameAry count] == 0)
    {
        [myLeenToast settext:@"请先选择要发布的小区"];
        [myLeenToast show];
        return ;
    }
    
//    NSMutableString *tempTimeStr = [[NSMutableString alloc] initWithString:expirationValueLbl.text];
//    [tempTimeStr replaceCharactersInRange:NSMakeRange(4, 1) withString:@""];
//    [tempTimeStr replaceCharactersInRange:NSMakeRange(6, 1) withString:@""];
//    NSLog(@"tempTimeStr = %@",tempTimeStr);
    
    // 设置请求数据
    NSMutableDictionary *dicRequestData = [[NSMutableDictionary alloc] init];
    [dicRequestData setValue:titleText.text forKey:@"title"];
    [dicRequestData setValue:myCommon.m_commCodeAry forKey:@"communityCode"];
    [dicRequestData setValue:myCommon.m_commNoAry forKey:@"communityNo"];
    [dicRequestData setValue:myCommon.m_commNameAry forKey:@"communityName"];
    [dicRequestData setValue:expirationValueLbl.text forKey:@"expirationTime"];
    [dicRequestData setValue:[[NSNumber numberWithBool:reportTypeSwitch.on] stringValue] forKey:@"type"];
    [dicRequestData setValue:contentView.text forKey:@"content"];
    [dicRequestData setValue:[[NSNumber numberWithBool:pushMessageSwitch.on] stringValue] forKey:@"flag"];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERNAME] forKey:@"issuer"];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE] forKey:@"tenantCode"];

    NSLog(@"[dicRequestData JSONRepresentation] = %@",[dicRequestData JSONRepresentation]);
    
    __block NSDictionary *respDic;
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(70, 200, 180, 100)];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"加载中...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            // 发送请求
            respDic = [myCommunicationHttp sendHttpRequest:HTTP_CREATENOTICE threadType:1 strJsonContent:[dicRequestData JSONRepresentation]];
            
        } completionBlock:^{
            // 隐藏HUD
            [HUD removeFromSuperview];
            HUD = nil;
            
            if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
            {
                [myLeenToast settext:@"发布成功~"];
                [myLeenToast show];
                return ;
            }
        }];
    }

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
    
    return YES;
}

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
    if (SCREEN_SIZE.height > 480)
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

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // 键盘消失时需要恢复self.view到0高度
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    
    // 收起工具栏
    if (SCREEN_SIZE.height > 480)
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
}


@end
