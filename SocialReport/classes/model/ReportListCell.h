//
//  reportListCell.h
//  SocialReport
//
//  Created by J.H on 14-9-5.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportListCell : UITableViewCell

@property (readonly, retain) UIImageView *leftImg;
@property (readonly, retain) UILabel     *titleLbl;
@property (readonly, retain) UILabel     *timeLbl;

+ (NSUInteger)getCellHeight;

@end
