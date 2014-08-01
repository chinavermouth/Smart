//
//  APCell.m
//  SocialReport
//
//  Created by J.H on 14-4-1.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "APCell.h"

#define PADDING_LEFT        20
#define PADDING_TOP         5
#define PADDING_RIGHT       5
#define PADDING_BOTTOM      5
#define SPACE_HORIZON       0
#define SPACE_VERTICAL      2

#define LABEL_HEIGHT        20

@implementation APCell
@synthesize apAddressLabel, apDistanceLabel, apImgViewOnRight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        apAddressLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [apAddressLabel setFont: [UIFont systemFontOfSize:14.0f]];
        [apAddressLabel setBackgroundColor:[UIColor clearColor]];
        [apAddressLabel setTextColor:[UIColor blackColor]];
        [self addSubview:apAddressLabel];
        
        apDistanceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [apDistanceLabel setFont: [UIFont systemFontOfSize:12.0f]];
        [apDistanceLabel setBackgroundColor:[UIColor clearColor]];
        [apDistanceLabel setTextColor:[UIColor blackColor]];
        [self addSubview:apDistanceLabel];
        
        apImgViewOnRight = [[UIImageView alloc]initWithFrame:CGRectZero];
        [apImgViewOnRight setBackgroundColor:[UIColor clearColor]];
        [self addSubview:apImgViewOnRight];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect baseRect = self.bounds;
    CGRect rect;
    
    rect.origin.x = PADDING_LEFT;
    rect.origin.y = PADDING_TOP;
    rect.size.width = baseRect.size.width - rect.origin.x - PADDING_RIGHT;
    rect.size.height = LABEL_HEIGHT;
    apAddressLabel.frame = rect;
    
    rect.origin.x = PADDING_LEFT;
    rect.origin.y = PADDING_TOP + LABEL_HEIGHT + SPACE_VERTICAL;
    rect.size.width = baseRect.size.width - rect.origin.x - PADDING_RIGHT;
    rect.size.height = baseRect.size.height - rect.origin.y- PADDING_BOTTOM;
    apDistanceLabel.frame = rect;
    
    rect.origin.x = 265;
    rect.origin.y = PADDING_TOP + 3;
    rect.size.width = 24;
    rect.size.height = 24;
    apImgViewOnRight.frame = rect;
}

+ (NSUInteger)getCellHeight
{
    return PADDING_TOP + 2*LABEL_HEIGHT + SPACE_VERTICAL + PADDING_BOTTOM;
}

@end
