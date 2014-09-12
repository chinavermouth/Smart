//
//  CommunityViewController.h
//  SocialReport
//
//  Created by J.H on 14-9-3.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"
#import "LeenToast.h"
#import "JSON.h"


@interface CommunityViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    CommunicationHttp *myCommunicationHttp;
    NSDictionary *respDic;
    LeenToast *myLeenToast;
    Common *myCommon;
    
    UIScrollView *bgScrollView;
    UIButton *addPhotoBtn;
    UITextField *commText;
    UITextField *addressText;
    UITextField *principalText;
    UITextField *principalPhoneText;
    UITextField *officePhoneText;
    UITextField *dutyRoomText;
    UITextField *workTimeText;
    UITextView *commSummaryText;
    UIImage *logoImg;     // logo图片
    NSString *encodeImageStr;    // Logo base64编码
}

@end
