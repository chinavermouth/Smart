//
//  PublicReportViewController.h
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "LeenToast.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"
#import "JSON.h"

@interface PublicReportViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, MBProgressHUDDelegate>
{
    float keyboardHeight;
    NSString *nowDate;      //当前日期
    Common *myCommon;
    LeenToast *myLeenToast;
    MBProgressHUD *HUD;
    CommunicationHttp *myCommunicationHttp;
    
    UIScrollView *bgScrollView;
    UIImageView *titleBg;
    UITextField *titleText;
    UITextView *contentView;
    UILabel *placeholderLbl;
    UIImageView *contentBg;
    UIToolbar* toolbarView;     // 键盘工具栏
    UITextView *selRegionView;
    UILabel *expirationValueLbl;   // 过期时间
    UIActionSheet *myActionSheet;     // 弹出ActionSheet
    UIDatePicker *myDatePicker;     // 时间选择器
    UISwitch *reportTypeSwitch;     // 对内发布开关
    UISwitch *pushMessageSwitch;    // 推送开关
}

@end
