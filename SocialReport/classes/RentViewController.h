//
//  RentViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-17.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRadioButtonGroup.h"
#import "ComboBox.h"


@interface RentViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate ,UITableViewDataSource>
{
    NSString *encodeImageStr;
    
    UIScrollView *bgScrollView;
    
    float keyboardHeight;
    UIImageView *housePhotoPic;
    
    UIToolbar* toolbarView;     // 键盘工具栏
    UITextView *contentTextView;
    
    UITextField *titleText;
    UITextField *rentalMoneyText;
    UITextField *phoneNumberText;
    UITextField *conAddressText;
    MyRadioButtonGroup *personTypeRBtnGroup;
    
    Combox *houseTypeComBox;    // 户型combox
}

@end
