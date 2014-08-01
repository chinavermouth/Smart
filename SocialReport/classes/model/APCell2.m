//
//  APCell2.m
//  PersonalSocialReport
//
//  Created by J.H on 14-4-12.
//  Copyright (c) 2014年 J.H. All rights reserved.
//

#import "APCell2.h"

#define PADDING_LEFT        20
#define PADDING_TOP         5
#define PADDING_RIGHT       5
#define PADDING_BOTTOM      5
#define SPACE_HORIZON       0
#define SPACE_VERTICAL      2


@implementation APCell2
@synthesize leftLbl, rightTextField, rightImgBtn, rightTextView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        leftLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        [leftLbl setFont: [UIFont boldSystemFontOfSize:14.0f]];
        [leftLbl setBackgroundColor:[UIColor clearColor]];
        [leftLbl setTextColor:[UIColor blackColor]];
        leftLbl.textAlignment = NSTextAlignmentLeft;
        [self addSubview:leftLbl];
        
        rightTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        [rightTextField setFont: [UIFont systemFontOfSize:13.0f]];
        [rightTextField setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0f]];
        [rightTextField setTextColor:[UIColor blackColor]];
        rightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        rightTextField.returnKeyType = UIReturnKeyDone;
        [self addSubview:rightTextField];
        
        rightImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:rightImgBtn];
        
        rightTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        [rightTextView setFont:[UIFont systemFontOfSize:13.0f]];
        [rightTextView setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0f]];
        [rightTextView setTextColor:[UIColor blackColor]];
        [self addSubview:rightTextView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect baseRect = self.bounds;
    CGRect rect;
    
    rect.origin.x = PADDING_LEFT;
    rect.origin.y = (baseRect.size.height - 20)/2;
    rect.size.width = 100;
    rect.size.height = 20;
    leftLbl.frame = rect;
    
    rect.origin.x = PADDING_LEFT + leftLbl.frame.size.width;
    rect.size.width = 180;
    rightTextField.frame = rect;
    
    rect.origin.x = PADDING_LEFT + leftLbl.frame.size.width + 60;
    rect.origin.y = (baseRect.size.height - 60)/2;
    rect.size.width = 60;
    rect.size.height = 60;
    rightImgBtn.frame = rect;
    
    rect.origin.x = rightTextField.frame.origin.x;
    rect.origin.y = (baseRect.size.height - 80)/2;
    rect.size.width = rightTextField.frame.size.width;
    rect.size.height = 80;
    rightTextView.frame = rect;
}


@end
