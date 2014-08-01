//
//  APCell2.h
//  PersonalSocialReport
//
//  Created by J.H on 14-4-12.
//  Copyright (c) 2014年 J.H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APCell2 : UITableViewCell
{
    UILabel *leftLbl;
    UITextField *rightTextField;
    UIButton *rightImgBtn;
    UITextView *rightTextView;
}

@property (readonly, retain) UILabel    *leftLbl;
@property (readonly, retain) UITextField   *rightTextField;
@property (readonly, retain) UIButton   *rightImgBtn;
@property (readonly, retain) UITextView *rightTextView;

@end
