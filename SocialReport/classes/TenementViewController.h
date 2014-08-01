//
//  TenementViewController.h
//  SocialReport
//
//  Created by J.H on 14-6-6.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationHttp.h"
#import "Common.h"
#import "MBProgressHUD.h"
#import "LeenToast.h"
#import "AGPhotoBrowserView.h"
#import "UIImageView+WebCache.h"


@interface TenementViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, MBProgressHUDDelegate, AGPhotoBrowserDelegate, AGPhotoBrowserDataSource, SDWebImageManagerDelegate>
{
    UITableView *mainTable;
    Common *myCommon;
    NSArray* properties;
    NSMutableArray* values;
    CommunicationHttp *myCommunicationHttp;
    int tagIndex;
    UIImage *logoImg;     // 个人图片
    NSString *encodeImageStr;    // 公司Logo base64编码
    float keyboardHeight;       // 键盘高度
    MBProgressHUD *HUD;
    LeenToast *myLeenToast;
    
    NSString *nameStr;
    NSString *addressStr;
    NSString *codeStr;
    NSString *moblieStr;
    NSString *phoneStr;
    NSString *contectStr;
    NSString *websiteStr;
    NSString *emailStr;
}

@property (nonatomic, strong) AGPhotoBrowserView *browserView;

@end
