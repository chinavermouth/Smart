//
//  PersonInfoDetailViewController.m
//  SocialReport
//
//  Created by J.H on 14-4-1.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "PersonInfoDetailViewController.h"
#import "Common.h"

@interface PersonInfoDetailViewController ()

@end

@implementation PersonInfoDetailViewController

- (id)initWithPersonInfoDetail:(NSDictionary *)infoDetail
{
    self = [super init];
    if (self)
    {
        self.title = @"详细信息";
        infoDic = [[NSDictionary alloc] initWithDictionary:infoDetail];
    }
    return self;
}

- (void)initData
{
    arrInfoStr = [[NSMutableString alloc] init];

    [arrInfoStr appendString:[NSString stringWithFormat:@"\n客户名称：%@\n",[infoDic objectForKey:@"ClientName"]]];
    [arrInfoStr appendString:[NSString stringWithFormat:@"证件名称：%@\n",[infoDic objectForKey:@"CertificateName"]]];
    [arrInfoStr appendString:[NSString stringWithFormat:@"身份证号：%@\n",[infoDic objectForKey:@"CertificateNo"]]];
    [arrInfoStr appendString:[NSString stringWithFormat:@"编号（唯一ID）：%@\n",[infoDic objectForKey:@"ClientNo"]]];
    [arrInfoStr appendString:[NSString stringWithFormat:@"客户类型：%@\n",[infoDic objectForKey:@"ClientType"]]];
    if([[infoDic objectForKey:@"CurrentClient"] intValue])
        [arrInfoStr appendString:[NSString stringWithFormat:@"迁出情况：未迁出\n"]];
    else
        [arrInfoStr appendString:[NSString stringWithFormat:@"迁出情况：已迁出\n"]];
    [arrInfoStr appendString:[NSString stringWithFormat:@"入住日期：%@\n",[infoDic objectForKey:@"InDate"]]];
    [arrInfoStr appendString:[NSString stringWithFormat:@"使用人还是业主（空为自然人）：%@\n",[infoDic objectForKey:@"OwnerOrOccupier"]]];
    [arrInfoStr appendString:[NSString stringWithFormat:@"与户主关系：%@\n\n",[infoDic objectForKey:@"RelationshipWithTheHouseholder"]]];

}

- (void)initView
{
    CGRect frame = CGRectZero;
    frame.origin.x = 10;
    if (SYSTEM_VERSION >= 7.0)
        frame.origin.y = 10 + 64;
    else
        frame.origin.y = 10;
    frame.size.width = 300;
    frame.size.height = 30;
    UILabel *titleLable = [[UILabel alloc] initWithFrame:frame];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment = UITextAlignmentLeft;
    titleLable.text = @"人员详细信息:";
    titleLable.textColor = [UIColor blueColor];
    [self.view addSubview:titleLable];
    
    frame.origin.y += titleLable.frame.size.height + 10;
    frame.size.width = 300;
    if (SYSTEM_VERSION >= 7.0)
        frame.size.height = self.view.frame.size.height - frame.origin.y - 20;
    else
        frame.size.height = self.view.frame.size.height - frame.origin.y - 20 - 44;
    infoTextView = [[UITextView alloc] initWithFrame:frame];
    infoTextView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:245/255.0 alpha:1.0];
    infoTextView.textAlignment = UITextAlignmentLeft;
    infoTextView.font = [UIFont systemFontOfSize:15.0f];
//    infoTextView.layer.cornerRadius = 5;
//    infoTextView.layer.borderWidth = 1;
//    infoTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    infoTextView.layer.shadowPath = [UIBezierPath bezierPathWithRect:infoTextView.bounds].CGPath;
    infoTextView.text = arrInfoStr;
    infoTextView.userInteractionEnabled = NO;
    [self.view addSubview:infoTextView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
