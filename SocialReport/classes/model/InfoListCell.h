//
//  InfoListCell.h
//  SocialReport
//
//  Created by J.H on 14-4-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoListCell : UITableViewCell

@property (nonatomic, retain) UIButton *leftUserBtn;
@property (nonatomic, retain) UIImageView *leftUserImg;
@property (nonatomic, retain) UILabel *leftUserLbl;
@property (nonatomic, retain) UILabel  *rightTitleLbl;
@property (nonatomic, retain) UILabel  *rightContentLbl;
@property (nonatomic, retain) UIScrollView *rightImgScrollView;
@property (nonatomic, retain) UILabel *bottomTimeLbl;
@property (nonatomic, retain) UILabel *bottomRevertLbl;

// 返回单元格高
+ (NSUInteger)getCellHeight;

@end
