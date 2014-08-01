//
//  ChooseRegionViewController.h
//  SocialReport
//
//  Created by J.H on 14-6-9.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"
#import "MBProgressHUD.h"

@interface ChooseRegionViewController : UIViewController <MBProgressHUDDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *strRespString;        // 回复数据
    CommunicationHttp *myCommunicationHttp;
    NSMutableArray *regionAry;      // 小区列表数据
    Common *myCommon;
    MBProgressHUD *HUD;
    
    UITableView *mainTable;
}

@end
