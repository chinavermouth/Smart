//
//  ResidentDocSearchViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-3-5.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"


@interface ResidentDocViewController : UIViewController <MBProgressHUDDelegate, UITableViewDelegate, UITableViewDataSource>
{
    Common *myCommon;
    MBProgressHUD *HUD;
    CommunicationHttp *myCommunicationHttp;
    NSDictionary *strRespString;        // 回复数据
    NSMutableArray *personInfoArr;
    
    UIScrollView *bgScrollView;
    UILabel *searchLbl;     // searchLbl
    UILabel *searchBuildingVauleLbl;     // 楼宇号
    UILabel *searchRoomNumVauleLbl;     // 房间号
    UIButton *editBtn;
    UITableView *myTableView;
}

@end
