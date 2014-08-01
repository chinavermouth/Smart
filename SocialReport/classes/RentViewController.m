//
//  RentViewController.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-17.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "RentViewController.h"
#import "MyRadioButtonGroup.h"
#import "Common.h"
#import "JSON.h"
#import "CommunicationHttp.h"

#define MAIN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define PADDING_TOP 15
#define PADDING_LEFT 20
#define HORI_PADDING 0
#define VERT_PADDING 6
#define ITEMLBL_WIDTH 80
#define ITEM_HEIGHT 35


@interface RentViewController ()

@end

@implementation RentViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"出租出售";
    }
    return self;
}

- (void)initView
{
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
    bgScrollView.contentSize = CGSizeMake(320, frame.size.height + 100);
    [self.view addSubview:bgScrollView];
    
    // titleLbl
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP;
    frame.size.width = ITEMLBL_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:frame];
    titleLbl.text = @"标题：";
    titleLbl.font = [UIFont systemFontOfSize:15.0f];
    [bgScrollView addSubview:titleLbl];
    
    // titleBg
    frame.origin.x += ITEMLBL_WIDTH + HORI_PADDING;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING;
    frame.size.height = ITEM_HEIGHT;
    UIImageView *titleBg = [[UIImageView alloc] initWithFrame:frame];
    [titleBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:titleBg];
    
    // titleText
    frame.origin.x += 5;
    frame.origin.y += 2.5;
    frame.size.width = (self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING) - 2*5;
    frame.size.height = ITEM_HEIGHT - 5;
    titleText = [[UITextField alloc] initWithFrame:frame];
    titleText.font = [UIFont systemFontOfSize:15.0f];
    titleText.returnKeyType = UIReturnKeyDone;
    titleText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    titleText.delegate = self;
    [bgScrollView addSubview:titleText];
    
    // houseTypeLbl
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP + ITEM_HEIGHT + VERT_PADDING;
    frame.size.width = ITEMLBL_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    UILabel *houseTypeLbl = [[UILabel alloc] initWithFrame:frame];
    houseTypeLbl.text = @"户型：";
    houseTypeLbl.font = [UIFont systemFontOfSize:15.0f];
    [bgScrollView addSubview:houseTypeLbl];
    
    // contentLbl
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP + ITEM_HEIGHT*2 + VERT_PADDING*2;
    frame.size.width = ITEMLBL_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:frame];
    contentLbl.text = @"内容：";
    contentLbl.font = [UIFont systemFontOfSize:15.0f];
    [bgScrollView addSubview:contentLbl];
    
    // contentBg
    frame.origin.x += ITEMLBL_WIDTH + HORI_PADDING;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING;
    frame.size.height = ITEM_HEIGHT * 3;
    UIImageView *contentBg = [[UIImageView alloc] initWithFrame:frame];
    [contentBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:contentBg];
    
    // contentTextView
    frame.origin.x += 2;
    frame.origin.y += 2.5;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING - 4;
    frame.size.height = ITEM_HEIGHT * 3 - 5;
    contentTextView = [[UITextView alloc] initWithFrame:frame];
    contentTextView.font = [UIFont systemFontOfSize:15.0f];
    contentTextView.delegate = self;
    [bgScrollView addSubview:contentTextView];
    
    // rentalMoneyLbl
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP + ITEM_HEIGHT*5 + VERT_PADDING*3;
    frame.size.width = ITEMLBL_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    UILabel *rentalMoneyLbl = [[UILabel alloc] initWithFrame:frame];
    rentalMoneyLbl.text = @"租金：";
    rentalMoneyLbl.font = [UIFont systemFontOfSize:15.0f];
    [bgScrollView addSubview:rentalMoneyLbl];
    
    // rentalMoneyBg
    frame.origin.x += ITEMLBL_WIDTH + HORI_PADDING;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING;
    frame.size.height = ITEM_HEIGHT;
    UIImageView *rentalMoneyBg = [[UIImageView alloc] initWithFrame:frame];
    [rentalMoneyBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:rentalMoneyBg];
    
    // rentalMoneyText
    frame.origin.x += 5;
    frame.origin.y += 2.5;
    frame.size.width = (self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING) - 2*5;
    frame.size.height = ITEM_HEIGHT - 5;
    rentalMoneyText = [[UITextField alloc] initWithFrame:frame];
    rentalMoneyText.font = [UIFont systemFontOfSize:15.0f];
    rentalMoneyText.returnKeyType = UIReturnKeyDone;
    rentalMoneyText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    rentalMoneyText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    rentalMoneyText.delegate = self;
    [bgScrollView addSubview:rentalMoneyText];
    
    // houseTypeComBox
    frame.origin.x = PADDING_LEFT + ITEMLBL_WIDTH + HORI_PADDING;
    frame.origin.y = PADDING_TOP + ITEM_HEIGHT + VERT_PADDING;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING;
    frame.size.height = ITEM_HEIGHT;
    houseTypeComBox = [[Combox alloc] initWithFrame:frame items:@[@"一室",@"二室",@"三室",@"四室",@"五室及以上"] inView:bgScrollView];
    [houseTypeComBox setTitle:@"请选择户型" withTitleColor:[UIColor blackColor] withTitleFontSize:15.0f];
    [bgScrollView addSubview:houseTypeComBox];
    
    // phoneNumberLbl
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP + ITEM_HEIGHT*6 + VERT_PADDING*4;
    frame.size.width = ITEMLBL_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    UILabel *phoneNumberLbl = [[UILabel alloc] initWithFrame:frame];
    phoneNumberLbl.text = @"联系电话：";
    phoneNumberLbl.font = [UIFont systemFontOfSize:15.0f];
    [bgScrollView addSubview:phoneNumberLbl];
    
    // phoneNumberBg
    frame.origin.x += ITEMLBL_WIDTH + HORI_PADDING;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING;
    frame.size.height = ITEM_HEIGHT;
    UIImageView *phoneNumberBg = [[UIImageView alloc] initWithFrame:frame];
    [phoneNumberBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:phoneNumberBg];
    
    // phoneNumberText
    frame.origin.x += 5;
    frame.origin.y += 2.5;
    frame.size.width = (self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING) - 2*5;
    frame.size.height = ITEM_HEIGHT - 5;
    phoneNumberText = [[UITextField alloc] initWithFrame:frame];
    phoneNumberText.font = [UIFont systemFontOfSize:15.0f];
    phoneNumberText.returnKeyType = UIReturnKeyDone;
    phoneNumberText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneNumberText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneNumberText.delegate = self;
    [bgScrollView addSubview:phoneNumberText];
    
    // conAddressLbl
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP + ITEM_HEIGHT*7 + VERT_PADDING*5;
    frame.size.width = ITEMLBL_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    UILabel *conAddressLbl = [[UILabel alloc] initWithFrame:frame];
    conAddressLbl.text = @"联系地址：";
    conAddressLbl.font = [UIFont systemFontOfSize:15.0f];
    [bgScrollView addSubview:conAddressLbl];
    
    // conAddressBg
    frame.origin.x += ITEMLBL_WIDTH + HORI_PADDING;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING;
    frame.size.height = ITEM_HEIGHT;
    UIImageView *conAddressBg = [[UIImageView alloc] initWithFrame:frame];
    [conAddressBg setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:conAddressBg];
    
    // conAddressText
    frame.origin.x += 5;
    frame.origin.y += 2.5;
    frame.size.width = (self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING) - 2*5;
    frame.size.height = ITEM_HEIGHT - 5;
    conAddressText = [[UITextField alloc] initWithFrame:frame];
    conAddressText.font = [UIFont systemFontOfSize:15.0f];
    conAddressText.returnKeyType = UIReturnKeyDone;
    conAddressText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    conAddressText.delegate = self;
    [bgScrollView addSubview:conAddressText];
    
    // personTypeLbl
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP + ITEM_HEIGHT*8 + VERT_PADDING*6;
    frame.size.width = ITEMLBL_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    UILabel *personTypeLbl = [[UILabel alloc] initWithFrame:frame];
    personTypeLbl.text = @"身份：";
    personTypeLbl.font = [UIFont systemFontOfSize:15.0f];
    [bgScrollView addSubview:personTypeLbl];
    
    // personTypeRBtnGroup
    // personRadioButton
    MyRadioButton *personRadioButton = [[MyRadioButton alloc] initWithTitle:@"个人" andIndex:0 withFrame:frame autoSubSize:NO];
    [personRadioButton setSelected:NO];
    
    // agentRadioButton
    MyRadioButton *agentRadioButton = [[MyRadioButton alloc] initWithTitle:@"中介" andIndex:1 withFrame:frame autoSubSize:NO];
    [agentRadioButton setSelected:NO];
    
    // searchPersonRBtnGroup
    frame.origin.x += ITEMLBL_WIDTH + HORI_PADDING;
    frame.origin.y += 7.5;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING;
    frame.size.height = ITEM_HEIGHT - 15;
    personTypeRBtnGroup = [[MyRadioButtonGroup alloc] initWithFrame:frame];
    [personTypeRBtnGroup addRadioButton:personRadioButton];
    [personTypeRBtnGroup addRadioButton:agentRadioButton];
    personTypeRBtnGroup.direction = Horizontal;
    // 默认选项
    [personTypeRBtnGroup setDefaultSeletedWithIndex:0];
    [bgScrollView addSubview:personTypeRBtnGroup];
    
    // housePhotoLbl
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP + ITEM_HEIGHT*9 + VERT_PADDING*7;
    frame.size.width = ITEMLBL_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    UILabel *housePhotoLbl = [[UILabel alloc] initWithFrame:frame];
    housePhotoLbl.text = @"房屋照片：";
    housePhotoLbl.font = [UIFont systemFontOfSize:15.0f];
    [bgScrollView addSubview:housePhotoLbl];
    
    // housePhotoPic
    frame.origin.x += ITEMLBL_WIDTH + HORI_PADDING;
    frame.size.width = self.view.frame.size.width - 2*PADDING_LEFT - ITEMLBL_WIDTH - HORI_PADDING - 120;
    frame.size.height = 80;
    housePhotoPic = [[UIImageView alloc] initWithFrame:frame];
    [housePhotoPic setImage:[UIImage imageNamed:@"public_TitleBg"]];
    [bgScrollView addSubview:housePhotoPic];
    
    // takePhotoBtn
    frame.origin.x += housePhotoPic.frame.size.width + 10;
    frame.origin.y += 2.5;
    frame.size.width = 60;
    frame.size.height = 30;
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.frame = frame;
    takePhotoBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [takePhotoBtn setTitle:@"拍 照" forState:UIControlStateNormal];
    [takePhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:takePhotoBtn];
    
    // btConnDeviceBtn
    frame.origin.x = 0;
    frame.origin.y = bgScrollView.frame.size.height;
    frame.size.width = 320;
    frame.size.height = 45;
    UIButton *rentPublishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rentPublishBtn.frame = frame;
    rentPublishBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [rentPublishBtn setTitle:@"发布租房" forState:UIControlStateNormal];
    [rentPublishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rentPublishBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_bg"] forState:UIControlStateNormal];
    [rentPublishBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateHighlighted];
    [rentPublishBtn addTarget:self action:@selector(rentPublishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rentPublishBtn];
    
    
    // 空白填充按钮
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // 隐藏键盘按钮
    UIButton *hiddenBtnItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    hiddenBtnItem.frame = CGRectMake(0.0f, 0.0f, 70.0f, 30.0f);
    [hiddenBtnItem setTitle:@"隐藏键盘" forState:UIControlStateNormal];
    [hiddenBtnItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hiddenBtnItem setBackgroundColor:[UIColor clearColor]];
    [hiddenBtnItem addTarget:self action:@selector(hiddenKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *hiddenButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hiddenBtnItem];
    
    // 在弹出小键盘上添加工具栏
    if (MAIN_SCREEN_HEIGHT > 480)
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,568,320,40)];
        else
            toolbarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,504,320,40)];
    else
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,480,320,40)];
        else
            toolbarView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,416,320,40)];
    toolbarView.barStyle = UIBarStyleDefault;
    toolbarView.items = [NSArray arrayWithObjects:spaceButtonItem, hiddenButtonItem, nil];
    [self.view addSubview:toolbarView];

}

- (void)viewWillAppear:(BOOL)animated
{
    if(SYSTEM_VERSION >= 7.0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBarNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeGestureRecognizer" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //显示导航栏
	[self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 首页" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    [self initView];
    
    encodeImageStr = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏键盘
- (void)hiddenKeyBoard
{
    [contentTextView resignFirstResponder];
}

- (void)backFunc
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 发布租房
- (void)rentPublishBtnClicked
{
    if([titleText.text isEqualToString:@""])
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入标题！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return;
    }
    else if([contentTextView.text isEqualToString:@""])
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入内容！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return;
    }
    else if([houseTypeComBox.titleBtn.titleLabel.text isEqualToString:@"请选择户型"])
    {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择户型！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
        return;
    }
    // 设置请求参数
    NSMutableDictionary *dicRequestData = [[NSMutableDictionary alloc] init];
    [dicRequestData setValue:@"wyfw_fwcz_fyxx" forKey:@"CatalogueKey"];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYNO] forKey:@"CommunityId"];
    [dicRequestData setValue:titleText.text forKey:@"Title"];
    [dicRequestData setValue:contentTextView.text forKey:@"Text"];
    [dicRequestData setValue:rentalMoneyText.text forKey:@"Price"];
    [dicRequestData setValue:houseTypeComBox.titleBtn.titleLabel.text forKey:@"Style"];
    [dicRequestData setValue:phoneNumberText.text forKey:@"Tel"];
    [dicRequestData setValue:conAddressText.text forKey:@"Address"];
    [dicRequestData setValue:[[personTypeRBtnGroup getButtonWithIndex:personTypeRBtnGroup.selectedIndex] _titleLabel].text forKey:@"ExtField01"];
    [dicRequestData setValue:encodeImageStr forKey:@"ImageDatas"];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERID] forKey:@"CreatorId"];
    [dicRequestData setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USERNAME] forKey:@"CreatorName"];
    
    // 转换成json格式
    NSString *strJsonData = [NSString stringWithFormat:@"%@",[dicRequestData JSONRepresentation]];
    NSLog(@"strJsonData = %@",strJsonData);
    
    CommunicationHttp *myCommunicationHttp = [[CommunicationHttp alloc] init];
    // 发送请求
    NSDictionary *dicRet = [myCommunicationHttp sendHttpRequest:HTTP_RENT threadType:1 strJsonContent:strJsonData];
    if(dicRet)
    {
        // 解析返回结果
        if([[[dicRet objectForKey:@"Info"] objectForKey:@"Code"] intValue] == 1)
        {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alt show];
            return ;
        }
        else
        {
            UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布失败!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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

// 选择户型
- (void)houseTypeBtnClicked
{
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"请选择户型"
                                                  message:@""
                                                 delegate:self
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"一室", @"二室",@"三室",@"四室",@"五室及以上",
                                                    nil];
    [alt show];
}

- (void)takePhotoBtnClicked
{
    //先设定sourceType为相机，然后判断相机是否可用，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentModalViewController:picker animated:YES];//进入照相界面
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
    
    NSLog(@"keyboardHeight:%f", keyboardHeight);  //键盘高度一般216
    ///keyboardWasShown = YES;
}


#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
    
    return YES;
}

//开始编辑时调整键盘高度
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(keyboardHeight == 0)
        keyboardHeight = 216;
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    // 升起工具栏
    if (MAIN_SCREEN_HEIGHT > 480)
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView.frame = CGRectMake(0.0f, 568.0f - (keyboardHeight + 40.0f), 320.0f, 40.0f);
        else
            toolbarView.frame = CGRectMake(0.0f, 504.0f - (keyboardHeight + 40.0f), 320.0f, 40.0f);
    else
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView.frame = CGRectMake(0.0f, 480.0f - (keyboardHeight + 40.0f), 320.0f, 40.0f);
        else
            toolbarView.frame = CGRectMake(0.0f, 416.0f - (keyboardHeight + 40.0f), 320.0f, 40.0f);
    
    [UIView commitAnimations];
}

// 收起小键盘时操作
- (void)textViewDidEndEditing:(UITextView *)textView
{
    // 键盘消失时需要恢复self.view到0高度
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    // 收起工具栏
    if (MAIN_SCREEN_HEIGHT > 480)
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView.frame = CGRectMake(0.0f, 568.0f, 320.0f, 40.0f);
        else
            toolbarView.frame = CGRectMake(0.0f, 504.0f, 320.0f, 40.0f);
    else
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            toolbarView.frame = CGRectMake(0.0f, 480.0f, 320.0f, 40.0f);
        else
            toolbarView.frame = CGRectMake(0.0f, 416.0f, 320.0f, 40.0f);
    
    [UIView commitAnimations];
}


#pragma mark UIImagePickerControllerDelegate

// 照相机照完后use图片或在图片库中点击图片触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 获取图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.5f);
    encodeImageStr = [data base64Encoding];     // 保存base64编码
    
    // 保存图片
    [housePhotoPic setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
