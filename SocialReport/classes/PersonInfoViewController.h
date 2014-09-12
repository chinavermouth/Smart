//
//  PersonInfoViewController.h
//  SocialReport
//
//  Created by J.H on 14-9-10.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "CommunicationHttp.h"
#import "MBProgressHUD.h"

@interface PersonInfoViewController : UIViewController
{
    NSString *_userID;
    CommunicationHttp *myCommunicationHttp;
    
    UIScrollView *bgScrollView;
    UILabel *userNameLbl;
    UILabel *telephoneLbl;
    UILabel *emailLbl;
}

- (id)initWithUserID:(NSString *) userId;

@end
