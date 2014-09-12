//
//  ReportDetailViewController.m
//  SocialReport
//
//  Created by J.H on 14-4-10.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ReportDetailViewController.h"

#define MARGIN_LEFT 22
#define MARGIN_TOP  10

@interface ReportDetailViewController ()

@end

@implementation ReportDetailViewController

- (id)initWithSubjectId:(NSString *)Id
{
    if(self = [super init])
    {
        subjectId = Id;
        self.title = @"公告详情";
    }
    
    return self;
}

- (void)initView
{
    CGRect frame = CGRectZero;
    
    // 公告标题
    frame.origin.x = MARGIN_LEFT;
    frame.origin.y = MARGIN_TOP + 64;
    if(SYSTEM_VERSION < 7.0)
        frame.origin.y = MARGIN_TOP;
    frame.size.width = SCREEN_SIZE.width - 2 * MARGIN_LEFT;
    frame.size.height = 50;
    titleLbl = [[UILabel alloc] initWithFrame:frame];
    titleLbl.text = titleStr;
    titleLbl.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    titleLbl.numberOfLines = 0;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleLbl];
    
    // 公告作者
    frame.origin.y += titleLbl.frame.size.height + 5;
    frame.size.width = 108;
    frame.size.height = 30;
    authorLbl = [[UILabel alloc] initWithFrame:frame];
    authorLbl.text = @"JimGreen";
    authorLbl.textAlignment = NSTextAlignmentLeft;
    authorLbl.font = [UIFont systemFontOfSize:14.0f];
    authorLbl.textColor = [UIColor lightGrayColor];
    authorLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:authorLbl];
    
    // 公告发布时间
    frame.origin.x += authorLbl.frame.size.width;
    frame.size.width = 168;
    timeLbl = [[UILabel alloc] initWithFrame:frame];
    timeLbl.text = @"2014-03-11";
    timeLbl.textAlignment = NSTextAlignmentRight;
    timeLbl.font = [UIFont systemFontOfSize:14.0f];
    timeLbl.textColor = [UIColor lightGrayColor];
    timeLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeLbl];
    
    // separate line
    frame.origin.x = 5;
    frame.origin.y += authorLbl.frame.size.height + 5;
    frame.size.width = SCREEN_SIZE.width - 2*5;
    frame.size.height = 1;
    UILabel *sepLineLbl = [[UILabel alloc] initWithFrame:frame];
    [sepLineLbl setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:sepLineLbl];
    
    // 公告内容
    frame.origin.x = MARGIN_LEFT;
    frame.origin.y += sepLineLbl.frame.size.height + 10;
    frame.size.width = SCREEN_SIZE.width - 2 * MARGIN_LEFT;
    frame.size.height = self.view.frame.size.height - frame.origin.y - 10;
    if (SYSTEM_VERSION < 7.0)
        frame.size.height = self.view.frame.size.height - frame.origin.y - 10 - 44;
    contentTextView = [[UITextView alloc] initWithFrame:frame];
    contentTextView.text = @"你你你萨克雷锋克拉克发链接阿卡丽金坷垃联发科;安静路费;安静;乱讲了";
    contentTextView.textColor = [UIColor blackColor];
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.editable = NO;
    contentTextView.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:contentTextView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.view setBackgroundColor:[UIColor whiteColor]];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self initView];
        [self getReportDetail];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getReportDetail
{
    // 设置请求URL
    NSString *strRequestURL;
    strRequestURL = [NSString stringWithFormat:@"%@?ID=%@&UID=%@",HTTPURL_REPORTDETAIL,subjectId,[[NSUserDefaults standardUserDefaults] objectForKey:UID]];
    //    NSLog(@"getReportDetail strRequestURL = %@",strRequestURL);
    
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    // 发送登录请求
    NSDictionary *respDic = [myCommunicationHttp sendHttpRequest:HTTP_REPORTDETAIL threadType:1 strJsonContent:strRequestURL];
    
    if([[[respDic objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
    {
        NSDictionary *tempDic = [[respDic objectForKey:@"Data"] objectAtIndex:0];
//        titleStr = [tempDic objectForKey:@"Title"];
        titleLbl.text = [NSString stringWithFormat:@"%@", [tempDic objectForKey:@"Title"]];
        authorLbl.text = [NSString stringWithFormat:@"%@", [tempDic objectForKey:@"Issuer"]];
        timeLbl.text = [NSString stringWithFormat:@"%@", [tempDic objectForKey:@"IssuesTime"]];
        contentTextView.text = [NSString stringWithFormat:@"%@", [tempDic objectForKey:@"Content"]];
    }
    else
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常,请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
    }
}

@end
