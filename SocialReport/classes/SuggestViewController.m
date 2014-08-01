//
//  SuggestViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-17.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "SuggestViewController.h"

#define MAIN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define PADDING_TOP 15
#define PADDING_LEFT 15


@interface SuggestViewController ()

@end

@implementation SuggestViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"业主建议";
    }
    return self;
}

- (void)initView
{
    CGRect frame = self.view.frame;
    
    // suggestLbl
    frame.origin.x = PADDING_LEFT;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        frame.origin.y = 20 + 44 + PADDING_TOP;
    else
        frame.origin.y = PADDING_TOP;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT;
    frame.size.height = 20;
    UILabel *suggestLbl = [[UILabel alloc] initWithFrame:frame];
    suggestLbl.text = @"业主建议";
    suggestLbl.textColor = [UIColor blueColor];
    suggestLbl.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:suggestLbl];
    
    // suggestBg
    frame.origin.y += suggestLbl.frame.size.height + PADDING_TOP;
    frame.size.height = 120;
    UIImageView *suggestBg = [[UIImageView alloc] initWithFrame:frame];
    [suggestBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [self.view addSubview:suggestBg];
    
    // suggestTextView
    frame.origin.y += 5;
    frame.origin.x += 5;
    frame.size.height = 110;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - 10;
    suggestTextView = [[UITextView alloc] initWithFrame:frame];
    suggestTextView.font = [UIFont systemFontOfSize:16.0f];
    suggestTextView.delegate = self;
    [self.view addSubview:suggestTextView];
    
    // suggestCommitBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = suggestBg.frame.origin.y + suggestBg.frame.size.height + 10;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT;
    frame.size.height = 40;
    UIButton *suggestCommitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    suggestCommitBtn.frame = frame;
    suggestCommitBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [suggestCommitBtn setTitle:@"意见提交" forState:UIControlStateNormal];
    [suggestCommitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [suggestCommitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [suggestCommitBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [suggestCommitBtn addTarget:self action:@selector(suggestCommitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:suggestCommitBtn];
    
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
    
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    [self initView];
    
    myLeenToast = [[LeenToast alloc] init];
    
    // 获取键盘高度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏键盘
- (void)hiddenKeyBoard
{
    [suggestTextView resignFirstResponder];
}

- (void)backFunc
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)suggestCommitBtnClicked
{
    if ([suggestTextView.text isEqualToString:@""])
    {
        [myLeenToast settext:@"意见不能为空~"];
        [myLeenToast show];
    }
    else
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
    }
}

#pragma mark UITextViewDelegate

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
    CGFloat offset = frame.origin.y + frame.size.height + 70 - (self.view.frame.size.height - keyboardHeight) ;//键盘高度keyboardHeight
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

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    // 键盘消失时需要恢复self.view到0高度
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
//    self.view.frame = rect;
//    [UIView commitAnimations];
//    [textField resignFirstResponder];
//    return YES;
//}

- (void) keyboardWillShow:(NSNotification *) noti
{
    NSDictionary *info = [noti userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyboardHeight = [value CGRectValue].size.height;
    
    NSLog(@"keyboardHeight:%f", keyboardHeight);  //键盘高度一般216
    ///keyboardWasShown = YES;
}

@end
