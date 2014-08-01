//
//  MoveOutViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"

@interface MoveOutViewController : UIViewController <UIAlertViewDelegate>
{
    Common *myCommon;
    CommunicationHttp *myCommunicationHttp;
    NSDictionary *strRespString;        // 回复数据
    NSMutableDictionary *personInfoDic;
    NSString *personID;     // 客户ID
    
    UIScrollView *bgScrollView;
    UILabel *searchLbl;     // searchLbl
    UILabel *searchRoomNumVauleLbl;     // 房间号
    UILabel *searchBuildingVauleLbl;     // 楼宇号
    UILabel *searchPersonVauleLbl;     // 人员号
}

@end
