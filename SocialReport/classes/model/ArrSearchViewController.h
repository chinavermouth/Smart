//
//  ArrSearchViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-16.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"


@interface ArrSearchViewController : UIViewController <MBProgressHUDDelegate>
{
    Common *myCommon;
    MBProgressHUD *HUD;
    CommunicationHttp *myCommunicationHttp;
    NSDictionary *strRespString;        // 回复数据
    NSMutableString *arrInfoStr;
    
    UIScrollView *bgScrollView;
    UILabel *searchLbl;     // searchLbl
    UILabel *searchBuildingVauleLbl;     // 楼宇号
    UILabel *searchRoomNumVauleLbl;     // 房间号
    UITextView *contentTextView;     // 欠费信息
}

@end
