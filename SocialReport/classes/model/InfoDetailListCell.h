//
//  InfoDetailListCell.h
//  SocialReport
//
//  Created by J.H on 14-4-21.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDetailListCell : UITableViewCell


@property (nonatomic, retain)  UILabel *lineOneLbl;
@property (nonatomic, retain)  UILabel *lineTwoLeftLbl;
@property (nonatomic, retain)  UILabel *lineTwoRightLbl;
@property (nonatomic, retain)  UIButton *lineThreeLeftImgBtn;
@property (nonatomic, retain)  UITextView *lineThreeRightText;
@property (nonatomic, retain)  UILabel *lineFourLeftLbl;
@property (nonatomic, retain)  UILabel *lineFourRightLbl;
@property (readonly, retain)   UIScrollView *imageScrollView;

// 返回单元格高
+ (NSUInteger)getCellHeight;

@end
