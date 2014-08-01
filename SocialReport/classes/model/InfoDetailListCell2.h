//
//  InfoDetailListCell.h
//  PersonalSocialReport
//
//  Created by J.H on 14-4-30.
//  Copyright (c) 2014年 J.H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDetailListCell2 : UITableViewCell
{
    UILabel *lineOneLbl;
    UILabel *lineTwoLeftLbl;
    UILabel *lineTwoRightLbl;
    UIScrollView *leftImgScrollView;
    UITextView *lineThreeRightText;
    UILabel *lineFourLeftLbl;
    UILabel *lineFourRightLbl;
}

@property (nonatomic, retain)  UILabel*lineOneLbl;
@property (nonatomic, retain)  UILabel*lineTwoLeftLbl;
@property (nonatomic, retain)  UILabel*lineTwoRightLbl;
@property (nonatomic, retain)  UIScrollView *leftImgScrollView;
@property (nonatomic, retain)  UITextView *lineThreeRightText;
@property (nonatomic, retain)  UILabel *lineFourLeftLbl;
@property (nonatomic, retain)  UILabel *lineFourRightLbl;

// 返回单元格高
+ (NSUInteger)getCellHeight;

@end
