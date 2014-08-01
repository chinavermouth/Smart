//
//  ListBuildingViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-28.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"

@interface ListBuildingViewController : UITableViewController
{
    NSDictionary *strRespString;        // 回复数据
    CommunicationHttp *myCommunicationHttp;
    NSMutableArray *buildingAry;      // 楼宇列表数据
    Common *myCommon;
}

@end
