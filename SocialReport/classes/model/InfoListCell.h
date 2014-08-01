//
//  InfoListCell.h
//  SocialReport
//
//  Created by J.H on 14-4-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoListCell : UITableViewCell

@property (readonly, retain) UILabel  *topLbl;
@property (readonly, retain) UILabel  *middleLbl;
@property (readonly, retain) UILabel  *bottomLbl1;
@property (readonly, retain) UILabel  *bottomLbl2;
@property (readonly, retain) UILabel  *bottomLbl3;
@property (readonly, retain) UIScrollView *imageScrollView;

// 返回单元格高
+ (NSUInteger)getCellHeight;

@end
