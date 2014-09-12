//
//  ResidentDocViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-14.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "MoveInViewController.h"
#import "MoveOutViewController.h"
#import "ListBuildingViewController.h"
#import "ListRoomViewController.h"
#import "JSON.h"

#define MAIN_SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define PADDING_LEFT 10
#define PADDING_TOP 5
#define TEXTPADDING_LEFT 15

#define IMAGE_CELL_HEIGHT 40
#define IMAGE_CELL_WIDTH MAIN_SCREEN_SIZE.width - 2*PADDING_LEFT

@interface MoveInViewController ()

@end

@implementation MoveInViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"人员迁入";
    }
    return self;
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.frame;
    
    // bgScrollView
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        frame.size.height -= 45;
    else
    {
        frame.origin.y = 0;
        frame.size.height -= self.navigationController.navigationBar.bounds.size.height + 45;
    }
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        bgScrollView.contentSize = CGSizeMake(320, frame.size.height);
    else
        bgScrollView.contentSize = CGSizeMake(320, frame.size.height + 50);
    [self.view addSubview:bgScrollView];
    
    // searchLbl
    frame.origin.x = 20;
    frame.origin.y = 15;
    frame.size.width = 280;
    frame.size.height = 30;
    searchLbl = [[UILabel alloc] initWithFrame:frame];
    searchLbl.text = @"必填资料";
    searchLbl.textColor = [UIColor blueColor];
    searchLbl.font = [UIFont systemFontOfSize:18.0f];
    [bgScrollView addSubview:searchLbl];
    
    // portraitLbl
    frame.origin.x = PADDING_LEFT + TEXTPADDING_LEFT;
    frame.origin.y += searchLbl.frame.size.height + PADDING_TOP + 20;
    frame.size.width = 60;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UILabel *portraitLbl = [[UILabel alloc] initWithFrame:frame];
    portraitLbl.text = @"个人照";
    portraitLbl.backgroundColor = [UIColor clearColor];
    portraitLbl.textAlignment = NSTextAlignmentLeft;
    portraitLbl.font = [UIFont systemFontOfSize:16.0f];
    [bgScrollView addSubview:portraitLbl];
    
    // portraitImgView
    frame.origin.x += portraitLbl.frame.size.width + 5;
    frame.origin.y -= 20;
    frame.size.width = 70;
    frame.size.height = 70;
    portraitImgView = [[UIImageView alloc] initWithFrame:frame];
    portraitImgView.image = [UIImage imageNamed:@"person"];
    [bgScrollView addSubview:portraitImgView];
    
    // addPhotoButton
    frame.origin.x += portraitImgView.frame.size.width + 75;
    frame.origin.y += 25;
    frame.size.width = 60;
    frame.size.height = 30;
    UIButton *addPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addPhotoBtn.frame = frame;
    [addPhotoBtn setTitle:@"添加照片" forState:UIControlStateNormal];
    [addPhotoBtn setTintColor:[UIColor blackColor]];
    addPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [addPhotoBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [addPhotoBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [addPhotoBtn addTarget:self action:@selector(addPhotoFunc) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:addPhotoBtn];
    
    // nameBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = portraitLbl.frame.origin.y + portraitLbl.frame.size.height + PADDING_TOP + 20;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    nameBg = [[UIImageView alloc] initWithFrame:frame];
    [nameBg setImage:[UIImage imageNamed:@"box1"]];
    [bgScrollView addSubview:nameBg];
    
    // nameLbl
    frame.origin.x += TEXTPADDING_LEFT;
    frame.origin.y = nameBg.frame.origin.y;
    frame.size.width = 80;
    frame.size.height = IMAGE_CELL_HEIGHT;
    nameLbl = [[UILabel alloc] initWithFrame:frame];
    nameLbl.text = @"姓名:";
    [[nameLbl font] fontWithSize:16.0f];
    nameLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:nameLbl];
    
    // nameText
    frame.origin.x += nameLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    nameText = [[UITextField alloc] initWithFrame:frame];
    nameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameText.font = [UIFont systemFontOfSize:16.0f];
    nameText.placeholder = @"姓名";
    nameText.delegate = self;
    nameText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:nameText];
    
    // IDNumberBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = nameBg.frame.origin.y + nameBg.frame.size.height;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    IDNumberBg = [[UIImageView alloc] initWithFrame:frame];
    [IDNumberBg setImage:[UIImage imageNamed:@"box3"]];
    [bgScrollView addSubview:IDNumberBg];
    
    // IDNumberLbl
    frame.origin.x += TEXTPADDING_LEFT;
    frame.origin.y = IDNumberBg.frame.origin.y;
    frame.size.width = 80;
    frame.size.height = IMAGE_CELL_HEIGHT;
    IDNumberLbl = [[UILabel alloc] initWithFrame:frame];
    IDNumberLbl.text = @"身份证号:";
    [[IDNumberLbl font] fontWithSize:16.0f];
    IDNumberLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:IDNumberLbl];
    
    // IDNumberText
    frame.origin.x += IDNumberLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    IDNumberText = [[UITextField alloc] initWithFrame:frame];
    IDNumberText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    IDNumberText.font = [UIFont systemFontOfSize:16.0f];
    IDNumberText.placeholder = @"身份证号";
    IDNumberText.delegate = self;
    IDNumberText.returnKeyType = UIReturnKeyDone;
    [bgScrollView addSubview:IDNumberText];

    // relationshipBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = IDNumberBg.frame.origin.y + IDNumberBg.frame.size.height;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UIButton *relationshipBtn = [[UIButton alloc]initWithFrame:frame];
    relationshipBtn.tag = 1;
    relationshipBtn.backgroundColor = [UIColor clearColor];
    [relationshipBtn setTitle:@"" forState:UIControlStateNormal];
    [relationshipBtn addTarget:self action:@selector(getParamValues:) forControlEvents:UIControlEventTouchUpInside];
    [relationshipBtn setBackgroundImage:[UIImage imageNamed:@"box3.png"] forState:UIControlStateNormal];
    [relationshipBtn setBackgroundImage:[UIImage imageNamed:@"box3_h.png"] forState:UIControlStateHighlighted];
    [bgScrollView addSubview:relationshipBtn];
    
    // relationshipLbl
    frame.origin.x += TEXTPADDING_LEFT;
    frame.origin.y = relationshipBtn.frame.origin.y;
    frame.size.width = 80;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UILabel *relationshipLbl = [[UILabel alloc] initWithFrame:frame];
    relationshipLbl.backgroundColor = [UIColor clearColor];
    relationshipLbl.textAlignment = NSTextAlignmentLeft;
    relationshipLbl.font = [UIFont systemFontOfSize:16.0f];
    relationshipLbl.text = @"与户主关系";
    [bgScrollView addSubview:relationshipLbl];
    
    // relationshipValueLbl
    frame.origin.x += relationshipLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    relationshipValueLbl = [[UILabel alloc] initWithFrame:frame];
    relationshipValueLbl.backgroundColor = [UIColor clearColor];
    relationshipValueLbl.textAlignment = NSTextAlignmentCenter;
    relationshipValueLbl.font = [UIFont systemFontOfSize:16.0f];
    relationshipValueLbl.text = @"";
    [bgScrollView addSubview:relationshipValueLbl];
    
    // relationshipIco
    frame.origin.x = relationshipBtn.frame.origin.x + relationshipBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    UIImageView *relationshipIco = [[UIImageView alloc] initWithFrame:frame];
    relationshipIco.image = [UIImage imageNamed:@"arrow_down"];
    [bgScrollView addSubview:relationshipIco];
    
    // userKindBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = relationshipBtn.frame.origin.y + relationshipBtn.frame.size.height;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    UIImageView *userKindBg = [[UIImageView alloc] initWithFrame:frame];
    [userKindBg setImage:[UIImage imageNamed:@"box2"]];
    [bgScrollView addSubview:userKindBg];
    
    // userKindRBtnGroup
    // ownerRadioButton
    MyRadioButton *ownerRadioButton = [[MyRadioButton alloc] initWithTitle:@"业主" andIndex:0 withFrame:frame autoSubSize:NO];
    [ownerRadioButton setSelected:NO];
    
    // UserRadioButton
    MyRadioButton *UserRadioButton = [[MyRadioButton alloc] initWithTitle:@"使用人" andIndex:1 withFrame:frame autoSubSize:NO];
    [UserRadioButton setSelected:NO];
    
    // userKindRBtnGroup
    frame.origin.x = userKindBg.frame.origin.x + PADDING_LEFT;
    frame.origin.y = userKindBg.frame.origin.y + 10;
    frame.size.width = 300;
    frame.size.height = 20;
    userKindRBtnGroup = [[MyRadioButtonGroup alloc] initWithFrame:frame];
    [userKindRBtnGroup addRadioButton:ownerRadioButton];
    [userKindRBtnGroup addRadioButton:UserRadioButton];
    userKindRBtnGroup.direction = Horizontal;
    // 默认选项
    [userKindRBtnGroup setDefaultSeletedWithIndex:0];
    [bgScrollView addSubview:userKindRBtnGroup];
    
    // contentLbl
    frame.origin.x = 20;
    frame.origin.y = userKindBg.frame.origin.y + userKindBg.frame.size.height + PADDING_TOP;
    frame.size.width = 80;
    frame.size.height = 30;
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:frame];
    contentLbl.text = @"选填资料";
    contentLbl.textColor = [UIColor blueColor];
    [[contentLbl font] fontWithSize:18.0f];
    [bgScrollView addSubview:contentLbl];
    
    // contentShowBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y += contentLbl.frame.size.height + PADDING_TOP;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    contentShowBg = [[UIImageView alloc] initWithFrame:frame];
    [contentShowBg setImage:[UIImage imageNamed:@"box"]];
    [bgScrollView addSubview:contentShowBg];
    
    // contentShowMoreBtn
    frame.origin.x += PADDING_LEFT;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    contentShowMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    contentShowMoreBtn.frame = frame;
    [contentShowMoreBtn setImage:[UIImage imageNamed:@"showMore@2x.png"] forState:UIControlStateNormal];
    [contentShowMoreBtn setImage:[UIImage imageNamed:@"showMore_h@2x.png"] forState:UIControlStateSelected];
    [contentShowMoreBtn addTarget:self action:@selector(contentShowMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:contentShowMoreBtn];
    
    // contentShowMoreLbl
    frame.origin.x += contentShowMoreBtn.frame.size.width + PADDING_LEFT;
    frame.size.width = 240;
    UILabel *contentShowMoreLbl = [[UILabel alloc] initWithFrame:frame];
    contentShowMoreLbl.text = @"显示更多信息";
    contentShowMoreLbl.font = [UIFont systemFontOfSize:16.0f];
    contentShowMoreLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:contentShowMoreLbl];
    
    // genderBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = contentShowBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    genderBg = [[UIImageView alloc] initWithFrame:frame];
    [genderBg setImage:[UIImage imageNamed:@"box3"]];
    genderBg.alpha = 0;
    [bgScrollView addSubview:genderBg];
    
    // genderLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 50;
    genderLbl = [[UILabel alloc] initWithFrame:frame];
    genderLbl.text = @"性别:";
    [[genderLbl font] fontWithSize:16.0f];
    genderLbl.backgroundColor = [UIColor clearColor];
    genderLbl.alpha = 0;
    [bgScrollView addSubview:genderLbl];
    
    // genderKindRBtnGroup
    MyRadioButton *maleRadioButton = [[MyRadioButton alloc] initWithTitle:@"男" andIndex:0 withFrame:frame autoSubSize:NO];
    [maleRadioButton setSelected:NO];
    MyRadioButton *femaleRadioButton = [[MyRadioButton alloc] initWithTitle:@"女" andIndex:1 withFrame:frame autoSubSize:NO];
    [femaleRadioButton setSelected:NO];
    
    frame.origin.x = genderLbl.frame.origin.x + genderLbl.frame.size.width + PADDING_LEFT;
    frame.origin.y = genderLbl.frame.origin.y + 10;
    frame.size.width = 180;
    frame.size.height = 20;
    genderKindRBtnGroup = [[MyRadioButtonGroup alloc] initWithFrame:frame];
    [genderKindRBtnGroup addRadioButton:maleRadioButton];
    [genderKindRBtnGroup addRadioButton:femaleRadioButton];
    genderKindRBtnGroup.direction = Horizontal;
    genderKindRBtnGroup.alpha = 0;
    // 默认选项
    [genderKindRBtnGroup setDefaultSeletedWithIndex:0];
    [bgScrollView addSubview:genderKindRBtnGroup];
    
    // nationBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = genderBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    nationBg = [[UIImageView alloc] initWithFrame:frame];
    [nationBg setImage:[UIImage imageNamed:@"box3"]];
    nationBg.alpha = 0;
    [bgScrollView addSubview:nationBg];
    
    // nationLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    nationLbl = [[UILabel alloc] initWithFrame:frame];
    nationLbl.text = @"民族:";
    [[nationLbl font] fontWithSize:16.0f];
    nationLbl.backgroundColor = [UIColor clearColor];
    nationLbl.alpha = 0;
    [bgScrollView addSubview:nationLbl];
    
    // nationText
    frame.origin.x += nationLbl.frame.size.width;
    frame.size.width = 200;
    nationText = [[UITextField alloc] initWithFrame:frame];
    nationText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nationText.font = [UIFont systemFontOfSize:16.0f];
    nationText.placeholder = @"民族";
    nationText.delegate = self;
    nationText.returnKeyType = UIReturnKeyDone;
    nationText.alpha = 0;
    [bgScrollView addSubview:nationText];
    
    // birthdayBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = nationBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    birthdayBg = [[UIImageView alloc] initWithFrame:frame];
    [birthdayBg setImage:[UIImage imageNamed:@"box3"]];
    birthdayBg.alpha = 0;
    [bgScrollView addSubview:birthdayBg];
    
    // birthdayLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    birthdayLbl = [[UILabel alloc] initWithFrame:frame];
    birthdayLbl.text = @"出生日期:";
    [[birthdayLbl font] fontWithSize:16.0f];
    birthdayLbl.backgroundColor = [UIColor clearColor];
    birthdayLbl.alpha = 0;
    [bgScrollView addSubview:birthdayLbl];
    
    // birthdayValueLbl
    frame.origin.x += birthdayLbl.frame.size.width;
    frame.size.width = 120;
    birthdayValueLbl = [[UILabel alloc] initWithFrame:frame];
    // NSDate转成NSString
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC+8"]];     //设置中国时区
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    nowDate = [dateFormatter stringFromDate:now];
//    birthdayValueLbl.text = nowDate;
    [[birthdayValueLbl font] fontWithSize:16.0f];
    birthdayValueLbl.backgroundColor = [UIColor clearColor];
    birthdayValueLbl.alpha = 0;
    [bgScrollView addSubview:birthdayValueLbl];
    
    // birthdayBtn
    frame.origin.x += birthdayValueLbl.frame.size.width;
    frame.origin.y += 5;
    frame.size.width = 80;
    frame.size.height = 30;
    birthdayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    birthdayBtn.frame = frame;
    birthdayBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [birthdayBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [birthdayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [birthdayBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [birthdayBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [birthdayBtn addTarget:self action:@selector(birthdayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    birthdayBtn.alpha = 0;
    [bgScrollView addSubview:birthdayBtn];
    
    // addressBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = birthdayBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    addressBg = [[UIImageView alloc] initWithFrame:frame];
    [addressBg setImage:[UIImage imageNamed:@"box3"]];
    addressBg.alpha = 0;
    [bgScrollView addSubview:addressBg];
    
    // addressLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    addressLbl = [[UILabel alloc] initWithFrame:frame];
    addressLbl.text = @"地址:";
    [[addressLbl font] fontWithSize:16.0f];
    addressLbl.backgroundColor = [UIColor clearColor];
    addressLbl.alpha = 0;
    [bgScrollView addSubview:addressLbl];
    
    // addressText
    frame.origin.x += addressLbl.frame.size.width;
    frame.size.width = 200;
    addressText = [[UITextField alloc] initWithFrame:frame];
    addressText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    addressText.font = [UIFont systemFontOfSize:16.0f];
    addressText.placeholder = @"地址";
    addressText.delegate = self;
    addressText.returnKeyType = UIReturnKeyDone;
    addressText.alpha = 0;
    [bgScrollView addSubview:addressText];

    // issuingAuthBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = addressBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    issuingAuthBg = [[UIImageView alloc] initWithFrame:frame];
    [issuingAuthBg setImage:[UIImage imageNamed:@"box3"]];
    issuingAuthBg.alpha = 0;
    [bgScrollView addSubview:issuingAuthBg];
    
    // issuingAuthLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    issuingAuthLbl = [[UILabel alloc] initWithFrame:frame];
    issuingAuthLbl.text = @"签发机构:";
    [[issuingAuthLbl font] fontWithSize:16.0f];
    issuingAuthLbl.backgroundColor = [UIColor clearColor];
    issuingAuthLbl.alpha = 0;
    [bgScrollView addSubview:issuingAuthLbl];
    
    // issuingAuthText
    frame.origin.x += issuingAuthLbl.frame.size.width;
    frame.size.width = 200;
    issuingAuthText = [[UITextField alloc] initWithFrame:frame];
    issuingAuthText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    issuingAuthText.font = [UIFont systemFontOfSize:16.0f];
    issuingAuthText.placeholder = @"机构名称";
    issuingAuthText.delegate = self;
    issuingAuthText.returnKeyType = UIReturnKeyDone;
    issuingAuthText.alpha = 0;
    [bgScrollView addSubview:issuingAuthText];
    
    // usefulLifeBeginBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = issuingAuthBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    usefulLifeBeginBg = [[UIImageView alloc] initWithFrame:frame];
    [usefulLifeBeginBg setImage:[UIImage imageNamed:@"box3"]];
    usefulLifeBeginBg.alpha = 0;
    [bgScrollView addSubview:usefulLifeBeginBg];
    
    // usefulLifeBeginLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    usefulLifeBeginLbl = [[UILabel alloc] initWithFrame:frame];
    usefulLifeBeginLbl.text = @"签发日期:";
    [[usefulLifeBeginLbl font] fontWithSize:16.0f];
    usefulLifeBeginLbl.backgroundColor = [UIColor clearColor];
    usefulLifeBeginLbl.alpha = 0;
    [bgScrollView addSubview:usefulLifeBeginLbl];
    
    // usefulLifeBeginValueLbl
    frame.origin.x += usefulLifeBeginLbl.frame.size.width;
    frame.size.width = 120;
    usefulLifeBeginValueLbl = [[UILabel alloc] initWithFrame:frame];
//    usefulLifeBeginValueLbl.text = nowDate;
    [[usefulLifeBeginValueLbl font] fontWithSize:16.0f];
    usefulLifeBeginValueLbl.backgroundColor = [UIColor clearColor];
    usefulLifeBeginValueLbl.alpha = 0;
    [bgScrollView addSubview:usefulLifeBeginValueLbl];
    
    // usefulLifeBeginBtn
    frame.origin.x += usefulLifeBeginValueLbl.frame.size.width;
    frame.origin.y += 5;
    frame.size.width = 80;
    frame.size.height = 30;
    usefulLifeBeginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    usefulLifeBeginBtn.frame = frame;
    usefulLifeBeginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [usefulLifeBeginBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [usefulLifeBeginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [usefulLifeBeginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [usefulLifeBeginBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [usefulLifeBeginBtn addTarget:self action:@selector(usefulLifeBeginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    usefulLifeBeginBtn.alpha = 0;
    [bgScrollView addSubview:usefulLifeBeginBtn];
    
    // usefulLifeEndBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = usefulLifeBeginBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    usefulLifeEndBg = [[UIImageView alloc] initWithFrame:frame];
    [usefulLifeEndBg setImage:[UIImage imageNamed:@"box3"]];
    usefulLifeEndBg.alpha = 0;
    [bgScrollView addSubview:usefulLifeEndBg];
    
    // usefulLifeEndLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    usefulLifeEndLbl = [[UILabel alloc] initWithFrame:frame];
    usefulLifeEndLbl.text = @"有效日期:";
    [[usefulLifeEndLbl font] fontWithSize:16.0f];
    usefulLifeEndLbl.backgroundColor = [UIColor clearColor];
    usefulLifeEndLbl.alpha = 0;
    [bgScrollView addSubview:usefulLifeEndLbl];
    
    // usefulLifeEndValueLbl
    frame.origin.x += usefulLifeEndLbl.frame.size.width;
    frame.size.width = 120;
    usefulLifeEndValueLbl = [[UILabel alloc] initWithFrame:frame];
//    usefulLifeEndValueLbl.text = nowDate;
    [[usefulLifeEndValueLbl font] fontWithSize:16.0f];
    usefulLifeEndValueLbl.backgroundColor = [UIColor clearColor];
    usefulLifeEndValueLbl.alpha = 0;
    [bgScrollView addSubview:usefulLifeEndValueLbl];
    
    // usefulLifeEndBtn
    frame.origin.x += usefulLifeEndValueLbl.frame.size.width;
    frame.origin.y += 5;
    frame.size.width = 80;
    frame.size.height = 30;
    usefulLifeEndBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    usefulLifeEndBtn.frame = frame;
    usefulLifeEndBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [usefulLifeEndBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [usefulLifeEndBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [usefulLifeEndBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [usefulLifeEndBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [usefulLifeEndBtn addTarget:self action:@selector(usefulLifeEndBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    usefulLifeEndBtn.alpha = 0;
    [bgScrollView addSubview:usefulLifeEndBtn];
    
//    // photoBase64Bg
//    frame.origin.x = PADDING_LEFT;
//    frame.origin.y = usefulLifeEndBg.frame.origin.y + IMAGE_CELL_HEIGHT;
//    frame.size.width = IMAGE_CELL_WIDTH;
//    frame.size.height = IMAGE_CELL_HEIGHT;
//    photoBase64Bg = [[UIImageView alloc] initWithFrame:frame];
//    [photoBase64Bg setImage:[UIImage imageNamed:@"box3"]];
//    photoBase64Bg.alpha = 0;
//    [bgScrollView addSubview:photoBase64Bg];
//    
//    // photoBase64Lbl
//    frame.origin.x += PADDING_LEFT;
//    frame.size.width = 80;
//    photoBase64Lbl = [[UILabel alloc] initWithFrame:frame];
//    photoBase64Lbl.text = @"JPG照片:";
//    [[photoBase64Lbl font] fontWithSize:16.0f];
//    photoBase64Lbl.backgroundColor = [UIColor clearColor];
//    photoBase64Lbl.alpha = 0;
//    [bgScrollView addSubview:photoBase64Lbl];
//    
//    // photoBase64Text
//    frame.origin.x += photoBase64Lbl.frame.size.width;
//    frame.size.width = 200;
//    photoBase64Text = [[UITextField alloc] initWithFrame:frame];
//    photoBase64Text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    photoBase64Text.font = [UIFont systemFontOfSize:16.0f];
//    photoBase64Text.placeholder = @"BASE64字符串";
//    photoBase64Text.delegate = self;
//    photoBase64Text.returnKeyType = UIReturnKeyDone;
//    photoBase64Text.alpha = 0;
//    [bgScrollView addSubview:photoBase64Text];
    
    // nativePlaceBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = usefulLifeEndBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    nativePlaceBg = [[UIImageView alloc] initWithFrame:frame];
    [nativePlaceBg setImage:[UIImage imageNamed:@"box3"]];
    nativePlaceBg.alpha = 0;
    [bgScrollView addSubview:nativePlaceBg];
    
    // nativePlaceLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    nativePlaceLbl = [[UILabel alloc] initWithFrame:frame];
    nativePlaceLbl.text = @"籍贯:";
    [[nativePlaceLbl font] fontWithSize:16.0f];
    nativePlaceLbl.backgroundColor = [UIColor clearColor];
    nativePlaceLbl.alpha = 0;
    [bgScrollView addSubview:nativePlaceLbl];
    
    // nativePlaceText
    frame.origin.x += nativePlaceLbl.frame.size.width;
    frame.size.width = 200;
    nativePlaceText = [[UITextField alloc] initWithFrame:frame];
    nativePlaceText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nativePlaceText.font = [UIFont systemFontOfSize:16.0f];
    nativePlaceText.placeholder = @"籍贯";
    nativePlaceText.delegate = self;
    nativePlaceText.returnKeyType = UIReturnKeyDone;
    nativePlaceText.alpha = 0;
    [bgScrollView addSubview:nativePlaceText];
    
    // marriageBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = nativePlaceBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    marriageBtn = [[UIButton alloc]initWithFrame:frame];
    marriageBtn.backgroundColor = [UIColor clearColor];
    [marriageBtn setTitle:@"" forState:UIControlStateNormal];
    [marriageBtn addTarget:self action:@selector(getParamValues:) forControlEvents:UIControlEventTouchUpInside];
    [marriageBtn setBackgroundImage:[UIImage imageNamed:@"box3.png"] forState:UIControlStateNormal];
    [marriageBtn setBackgroundImage:[UIImage imageNamed:@"box3_h.png"] forState:UIControlStateHighlighted];
    marriageBtn.tag = 2;
    [bgScrollView addSubview:marriageBtn];
    
    // marriageLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    marriageLbl = [[UILabel alloc] initWithFrame:frame];
    marriageLbl.text = @"婚姻状况:";
    [[marriageLbl font] fontWithSize:16.0f];
    marriageLbl.backgroundColor = [UIColor clearColor];
    marriageLbl.alpha = 0;
    [bgScrollView addSubview:marriageLbl];
    
    // marriageValueLbl
    frame.origin.x += marriageLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    marriageValueLbl = [[UILabel alloc] initWithFrame:frame];
    marriageValueLbl.backgroundColor = [UIColor clearColor];
    marriageValueLbl.textAlignment = NSTextAlignmentCenter;
    marriageValueLbl.font = [UIFont systemFontOfSize:16.0f];
    marriageValueLbl.text = @"";
    [bgScrollView addSubview:marriageValueLbl];
    
    // marriageIco
    frame.origin.x = marriageBtn.frame.origin.x + marriageBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    marriageIco = [[UIImageView alloc] initWithFrame:frame];
    marriageIco.image = [UIImage imageNamed:@"arrow_down"];
    [bgScrollView addSubview:marriageIco];
    
    // phoneNumBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = marriageBtn.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    phoneNumBg = [[UIImageView alloc] initWithFrame:frame];
    [phoneNumBg setImage:[UIImage imageNamed:@"box3"]];
    phoneNumBg.alpha = 0;
    [bgScrollView addSubview:phoneNumBg];
    
    // phoneNumLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    phoneNumLbl = [[UILabel alloc] initWithFrame:frame];
    phoneNumLbl.text = @"联系电话:";
    [[phoneNumLbl font] fontWithSize:16.0f];
    phoneNumLbl.backgroundColor = [UIColor clearColor];
    phoneNumLbl.alpha = 0;
    [bgScrollView addSubview:phoneNumLbl];
    
    // phoneNumText
    frame.origin.x += phoneNumLbl.frame.size.width;
    frame.size.width = 200;
    phoneNumText = [[UITextField alloc] initWithFrame:frame];
    phoneNumText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneNumText.font = [UIFont systemFontOfSize:16.0f];
    phoneNumText.placeholder = @"号码";
    phoneNumText.delegate = self;
    phoneNumText.returnKeyType = UIReturnKeyDone;
    phoneNumText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneNumText.alpha = 0;
    [bgScrollView addSubview:phoneNumText];
    
    // eduAttainmentsBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = phoneNumBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    eduAttainmentsBtn = [[UIButton alloc]initWithFrame:frame];
    eduAttainmentsBtn.backgroundColor = [UIColor clearColor];
    [eduAttainmentsBtn setTitle:@"" forState:UIControlStateNormal];
    [eduAttainmentsBtn addTarget:self action:@selector(getParamValues:) forControlEvents:UIControlEventTouchUpInside];
    [eduAttainmentsBtn setBackgroundImage:[UIImage imageNamed:@"box3.png"] forState:UIControlStateNormal];
    [eduAttainmentsBtn setBackgroundImage:[UIImage imageNamed:@"box3_h.png"] forState:UIControlStateHighlighted];
    eduAttainmentsBtn.tag = 3;
    [bgScrollView addSubview:eduAttainmentsBtn];
    
    // eduAttainmentsLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    eduAttainmentsLbl = [[UILabel alloc] initWithFrame:frame];
    eduAttainmentsLbl.text = @"文化程度:";
    [[eduAttainmentsLbl font] fontWithSize:16.0f];
    eduAttainmentsLbl.backgroundColor = [UIColor clearColor];
    eduAttainmentsLbl.alpha = 0;
    [bgScrollView addSubview:eduAttainmentsLbl];
    
    // eduAttainmentsValueLbl
    frame.origin.x += eduAttainmentsLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    eduAttainmentsValueLbl = [[UILabel alloc] initWithFrame:frame];
    eduAttainmentsValueLbl.backgroundColor = [UIColor clearColor];
    eduAttainmentsValueLbl.textAlignment = NSTextAlignmentCenter;
    eduAttainmentsValueLbl.font = [UIFont systemFontOfSize:16.0f];
    eduAttainmentsValueLbl.text = @"";
    [bgScrollView addSubview:eduAttainmentsValueLbl];
    
    // eduAttainmentsIco
    frame.origin.x = eduAttainmentsBtn.frame.origin.x + eduAttainmentsBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    marriageIco = [[UIImageView alloc] initWithFrame:frame];
    marriageIco.image = [UIImage imageNamed:@"arrow_down"];
    [bgScrollView addSubview:marriageIco];
    
    // professionBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = eduAttainmentsBtn.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    professionBtn = [[UIButton alloc]initWithFrame:frame];
    professionBtn.backgroundColor = [UIColor clearColor];
    [professionBtn setTitle:@"" forState:UIControlStateNormal];
    [professionBtn addTarget:self action:@selector(getParamValues:) forControlEvents:UIControlEventTouchUpInside];
    [professionBtn setBackgroundImage:[UIImage imageNamed:@"box3.png"] forState:UIControlStateNormal];
    [professionBtn setBackgroundImage:[UIImage imageNamed:@"box3_h.png"] forState:UIControlStateHighlighted];
    professionBtn.tag = 4;
    [bgScrollView addSubview:professionBtn];
    
    // professionLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    professionLbl = [[UILabel alloc] initWithFrame:frame];
    professionLbl.text = @"职业:";
    [[professionLbl font] fontWithSize:16.0f];
    professionLbl.backgroundColor = [UIColor clearColor];
    professionLbl.alpha = 0;
    [bgScrollView addSubview:professionLbl];
    
    // professionValueLbl
    frame.origin.x += professionLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    professionValueLbl = [[UILabel alloc] initWithFrame:frame];
    professionValueLbl.backgroundColor = [UIColor clearColor];
    professionValueLbl.textAlignment = NSTextAlignmentCenter;
    professionValueLbl.font = [UIFont systemFontOfSize:16.0f];
    professionValueLbl.text = @"";
    [bgScrollView addSubview:professionValueLbl];
    
    // professionIco
    frame.origin.x = professionBtn.frame.origin.x + professionBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    professionIco = [[UIImageView alloc] initWithFrame:frame];
    professionIco.image = [UIImage imageNamed:@"arrow_down"];
    [bgScrollView addSubview:professionIco];
    
    // workUnitBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = professionBtn.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    workUnitBg = [[UIImageView alloc] initWithFrame:frame];
    [workUnitBg setImage:[UIImage imageNamed:@"box3"]];
    workUnitBg.alpha = 0;
    [bgScrollView addSubview:workUnitBg];
    
    // workUnitLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    workUnitLbl = [[UILabel alloc] initWithFrame:frame];
    workUnitLbl.text = @"工作单位:";
    [[workUnitLbl font] fontWithSize:16.0f];
    workUnitLbl.backgroundColor = [UIColor clearColor];
    workUnitLbl.alpha = 0;
    [bgScrollView addSubview:workUnitLbl];
    
    // workUnitText
    frame.origin.x += workUnitLbl.frame.size.width;
    frame.size.width = 200;
    workUnitText = [[UITextField alloc] initWithFrame:frame];
    workUnitText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    workUnitText.font = [UIFont systemFontOfSize:16.0f];
    workUnitText.placeholder = @"工作单位";
    workUnitText.delegate = self;
    workUnitText.returnKeyType = UIReturnKeyDone;
    workUnitText.alpha = 0;
    [bgScrollView addSubview:workUnitText];
    
    // partyGroupingsBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = workUnitBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    partyGroupingsBtn = [[UIButton alloc]initWithFrame:frame];
    partyGroupingsBtn.backgroundColor = [UIColor clearColor];
    [partyGroupingsBtn setTitle:@"" forState:UIControlStateNormal];
    [partyGroupingsBtn addTarget:self action:@selector(getParamValues:) forControlEvents:UIControlEventTouchUpInside];
    [partyGroupingsBtn setBackgroundImage:[UIImage imageNamed:@"box3.png"] forState:UIControlStateNormal];
    [partyGroupingsBtn setBackgroundImage:[UIImage imageNamed:@"box3_h.png"] forState:UIControlStateHighlighted];
    partyGroupingsBtn.tag = 5;
    [bgScrollView addSubview:partyGroupingsBtn];
    
    // partyGroupingsLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    partyGroupingsLbl = [[UILabel alloc] initWithFrame:frame];
    partyGroupingsLbl.text = @"何种党派:";
    [[partyGroupingsLbl font] fontWithSize:16.0f];
    partyGroupingsLbl.backgroundColor = [UIColor clearColor];
    partyGroupingsLbl.alpha = 0;
    [bgScrollView addSubview:partyGroupingsLbl];
    
    // partyGroupingsValueLbl
    frame.origin.x += partyGroupingsLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    partyGroupingsValueLbl = [[UILabel alloc] initWithFrame:frame];
    partyGroupingsValueLbl.backgroundColor = [UIColor clearColor];
    partyGroupingsValueLbl.textAlignment = NSTextAlignmentCenter;
    partyGroupingsValueLbl.font = [UIFont systemFontOfSize:16.0f];
    partyGroupingsValueLbl.text = @"";
    [bgScrollView addSubview:partyGroupingsValueLbl];
    
    // partyGroupingsIco
    frame.origin.x = partyGroupingsBtn.frame.origin.x + partyGroupingsBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    partyGroupingsIco = [[UIImageView alloc] initWithFrame:frame];
    partyGroupingsIco.image = [UIImage imageNamed:@"arrow_down"];
    [bgScrollView addSubview:partyGroupingsIco];
    
    // agriOrNonAgriBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = partyGroupingsBtn.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    agriOrNonAgriBtn = [[UIButton alloc]initWithFrame:frame];
    agriOrNonAgriBtn.backgroundColor = [UIColor clearColor];
    [agriOrNonAgriBtn setTitle:@"" forState:UIControlStateNormal];
    [agriOrNonAgriBtn addTarget:self action:@selector(getParamValues:) forControlEvents:UIControlEventTouchUpInside];
    [agriOrNonAgriBtn setBackgroundImage:[UIImage imageNamed:@"box3.png"] forState:UIControlStateNormal];
    [agriOrNonAgriBtn setBackgroundImage:[UIImage imageNamed:@"box3_h.png"] forState:UIControlStateHighlighted];
    agriOrNonAgriBtn.tag = 6;
    [bgScrollView addSubview:agriOrNonAgriBtn];
    
    // agriOrNonAgriLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    agriOrNonAgriLbl = [[UILabel alloc] initWithFrame:frame];
    agriOrNonAgriLbl.text = @"是否农业:";
    [[agriOrNonAgriLbl font] fontWithSize:16.0f];
    agriOrNonAgriLbl.backgroundColor = [UIColor clearColor];
    agriOrNonAgriLbl.alpha = 0;
    [bgScrollView addSubview:agriOrNonAgriLbl];
    
    // agriOrNonAgriValueLbl
    frame.origin.x += agriOrNonAgriLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    agriOrNonAgriValueLbl = [[UILabel alloc] initWithFrame:frame];
    agriOrNonAgriValueLbl.backgroundColor = [UIColor clearColor];
    agriOrNonAgriValueLbl.textAlignment = NSTextAlignmentCenter;
    agriOrNonAgriValueLbl.font = [UIFont systemFontOfSize:16.0f];
    agriOrNonAgriValueLbl.text = @"";
    [bgScrollView addSubview:agriOrNonAgriValueLbl];
    
    // agriOrNonAgriIco
    frame.origin.x = agriOrNonAgriBtn.frame.origin.x + agriOrNonAgriBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    agriOrNonAgriIco = [[UIImageView alloc] initWithFrame:frame];
    agriOrNonAgriIco.image = [UIImage imageNamed:@"arrow_down"];
    [bgScrollView addSubview:agriOrNonAgriIco];
    
    // marryDateBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = agriOrNonAgriBtn.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    marryDateBg = [[UIImageView alloc] initWithFrame:frame];
    [marryDateBg setImage:[UIImage imageNamed:@"box3"]];
    marryDateBg.alpha = 0;
    [bgScrollView addSubview:marryDateBg];
    
    // marryDateLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    marryDateLbl = [[UILabel alloc] initWithFrame:frame];
    marryDateLbl.text = @"结婚时间:";
    [[marryDateLbl font] fontWithSize:16.0f];
    marryDateLbl.backgroundColor = [UIColor clearColor];
    marryDateLbl.alpha = 0;
    [bgScrollView addSubview:marryDateLbl];
    
    // marryDateValueLbl
    frame.origin.x += marryDateLbl.frame.size.width;
    frame.size.width = 120;
    marryDateValueLbl = [[UILabel alloc] initWithFrame:frame];
//    marryDateValueLbl.text = nowDate;
    [[marryDateValueLbl font] fontWithSize:16.0f];
    marryDateValueLbl.backgroundColor = [UIColor clearColor];
    marryDateValueLbl.alpha = 0;
    [bgScrollView addSubview:marryDateValueLbl];
    
    // marryDateBtn
    frame.origin.x += marryDateValueLbl.frame.size.width;
    frame.origin.y += 5;
    frame.size.width = 80;
    frame.size.height = 30;
    marryDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    marryDateBtn.frame = frame;
    marryDateBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [marryDateBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [marryDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [marryDateBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [marryDateBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [marryDateBtn addTarget:self action:@selector(marryDateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    marryDateBtn.alpha = 0;
    [bgScrollView addSubview:marryDateBtn];
    
    // birthControlBtn
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = marryDateBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    birthControlBtn = [[UIButton alloc]initWithFrame:frame];
    birthControlBtn.backgroundColor = [UIColor clearColor];
    [birthControlBtn setTitle:@"" forState:UIControlStateNormal];
    [birthControlBtn addTarget:self action:@selector(getParamValues:) forControlEvents:UIControlEventTouchUpInside];
    [birthControlBtn setBackgroundImage:[UIImage imageNamed:@"box3.png"] forState:UIControlStateNormal];
    [birthControlBtn setBackgroundImage:[UIImage imageNamed:@"box3_h.png"] forState:UIControlStateHighlighted];
    birthControlBtn.tag = 7;
    [bgScrollView addSubview:birthControlBtn];
    
    // birthControlLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    birthControlLbl = [[UILabel alloc] initWithFrame:frame];
    birthControlLbl.text = @"节育情况:";
    [[birthControlLbl font] fontWithSize:16.0f];
    birthControlLbl.backgroundColor = [UIColor clearColor];
    birthControlLbl.alpha = 0;
    [bgScrollView addSubview:birthControlLbl];
    
    // birthControlValueLbl
    frame.origin.x += birthControlLbl.frame.size.width;
    frame.size.width = 320 - 20 - 30 - 80 - 35;
    birthControlValueLbl = [[UILabel alloc] initWithFrame:frame];
    birthControlValueLbl.backgroundColor = [UIColor clearColor];
    birthControlValueLbl.textAlignment = NSTextAlignmentCenter;
    birthControlValueLbl.font = [UIFont systemFontOfSize:16.0f];
    birthControlValueLbl.text = @"";
    [bgScrollView addSubview:birthControlValueLbl];
    
    // birthControlIco
    frame.origin.x = birthControlBtn.frame.origin.x + birthControlBtn.frame.size.width - TEXTPADDING_LEFT - 5 - 30;
    frame.origin.y += (IMAGE_CELL_HEIGHT - 30)/2;
    frame.size.width = 30;
    frame.size.height = 30;
    birthControlIco = [[UIImageView alloc] initWithFrame:frame];
    birthControlIco.image = [UIImage imageNamed:@"arrow_down"];
    [bgScrollView addSubview:birthControlIco];
    
    // birthControlNumBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = birthControlBtn.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    birthControlNumBg = [[UIImageView alloc] initWithFrame:frame];
    [birthControlNumBg setImage:[UIImage imageNamed:@"box3"]];
    birthControlNumBg.alpha = 0;
    [bgScrollView addSubview:birthControlNumBg];
    
    // birthControlNumLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    birthControlNumLbl = [[UILabel alloc] initWithFrame:frame];
    birthControlNumLbl.text = @"计生编号:";
    [[birthControlNumLbl font] fontWithSize:16.0f];
    birthControlNumLbl.backgroundColor = [UIColor clearColor];
    birthControlNumLbl.alpha = 0;
    [bgScrollView addSubview:birthControlNumLbl];
    
    // birthControlNumText
    frame.origin.x += birthControlNumLbl.frame.size.width;
    frame.size.width = 200;
    birthControlNumText = [[UITextField alloc] initWithFrame:frame];
    birthControlNumText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    birthControlNumText.font = [UIFont systemFontOfSize:16.0f];
    birthControlNumText.placeholder = @"编号";
    birthControlNumText.delegate = self;
    birthControlNumText.returnKeyType = UIReturnKeyDone;
    birthControlNumText.alpha = 0;
    [bgScrollView addSubview:birthControlNumText];
    
    // residenceAddrBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = birthControlNumBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    residenceAddrBg = [[UIImageView alloc] initWithFrame:frame];
    [residenceAddrBg setImage:[UIImage imageNamed:@"box3"]];
    residenceAddrBg.alpha = 0;
    [bgScrollView addSubview:residenceAddrBg];
    
    // residenceAddrLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 120;
    residenceAddrLbl = [[UILabel alloc] initWithFrame:frame];
    residenceAddrLbl.text = @"现户口所在地:";
    [[residenceAddrLbl font] fontWithSize:16.0f];
    residenceAddrLbl.backgroundColor = [UIColor clearColor];
    residenceAddrLbl.alpha = 0;
    [bgScrollView addSubview:residenceAddrLbl];
    
    // residenceAddrText
    frame.origin.x += residenceAddrLbl.frame.size.width;
    frame.size.width = 160;
    residenceAddrText = [[UITextField alloc] initWithFrame:frame];
    residenceAddrText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    residenceAddrText.font = [UIFont systemFontOfSize:16.0f];
    residenceAddrText.placeholder = @"地址";
    residenceAddrText.delegate = self;
    residenceAddrText.returnKeyType = UIReturnKeyDone;
    residenceAddrText.alpha = 0;
    [bgScrollView addSubview:residenceAddrText];
    
    // residenceSourceBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = residenceAddrBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    residenceSourceBg = [[UIImageView alloc] initWithFrame:frame];
    [residenceSourceBg setImage:[UIImage imageNamed:@"box3"]];
    residenceSourceBg.alpha = 0;
    [bgScrollView addSubview:residenceSourceBg];
    
    // residenceSourceLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 160;
    residenceSourceLbl = [[UILabel alloc] initWithFrame:frame];
    residenceSourceLbl.text = @"户口从何地迁入本址:";
    [[residenceSourceLbl font] fontWithSize:16.0f];
    residenceSourceLbl.backgroundColor = [UIColor clearColor];
    residenceSourceLbl.alpha = 0;
    [bgScrollView addSubview:residenceSourceLbl];

    // residenceSourceText
    frame.origin.x += residenceSourceLbl.frame.size.width;
    frame.size.width = 120;
    residenceSourceText = [[UITextField alloc] initWithFrame:frame];
    residenceSourceText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    residenceSourceText.font = [UIFont systemFontOfSize:16.0f];
    residenceSourceText.placeholder = @"地址";
    residenceSourceText.delegate = self;
    residenceSourceText.returnKeyType = UIReturnKeyDone;
    residenceSourceText.alpha = 0;
    [bgScrollView addSubview:residenceSourceText];
    
    // checkInDateBg
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = residenceSourceBg.frame.origin.y + IMAGE_CELL_HEIGHT;
    frame.size.width = IMAGE_CELL_WIDTH;
    frame.size.height = IMAGE_CELL_HEIGHT;
    checkInDateBg = [[UIImageView alloc] initWithFrame:frame];
    [checkInDateBg setImage:[UIImage imageNamed:@"box2"]];
    checkInDateBg.alpha = 0;
    [bgScrollView addSubview:checkInDateBg];
    
    // checkInDateLbl
    frame.origin.x += PADDING_LEFT;
    frame.size.width = 80;
    checkInDateLbl = [[UILabel alloc] initWithFrame:frame];
    checkInDateLbl.text = @"入住日期:";
    [[checkInDateLbl font] fontWithSize:16.0f];
    checkInDateLbl.backgroundColor = [UIColor clearColor];
    checkInDateLbl.alpha = 0;
    [bgScrollView addSubview:checkInDateLbl];
    
    // checkInDateValueLbl
    frame.origin.x += checkInDateLbl.frame.size.width;
    frame.size.width = 120;
    checkInDateValueLbl = [[UILabel alloc] initWithFrame:frame];
//    checkInDateValueLbl.text = nowDate;
    [[checkInDateValueLbl font] fontWithSize:16.0f];
    checkInDateValueLbl.backgroundColor = [UIColor clearColor];
    checkInDateValueLbl.alpha = 0;
    [bgScrollView addSubview:checkInDateValueLbl];
    
    // checkInDateBtn
    frame.origin.x += checkInDateValueLbl.frame.size.width;
    frame.origin.y += 5;
    frame.size.width = 80;
    frame.size.height = 30;
    checkInDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkInDateBtn.frame = frame;
    checkInDateBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [checkInDateBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [checkInDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkInDateBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [checkInDateBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [checkInDateBtn addTarget:self action:@selector(checkInDateBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    checkInDateBtn.alpha = 0;
    [bgScrollView addSubview:checkInDateBtn];
    
    // btConnDeviceBtn
    frame.origin.x = 0;
    frame.origin.y = bgScrollView.frame.size.height;
    frame.size.width = 320;
    frame.size.height = 45;
    UIButton *btConnDeviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    btConnDeviceBtn.frame = frame;
    btConnDeviceBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [btConnDeviceBtn setTitle:@"用户迁入" forState:UIControlStateNormal];
    [btConnDeviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btConnDeviceBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [btConnDeviceBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [btConnDeviceBtn addTarget:self action:@selector(moveInFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btConnDeviceBtn];

    // UIActionSheet上添加UIDatePicker
    myDatePicker = [[UIDatePicker alloc] init];
    myDatePicker.datePickerMode = UIDatePickerModeDate;
    [myDatePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)initData
{
    myCommon = [Common shared];
    myCommunicationHttp = [[CommunicationHttp alloc] init];
    
    encodeImageStr = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    [self initView];
    [self initData];

    // 获取键盘高度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 显示更多
- (void)contentShowMoreBtnClick
{
    if(!contentShowMoreBtn.selected)
    {
        if(SYSTEM_VERSION >= 7.0)
            bgScrollView.contentSize = CGSizeMake(320, self.view.frame.size.height * 2.8);
        else
            bgScrollView.contentSize = CGSizeMake(320, self.view.frame.size.height * 3.4);
        [contentShowBg setImage:[UIImage imageNamed:@"box1"]];
        genderBg.alpha = 1;
        genderLbl.alpha = 1;
        genderKindRBtnGroup.alpha = 1;
        nationBg.alpha = 1;
        nationLbl.alpha = 1;
        nationText.alpha = 1;
        birthdayBg.alpha = 1;
        birthdayLbl.alpha = 1;
        birthdayValueLbl.alpha = 1;
        birthdayBtn.alpha = 1;
        addressBg.alpha = 1;
        addressLbl.alpha = 1;
        addressText.alpha = 1;
        issuingAuthBg.alpha = 1;
        issuingAuthLbl.alpha = 1;
        issuingAuthText.alpha = 1;
        usefulLifeBeginBg.alpha = 1;
        usefulLifeBeginLbl.alpha = 1;
        usefulLifeBeginValueLbl.alpha = 1;
        usefulLifeBeginBtn.alpha = 1;
        usefulLifeEndBg.alpha = 1;
        usefulLifeEndLbl.alpha = 1;
        usefulLifeEndValueLbl.alpha = 1;
        usefulLifeEndBtn.alpha = 1;
        eduAttainmentsBtn.alpha = 1;
        eduAttainmentsLbl.alpha = 1;
        eduAttainmentsValueLbl.alpha = 1;
        eduAttainmentsIco.alpha = 1;
        professionBtn.alpha = 1;
        professionLbl.alpha = 1;
        professionValueLbl.alpha = 1;
        professionIco.alpha = 1;
        partyGroupingsBtn.alpha = 1;
        partyGroupingsLbl.alpha = 1;
        partyGroupingsValueLbl.alpha = 1;
        partyGroupingsIco.alpha = 1;
        agriOrNonAgriBtn.alpha = 1;
        agriOrNonAgriLbl.alpha = 1;
        agriOrNonAgriValueLbl.alpha = 1;
        agriOrNonAgriIco.alpha = 1;
        birthControlBtn.alpha = 1;
        birthControlLbl.alpha = 1;
        birthControlValueLbl.alpha = 1;
        birthControlIco.alpha = 1;
        nativePlaceBg.alpha = 1;
        nativePlaceLbl.alpha = 1;
        nativePlaceText.alpha = 1;
        marriageBtn.alpha = 1;
        marriageLbl.alpha = 1;
        marriageValueLbl.alpha = 1;
        marriageIco.alpha = 1;
        phoneNumBg.alpha = 1;
        phoneNumLbl.alpha = 1;
        phoneNumText.alpha = 1;
        workUnitBg.alpha = 1;
        workUnitLbl.alpha = 1;
        workUnitText.alpha = 1;
        marryDateBg.alpha = 1;
        marryDateLbl.alpha = 1;
        marryDateValueLbl.alpha = 1;
        marryDateBtn.alpha = 1;
        birthControlNumBg.alpha = 1;
        birthControlNumLbl.alpha = 1;
        birthControlNumText.alpha = 1;
        residenceAddrBg.alpha = 1;
        residenceAddrLbl.alpha = 1;
        residenceAddrText.alpha = 1;
        residenceSourceBg.alpha = 1;
        residenceSourceLbl.alpha = 1;
        residenceSourceText.alpha = 1;
        checkInDateBg.alpha = 1;
        checkInDateLbl.alpha = 1;
        checkInDateValueLbl.alpha = 1;
        checkInDateBtn.alpha = 1;
    }
    else
    {
        bgScrollView.contentSize = CGSizeMake(320, self.view.frame.size.height);
        [contentShowBg setImage:[UIImage imageNamed:@"box"]];
        genderBg.alpha = 0;
        genderLbl.alpha = 0;
        genderKindRBtnGroup.alpha = 0;
        nationBg.alpha = 0;
        nationLbl.alpha = 0;
        nationText.alpha = 0;
        birthdayBg.alpha = 0;
        birthdayLbl.alpha = 0;
        birthdayValueLbl.alpha = 0;
        birthdayBtn.alpha = 0;
        addressBg.alpha = 0;
        addressLbl.alpha = 0;
        addressText.alpha = 0;
        issuingAuthBg.alpha = 0;
        issuingAuthLbl.alpha = 0;
        issuingAuthText.alpha = 0;
        usefulLifeBeginBg.alpha = 0;
        usefulLifeBeginLbl.alpha = 0;
        usefulLifeBeginValueLbl.alpha = 0;
        usefulLifeBeginBtn.alpha = 0;
        usefulLifeEndBg.alpha = 0;
        usefulLifeEndLbl.alpha = 0;
        usefulLifeEndValueLbl.alpha = 0;
        usefulLifeEndBtn.alpha = 0;
        eduAttainmentsBtn.alpha = 0;
        eduAttainmentsLbl.alpha = 0;
        eduAttainmentsValueLbl.alpha = 0;
        eduAttainmentsIco.alpha = 0;
        professionBtn.alpha = 0;
        professionLbl.alpha = 0;
        professionValueLbl.alpha = 0;
        professionIco.alpha = 0;
        partyGroupingsBtn.alpha = 0;
        partyGroupingsLbl.alpha = 0;
        partyGroupingsValueLbl.alpha = 0;
        partyGroupingsIco.alpha = 0;
        agriOrNonAgriBtn.alpha = 0;
        agriOrNonAgriLbl.alpha = 0;
        agriOrNonAgriValueLbl.alpha = 0;
        agriOrNonAgriIco.alpha = 0;
        birthControlBtn.alpha = 0;
        birthControlLbl.alpha = 0;
        birthControlValueLbl.alpha = 0;
        birthControlIco.alpha = 0;
        nativePlaceBg.alpha = 0;
        nativePlaceLbl.alpha = 0;
        nativePlaceText.alpha = 0;
        marriageBtn.alpha = 0;
        marriageLbl.alpha = 0;
        marriageValueLbl.alpha = 0;
        marriageIco.alpha = 0;
        phoneNumBg.alpha = 0;
        phoneNumLbl.alpha = 0;
        phoneNumText.alpha = 0;
        workUnitBg.alpha = 0;
        workUnitLbl.alpha = 0;
        workUnitText.alpha = 0;
        marryDateBg.alpha = 0;
        marryDateLbl.alpha = 0;
        marryDateValueLbl.alpha = 0;
        marryDateBtn.alpha = 0;
        birthControlNumBg.alpha = 0;
        birthControlNumLbl.alpha = 0;
        birthControlNumText.alpha = 0;
        residenceAddrBg.alpha = 0;
        residenceAddrLbl.alpha = 0;
        residenceAddrText.alpha = 0;
        residenceSourceBg.alpha = 0;
        residenceSourceLbl.alpha = 0;
        residenceSourceText.alpha = 0;
        checkInDateBg.alpha = 0;
        checkInDateLbl.alpha = 0;
        checkInDateValueLbl.alpha = 0;
        checkInDateBtn.alpha = 0;
    }
    contentShowMoreBtn.selected = !contentShowMoreBtn.selected;
}

// 与户主关系
- (void)getParamValues:(id)sender
{
    UIButton* btn = (UIButton *)sender;
    
    // 设置请求的参数参数名称
    if(btn.tag == 1)
        myCommon.m_parameterName = @"与户主关系";
    else if(btn.tag == 2)
        myCommon.m_parameterName = @"婚姻状况";
    else if(btn.tag == 3)
        myCommon.m_parameterName = @"文化程度";
    else if(btn.tag == 4)
        myCommon.m_parameterName = @"职业";
    else if(btn.tag == 5)
        myCommon.m_parameterName = @"何种党派";
    else if(btn.tag == 6)
        myCommon.m_parameterName = @"农业或者非农";
    else if(btn.tag == 7)
        myCommon.m_parameterName = @"节育情况";
    else
        return;
    
    NSDictionary *strRespString = [myCommunicationHttp sendHttpRequest:HTTP_GETPARAM threadType:1 strJsonContent:nil];
    
     paramInfoAry = [[NSMutableArray alloc] init];
    
    if([[[strRespString objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
    {
        for (NSString *tempStr in [strRespString objectForKey:@"Data"])
        {
            [paramInfoAry addObject:tempStr];
        }
    }
    
    if ([paramInfoAry count] == 0)
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有选项！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return ;
    }
    else
    {
        if(btn.tag == 1)
        {
            myActionSheet = [[UIActionSheet alloc] initWithTitle:@"与户主关系" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil, nil];
            myActionSheet.tag = 1;
        }
        else if(btn.tag == 2)
        {
            myActionSheet = [[UIActionSheet alloc] initWithTitle:@"婚姻状况" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil, nil];
            myActionSheet.tag = 2;
        }
        else if(btn.tag == 3)
        {
            myActionSheet = [[UIActionSheet alloc] initWithTitle:@"文化程度" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil, nil];
            myActionSheet.tag = 3;
        }
        else if(btn.tag == 4)
        {
            myActionSheet = [[UIActionSheet alloc] initWithTitle:@"职业" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil, nil];
            myActionSheet.tag = 4;
        }
        else if(btn.tag == 5)
        {
            myActionSheet = [[UIActionSheet alloc] initWithTitle:@"何种党派" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil, nil];
            myActionSheet.tag = 5;
        }
        else if(btn.tag == 6)
        {
            myActionSheet = [[UIActionSheet alloc] initWithTitle:@"农业或者非农" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil, nil];
            myActionSheet.tag = 6;
        }
        else if(btn.tag == 7)
        {
            myActionSheet = [[UIActionSheet alloc] initWithTitle:@"节育情况" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:nil, nil];
            myActionSheet.tag = 7;
        }
        else
            return ;
        
        for(int i=0; i<[paramInfoAry count]; i++)
        {
            [myActionSheet addButtonWithTitle:[paramInfoAry objectAtIndex:i]];
        }
        [myActionSheet showInView:self.view];
    }

}

- (void)moveIn
{
    // 设置请求参数
    NSMutableDictionary *dicRequestData = [[NSMutableDictionary alloc] init];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE] forKey:@"tenantCode"];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO] forKey:@"communityNo"];
    [dicRequestData setValue:myCommon.m_buildingNo forKey:@"buildingNo"];
    [dicRequestData setValue:myCommon.m_roomNo forKey:@"roomNo"];
    [dicRequestData setValue:nameText.text forKey:@"name"];
    [dicRequestData setValue:[[genderKindRBtnGroup getButtonWithIndex:genderKindRBtnGroup.selectedIndex] _titleLabel].text forKey:@"gender"];
    [dicRequestData setValue:nationText.text forKey:@"nation"];
    [dicRequestData setValue:birthdayValueLbl.text forKey:@"birthday"];
    [dicRequestData setValue:addressText.text forKey:@"address"];
    [dicRequestData setValue:IDNumberText.text forKey:@"IDNumber"];
    [dicRequestData setValue:issuingAuthText.text forKey:@"issuingAuthority"];
    [dicRequestData setValue:usefulLifeBeginValueLbl.text forKey:@"usefulLifeBegin"];
    [dicRequestData setValue:usefulLifeEndValueLbl.text forKey:@"usefulLifeEnd"];
    [dicRequestData setValue:relationshipValueLbl.text forKey:@"RelationshipWithTheHouseholder"];
    [dicRequestData setValue:encodeImageStr forKey:@"photoBase64"];
    [dicRequestData setValue:nativePlaceText.text forKey:@"homeplace"];
    [dicRequestData setValue:marriageValueLbl.text forKey:@"marriage"];
    [dicRequestData setValue:phoneNumText.text forKey:@"liaisonPhone"];
    [dicRequestData setValue:eduAttainmentsValueLbl.text forKey:@"educationalAttainments"];
    [dicRequestData setValue:professionValueLbl.text forKey:@"profession"];
    [dicRequestData setValue:workUnitText.text forKey:@"workUnit"];
    [dicRequestData setValue:partyGroupingsValueLbl.text forKey:@"partyGroupings"];
    [dicRequestData setValue:agriOrNonAgriValueLbl.text forKey:@"agriculturalAndNonAgricultural"];
    [dicRequestData setValue:marryDateValueLbl.text forKey:@"marriageDate"];
    [dicRequestData setValue:birthControlValueLbl.text forKey:@"birthControl"];
    [dicRequestData setValue:birthControlNumText.text forKey:@"familyNumber"];
    [dicRequestData setValue:residenceAddrText.text forKey:@"permanentResidence"];
    [dicRequestData setValue:residenceSourceText.text forKey:@"moveAddress"];
    [dicRequestData setValue:checkInDateValueLbl.text forKey:@"indate"];
    [dicRequestData setValue:[[userKindRBtnGroup getButtonWithIndex:userKindRBtnGroup.selectedIndex] _titleLabel].text forKey:@"OwnerOrOccupier"];
    
    // 转换成json格式
    NSString *strJsonData = [NSString stringWithFormat:@"%@",[dicRequestData JSONRepresentation]];
    NSLog(@"strJsonData = %@",strJsonData);
    
    // 发送请求
    NSDictionary *dicRet = [myCommunicationHttp sendHttpRequest:HTTP_MOVEIN threadType:1 strJsonContent:strJsonData];
    if(dicRet)
    {
        // 解析返回结果
        if([[[dicRet objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
        {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"迁入成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alt show];
            return ;
        }
        else
        {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"迁入失败!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alt show];
            return ;
        }
    }
    else
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络异常，请重试!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return ;
    }

}

// 用户迁入
- (void)moveInFunc
{
    if([nameText.text isEqualToString:@""])
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写姓名!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return ;
    }
    else if([IDNumberText.text isEqualToString:@""])
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写身份证号!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return ;
    }
    else if([relationshipValueLbl.text isEqualToString:@""])
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择与户主关系!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return ;
    }
    
    NSMutableString *moveInStr = [[NSMutableString alloc] init];
    [moveInStr appendString:[NSString stringWithFormat:@"姓名=>%@\n", nameText.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"性别=>%@\n", [[genderKindRBtnGroup getButtonWithIndex:genderKindRBtnGroup.selectedIndex] _titleLabel].text]];
    [moveInStr appendString:[NSString stringWithFormat:@"身份证号=>%@\n", IDNumberText.text]];
    if(issuingAuthText.text)
        [moveInStr appendString:[NSString stringWithFormat:@"签发机构=>%@\n", issuingAuthText.text]];
    if(usefulLifeBeginValueLbl.text)
        [moveInStr appendString:[NSString stringWithFormat:@"签发日期=>%@\n", usefulLifeBeginValueLbl.text]];
    if(usefulLifeEndValueLbl.text)
        [moveInStr appendString:[NSString stringWithFormat:@"有效日期=>%@\n", usefulLifeEndValueLbl.text]];
    if(nationText.text)
        [moveInStr appendString:[NSString stringWithFormat:@"民族=>%@\n", nationText.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"与户主关系=>%@\n", relationshipValueLbl.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"用户类型=>%@\n", [[userKindRBtnGroup getButtonWithIndex:userKindRBtnGroup.selectedIndex] _titleLabel].text]];
    if(birthdayValueLbl.text)
        [moveInStr appendString:[NSString stringWithFormat:@"出生日期=>%@\n", birthdayValueLbl.text]];
    if(addressText.text)
        [moveInStr appendString:[NSString stringWithFormat:@"地址=>%@\n", addressText.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"籍贯=>%@\n", nativePlaceText.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"婚姻状况=>%@\n", marriageValueLbl.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"联系电话=>%@\n", phoneNumText.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"文化程度=>%@\n", eduAttainmentsValueLbl.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"职业=>%@\n", professionValueLbl.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"工作单位=>%@\n", workUnitText.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"党派=>%@\n", partyGroupingsValueLbl.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"是否农业=>%@\n", agriOrNonAgriValueLbl.text]];
    if(marryDateValueLbl.text)
        [moveInStr appendString:[NSString stringWithFormat:@"结婚时间=>%@\n", marryDateValueLbl.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"节育情况=>%@\n", birthControlValueLbl.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"计生编号=>%@\n", birthControlNumText.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"现户口所在地=>%@\n", residenceAddrText.text]];
    [moveInStr appendString:[NSString stringWithFormat:@"户口从何地迁入本址=>%@\n", residenceSourceText.text]];
    if(checkInDateValueLbl.text)
        [moveInStr appendString:[NSString stringWithFormat:@"入住日期=>%@", checkInDateValueLbl.text]];
    
    UIAlertView *myAlt = [[UIAlertView alloc] initWithTitle:@"迁入信息确认" message:moveInStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"迁入", nil];
    [myAlt show];
    
    
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self moveIn];
    }
}

// 出生日期
- (void)birthdayBtnClicked
{
    myActionSheet = [[UIActionSheet alloc] initWithTitle:@"选择日期" delegate:nil cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:@"", nil];
    [myActionSheet addSubview:myDatePicker];
    
    myDatePicker.tag = 3;
    myDatePicker.date = [[NSDate alloc] init];
    [myActionSheet showInView:self.view];
}

// 签发日期
- (void)usefulLifeBeginBtnClicked
{
    myActionSheet = [[UIActionSheet alloc] initWithTitle:@"选择日期" delegate:nil cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:@"", nil];
    [myActionSheet addSubview:myDatePicker];
    
    myDatePicker.tag = 4;
    myDatePicker.date = [[NSDate alloc] init];
    [myActionSheet showInView:self.view];
}

// 有效日期
- (void)usefulLifeEndBtnClicked
{
    myActionSheet = [[UIActionSheet alloc] initWithTitle:@"选择日期" delegate:nil cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:@"", nil];
    [myActionSheet addSubview:myDatePicker];
    
    myDatePicker.tag = 5;
    myDatePicker.date = [[NSDate alloc] init];
    [myActionSheet showInView:self.view];
}

// 设置结婚时间
- (void)marryDateBtnClicked
{
    myActionSheet = [[UIActionSheet alloc] initWithTitle:@"选择日期" delegate:nil cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:@"", nil];
    [myActionSheet addSubview:myDatePicker];
    
    myDatePicker.tag = 1;
    myDatePicker.date = [[NSDate alloc] init];
    [myActionSheet showInView:self.view];
}

// 入住日期
- (void)checkInDateBtnClicked
{
    myActionSheet = [[UIActionSheet alloc] initWithTitle:@"选择日期" delegate:nil cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:@"", nil];
    [myActionSheet addSubview:myDatePicker];
    
    myDatePicker.tag = 2;
    myDatePicker.date = [[NSDate alloc] init];
    [myActionSheet showInView:self.view];
}

// 日期改变
-(void)dateChanged:(id)sender
{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC+8"]];     //设置中国时区
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *strDate;
    if (control.tag == 1)
    {
         strDate = [dateFormatter stringFromDate:date];
        marryDateValueLbl.text = strDate;
    }
    else if(control.tag == 2)
    {
        strDate = [dateFormatter stringFromDate:date];
        checkInDateValueLbl.text = strDate;
    }
    else if(control.tag == 3)
    {
        strDate = [dateFormatter stringFromDate:date];
        birthdayValueLbl.text = strDate;
    }
    else if(control.tag == 4)
    {
        strDate = [dateFormatter stringFromDate:date];
        usefulLifeBeginValueLbl.text = strDate;
    }
    else if(control.tag == 5)
    {
        strDate = [dateFormatter stringFromDate:date];
        usefulLifeEndValueLbl.text = strDate;
    }
}

// 添加个人照片
- (void)addPhotoFunc
{
    UIActionSheet *altSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    altSheet.tag = 8;
    [altSheet showInView:self.view];
}


#pragma mark UITextFieldDelegate

//开始编辑时调整键盘高度
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(keyboardHeight == 0)
        keyboardHeight = 216;
    CGRect frame = textField.frame;
    CGFloat offset = frame.origin.y - bgScrollView.contentOffset.y + frame.size.height + 70 - (self.view.frame.size.height - keyboardHeight) ;//键盘高度keyboardHeight
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //高度不够，需要调整，抬高self.view到offset的高度
    if(offset > 0)
    {
        [bgScrollView setContentOffset:CGPointMake(0.0f, bgScrollView.contentOffset.y + offset)];
    }
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void) keyboardWillShow:(NSNotification *) noti
{
    NSDictionary *info = [noti userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyboardHeight = [value CGRectValue].size.height;
    
//    NSLog(@"keyboardHeight:%f", keyboardHeight);  //键盘高度一般216
    ///keyboardWasShown = YES;
}


#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 8)
    {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        switch (buttonIndex) {
            case 0:
            {
                // 判断相机是否可用，不可用将sourceType设定为相片库
                if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
                {
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                }
                break;
            }
            case 1:
            {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                break;
            }
                
            default:
                return ;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    }
    else if(buttonIndex > 0)
    {
        if(actionSheet.tag == 1)
            relationshipValueLbl.text = [paramInfoAry objectAtIndex:buttonIndex - 1];
        else if(actionSheet.tag == 2)
            marriageValueLbl.text = [paramInfoAry objectAtIndex:buttonIndex - 1];
        else if(actionSheet.tag == 3)
            eduAttainmentsValueLbl.text = [paramInfoAry objectAtIndex:buttonIndex - 1];
        else if(actionSheet.tag == 4)
            professionValueLbl.text = [paramInfoAry objectAtIndex:buttonIndex - 1];
        else if(actionSheet.tag == 5)
            partyGroupingsValueLbl.text = [paramInfoAry objectAtIndex:buttonIndex - 1];
        else if(actionSheet.tag == 6)
            agriOrNonAgriValueLbl.text = [paramInfoAry objectAtIndex:buttonIndex - 1];
        else if(actionSheet.tag == 7)
            birthControlValueLbl.text = [paramInfoAry objectAtIndex:buttonIndex - 1];
        else
            return ;
    }
}


#pragma mark UIImagePickerControllerDelegate

// 照相机照完后use图片或在图片库中点击图片触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 得到图片
    UIImage *personImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    [portraitImgView setImage:personImg];
    NSData *data = UIImageJPEGRepresentation(personImg, 0.5f);
    encodeImageStr = [data base64Encoding];     // 保存base64编码
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
