//
//  PublishViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-14.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeenToast.h"
#import "Common.h"
#import "MBProgressHUD.h"
#import "CommunicationHttp.h"


@interface PublishViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UIAlertViewDelegate, MBProgressHUDDelegate, UIActionSheetDelegate>
{
    NSMutableArray *photoAry;       // 存储图片数组
    int photoCount;         // 图片计数
    int viewType;       // 页面类型
    Common *myCommon;
    MBProgressHUD *HUD;
    CommunicationHttp *myCommunicationHttp;
    NSDictionary *respDic;        // 回复数据
    int photoStatistics;   // 图片总数
    
    UIScrollView *bgScrollView;
    UIImageView *titleBg;
    UITextField *titleText;
    UITextView *contentView;
    UIImageView *telephoneBg;
    UITextField *telephoneText;
    UIImageView *noteBg;
    UITextField *noteText;
    LeenToast *myLeenToast;
    UILabel *placeholderLbl;
    float keyboardHeight;
    UIImageView *contentBg;
    UIButton *addPhotoBtn;
    
    UIToolbar* toolbarView;     // 键盘工具栏
    BOOL showDelView;       // 是否显示删除图标
}

/*根据页面类型加载不同界面
  viewType:1、3、5-》新信息 2-》评论
 */
- (id)initWithViewType:(int)viewType;

@end
