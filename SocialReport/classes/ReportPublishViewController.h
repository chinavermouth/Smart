//
//  ReportPublishViewController.h
//  From SocialReport
//
//  Update by HuXiaoBin on 14-6-20.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeenToast.h"
#import "Common.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"


@interface ReportPublishViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UIAlertViewDelegate, MBProgressHUDDelegate, UIActionSheetDelegate>
{
    NSMutableArray *photoAry;       // 存储图片数组
    int photoCount;         // 图片计数
    int viewType;       // 页面类型
    Common *myCommon;
    MBProgressHUD *HUD;
    CommunicationHttp *myCommunicationHttp;
    NSDictionary *respDic;        // 回复数据
    
    UIScrollView *bgScrollView;
    UIImageView *titleBg;
    UITextField *titleText;
    UITextView *contentView;
    UIImageView *telephoneBg;
    UITextField *telephoneText;
    UIButton *statusBtn;
    UILabel *statusLbl;
    LeenToast *myLeenToast;
    UILabel *placeholderLbl;
    float keyboardHeight;
    UIImageView *contentBg;
    UIButton *addPhotoBtn;
    
    UIToolbar* toolbarView;     // 键盘工具栏
    BOOL showDelView;       // 是否显示删除图标
}


@end
