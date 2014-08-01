//
//  NightPatrolViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "NightPatrolViewController.h"

#define MAIN_SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define PADDING_LEFT 20


@interface NightPatrolViewController ()

@end

@implementation NightPatrolViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"手机巡更";
    }
    return self;
}

- (void)initView
{
    CGRect frame = self.view.bounds;
    
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = 120;
    frame.size.width = 180;
    frame.size.height = 35;
    twoDimCodeText = [[UITextField alloc] initWithFrame:frame];
    twoDimCodeText.placeholder = @" 二维码";
    twoDimCodeText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    twoDimCodeText.font = [UIFont systemFontOfSize:14.0f];
    twoDimCodeText.textColor = [UIColor blueColor];
    twoDimCodeText.backgroundColor = [UIColor lightGrayColor];
    twoDimCodeText.enabled = NO;
    [self.view addSubview:twoDimCodeText];
    
    frame.origin.x += twoDimCodeText.frame.size.width + 20;
    frame.size.width = 80;
    UIButton *twoDimCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twoDimCodeBtn.frame = frame;
    twoDimCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [twoDimCodeBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [twoDimCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [twoDimCodeBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [twoDimCodeBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [twoDimCodeBtn addTarget:self action:@selector(twoDimCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoDimCodeBtn];
    
    frame.origin.x = (MAIN_SCREEN_SIZE.width - 80)/2;
    frame.origin.y += twoDimCodeText.frame.size.height + 20;
    frame.size.width = 80;
    frame.size.height = 35;
    UIButton *uploadLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadLocBtn.frame = frame;
    uploadLocBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [uploadLocBtn setTitle:@"上传位置" forState:UIControlStateNormal];
    [uploadLocBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uploadLocBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [uploadLocBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [uploadLocBtn addTarget:self action:@selector(uploadLocBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadLocBtn];
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

// 计算百分数坐标
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}

// 扫面动画（运动线）
- (void)moveLineFunc
{
    moveLine.frame = CGRectMake(60, CGRectGetMidY(myReaderView.frame) - 126, 200, 1);
    moveLine.backgroundColor = [UIColor greenColor];
    [self.view addSubview:moveLine];
    NSTimeInterval animationDuration = 1.5f;
    [UIView beginAnimations:@"TwoDimCodeMoveLine" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    moveLine.frame = CGRectMake(60, CGRectGetMidY(myReaderView.frame) - 126 + 200, 200, 1);
    [UIView commitAnimations];
}

// 返回手机巡更主界面
- (void)backNPFunc
{
    [timer invalidate];
    [moveLine removeFromSuperview];
    [myReaderView stop];
    [myReaderView removeFromSuperview];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    self.title = @"手机巡更";
}

// 扫描二维码
-  (void)twoDimCodeBtnClicked
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"手机巡更" style:UIBarButtonItemStylePlain target:self action:@selector(backNPFunc)];
    self.title = @"扫描二维码";
    
    myReaderView = [[ZBarReaderView alloc]init];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        myReaderView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44);
    else
        myReaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    myReaderView.readerDelegate = self;
    // 关闭闪光灯
    myReaderView.torchMode = 0;
    // 扫描区域
    CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(myReaderView.frame) - 126, 200, 200);
    
    // 处理模拟器
    if (TARGET_IPHONE_SIMULATOR)
    {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = myReaderView;
    }
    [self.view addSubview:myReaderView];
    
    // 扫面动画（运动线）
    moveLine = [[UILabel alloc] init];
    [self moveLineFunc];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(moveLineFunc) userInfo:nil repeats:YES];
    
    // 扫描区域计算
    myReaderView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:myReaderView.bounds];
    
    [myReaderView start];
}

// 上传巡更位置
- (void)uploadLocBtnClicked
{
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
}


#pragma mark ZBarReaderViewDelegate

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    for (ZBarSymbol *symbol in symbols)
    {
        twoDimCodeText.text = symbol.data;
        break;
    }
    
    [timer invalidate];
    [moveLine removeFromSuperview];
    [myReaderView stop];
    [myReaderView removeFromSuperview];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    self.title = @"手机巡更";
}

@end
