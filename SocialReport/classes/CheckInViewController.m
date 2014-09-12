//
//  CheckInViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-16.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "CheckInViewController.h"

#define PADDING_TOP 15
#define PADDING_LEFT 10


@interface CheckInViewController ()

@end

@implementation CheckInViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"访客登记";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
}

- (void)initView
{
    CGRect frame = self.view.frame;
    frame.origin.x = PADDING_LEFT;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        frame.origin.y = 20 + 44 + PADDING_TOP;
    else
        frame.origin.y = PADDING_TOP;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT;
    frame.size.height = 45;
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.frame = frame;
    takePhotoBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [takePhotoBtn setTitle:@"马上拍照" forState:UIControlStateNormal];
    [takePhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePhotoBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 首页" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    [self initView];
    
    // 一点击就调用拍照功能
    [self takePhotoBtnClicked];
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

- (void)takePhotoBtnClicked
{
    //先设定sourceType为相机，然后判断相机是否可用，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}


#pragma mark UIImagePickerControllerDelegate

//照相机照完后use图片或在图片库中点击图片触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
