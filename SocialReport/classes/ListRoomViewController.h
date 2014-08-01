//
//  ListRoomViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-3-3.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"

@interface ListRoomViewController : UITableViewController
{
    NSDictionary *strRespString;        // 回复数据
    CommunicationHttp *myCommunicationHttp;
    NSMutableArray *roomAry;      // 房间列表数据
    Common *myCommon;
}

@end
