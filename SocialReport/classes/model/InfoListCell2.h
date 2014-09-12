//
//  InfoListCell2.h
//  SocialReport
//
//  Created by J.H on 14-4-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoListCell2 : UITableViewCell

@property (retain, nonatomic) UIImageView *leftImg;
@property (retain, nonatomic) UILabel  *topLbl;
@property (retain, nonatomic) UILabel  *middleLbl;
@property (retain, nonatomic) UILabel  *bottomLbl1;
@property (retain, nonatomic) UILabel  *bottomLbl2;
@property (retain, nonatomic) UIScrollView *imageScrollView;

// 返回单元格高
+ (NSUInteger)getCellHeight;

@end
