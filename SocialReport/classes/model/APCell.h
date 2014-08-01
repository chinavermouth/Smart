//
//  APCell.h
//  SocialReport
//
//  Created by J.H on 14-4-1.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APCell : UITableViewCell
{
    UILabel     *apAddressLabel;
    UILabel     *apDistanceLabel;
    UIImageView *apImgViewOnRight;
}

@property (readonly, retain) UILabel     *apAddressLabel;
@property (readonly, retain) UILabel     *apDistanceLabel;
@property (readonly, retain) UIImageView *apImgViewOnRight;

+ (NSUInteger)getCellHeight;

@end
