//
//  TeneServiceViewController.h
//  SocialReport
//
//  Created by J.H on 14-9-2.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"
#import "CustomIOS7AlertView.h"
#import "LeenToast.h"
#import "JSON.h"

@interface TeneServiceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    CommunicationHttp *myCommunicationHttp;
    NSArray *resPhoneAry;
    LeenToast *myLeenToast;
    
    UILabel *teneLbl;
    UIScrollView *bgScrollView;
    UITableView *numberTable;
    UITextField *nameText;
    UITextField *phoneText;
    UITextField *noteText;
    CustomIOS7AlertView *myAltView;
}

@end
