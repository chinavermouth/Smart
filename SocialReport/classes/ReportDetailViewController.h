//
//  ReportDetailViewController.h
//  SocialReport
//
//  Created by J.H on 14-4-10.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"


@interface ReportDetailViewController : UIViewController
{
    NSString *subjectId;        // 主题ID
    CommunicationHttp *myCommunicationHttp;
    
    NSString *titleStr;      // 公告标题
    UILabel *titleLbl;       // 公告标题
    UILabel *authorLbl;      // 公告作者
    UILabel *timeLbl;        // 公告发布时间
    UITextView *contentTextView;     // 公告内容
}

- (id)initWithSubjectId:(NSString *)Id;

@end
