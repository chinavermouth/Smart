//
//  ListPersonViewController.h
//  SocialReport
//
//  Created by J.H on 14-3-28.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"

@interface ListPersonViewController : UITableViewController
{
    NSDictionary *strRespString;        // 回复数据
    CommunicationHttp *myCommunicationHttp;
    NSMutableArray *personAry;      // 人员列表数据
    Common *myCommon;
}

@end
