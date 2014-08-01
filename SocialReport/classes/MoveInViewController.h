//
//  ResidentDocViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-14.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MyRadioButtonGroup.h"
#import "CommunicationHttp.h"

@interface MoveInViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
{
    Common *myCommon;
    CommunicationHttp *myCommunicationHttp;
    NSMutableArray *paramInfoAry;
    NSString *encodeImageStr;     // 图片base64编码
    
    UIScrollView *bgScrollView;
    UIImageView *portraitImgView;  // 居民头像
    UILabel *searchLbl;     // searchLbl
    UILabel *relationshipValueLbl;     // 与户主关系
    MyRadioButtonGroup *userKindRBtnGroup;      // 用户类型
    
    UIButton *contentShowMoreBtn;
    UIImageView *contentShowBg;
    // 姓名
    UIImageView *nameBg;
    UILabel *nameLbl;
    UITextField *nameText;
    // 性别
    UIImageView *genderBg;
    UILabel *genderLbl;
    MyRadioButtonGroup *genderKindRBtnGroup;      // 性别
    // 民族
    UIImageView *nationBg;
    UILabel *nationLbl;
    UITextField *nationText;
    // 出生日期
    UIImageView *birthdayBg;
    UILabel *birthdayLbl;
    UILabel *birthdayValueLbl;     
    UIButton *birthdayBtn;
    // 地址
    UIImageView *addressBg;
    UILabel *addressLbl;
    UITextField *addressText;
    // 身份证号
    UIImageView *IDNumberBg;
    UILabel *IDNumberLbl;
    UITextField *IDNumberText;
    // 签发机构
    UIImageView *issuingAuthBg;
    UILabel *issuingAuthLbl;
    UITextField *issuingAuthText;
    // 签发日期
    UIImageView *usefulLifeBeginBg;
    UILabel *usefulLifeBeginLbl;
    UILabel *usefulLifeBeginValueLbl;
    UIButton *usefulLifeBeginBtn;
    // 有效日期
    UIImageView *usefulLifeEndBg;
    UILabel *usefulLifeEndLbl;
    UILabel *usefulLifeEndValueLbl;
    UIButton *usefulLifeEndBtn;
//    // JPG格式照片BASE64字符串
//    UIImageView *photoBase64Bg;
//    UILabel *photoBase64Lbl;
//    UITextField *photoBase64Text;
    // 籍贯
    UIImageView *nativePlaceBg;
    UILabel *nativePlaceLbl;
    UITextField *nativePlaceText;
    // 婚姻状况
    UIButton *marriageBtn;
    UILabel *marriageLbl;
    UILabel *marriageValueLbl;
    UIImageView *marriageIco;
    // 联系电话
    UIImageView *phoneNumBg;
    UILabel *phoneNumLbl;
    UITextField *phoneNumText;
    // 文化程度
    UIButton *eduAttainmentsBtn;
    UILabel *eduAttainmentsLbl;
    UILabel *eduAttainmentsValueLbl;
    UIImageView *eduAttainmentsIco;
    // 职业
    UIButton *professionBtn;
    UILabel *professionLbl;
    UILabel *professionValueLbl;
    UIImageView *professionIco;
    // 工作单位
    UIImageView *workUnitBg;
    UILabel *workUnitLbl;
    UITextField *workUnitText;
    // 党派
    UIButton *partyGroupingsBtn;
    UILabel *partyGroupingsLbl;
    UILabel *partyGroupingsValueLbl;
    UIImageView *partyGroupingsIco;
    // 农业或者非农
    UIButton *agriOrNonAgriBtn;
    UILabel *agriOrNonAgriLbl;
    UILabel *agriOrNonAgriValueLbl;
    UIImageView *agriOrNonAgriIco;
    // 结婚时间
    UIImageView *marryDateBg;
    UILabel *marryDateLbl;
    UILabel *marryDateValueLbl;     // 结婚时间
    UIButton *marryDateBtn;
    // 节育情况
    UIButton *birthControlBtn;
    UILabel *birthControlLbl;
    UILabel *birthControlValueLbl;
    UIImageView *birthControlIco;
    // 计生编号
    UIImageView *birthControlNumBg;
    UILabel *birthControlNumLbl;
    UITextField *birthControlNumText;
    // 现户口所在地
    UIImageView *residenceAddrBg;
    UILabel *residenceAddrLbl;
    UITextField *residenceAddrText;
    // 户口从何地迁入本址
    UIImageView *residenceSourceBg;
    UILabel *residenceSourceLbl;
    UITextField *residenceSourceText;
    // 入住日期
    UIImageView *checkInDateBg;
    UILabel *checkInDateLbl;
    UILabel *checkInDateValueLbl;       // 入住日期
    UIButton *checkInDateBtn;
    
    
    UIDatePicker *myDatePicker;     // 时间选择器
    UIActionSheet *myActionSheet;     // 弹出ActionSheet
    NSString *nowDate;      //当前日期
    float keyboardHeight;
}

@end
