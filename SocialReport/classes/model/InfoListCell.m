//
//  InfoListCell.m
//  SocialReport
//
//  Created by J.H on 14-4-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "InfoListCell.h"

#define  PADDING_LEFT  15
#define  PADDING_TOP   15
#define  PADDING_HOR   5
#define  PADDING_VER   4


@implementation InfoListCell
@synthesize topLbl, middleLbl, bottomLbl1, bottomLbl2, bottomLbl3, imageScrollView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        topLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [topLbl setFont: [UIFont boldSystemFontOfSize:15.0f]];
        [topLbl setBackgroundColor:[UIColor clearColor]];
        topLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:topLbl];
        
        middleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        middleLbl.font = [UIFont systemFontOfSize:13.0f];
        middleLbl.backgroundColor = [UIColor clearColor];
        middleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:middleLbl];
        
        bottomLbl1 = [[UILabel alloc] initWithFrame:CGRectZero];
        bottomLbl1.font = [UIFont systemFontOfSize:13.0f];
        bottomLbl1.backgroundColor = [UIColor clearColor];
        bottomLbl1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:bottomLbl1];
        
        bottomLbl2 = [[UILabel alloc] initWithFrame:CGRectZero];
        bottomLbl2.font = [UIFont systemFontOfSize:13.0f];
        bottomLbl2.backgroundColor = [UIColor clearColor];
        bottomLbl2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:bottomLbl2];
        
        bottomLbl3 = [[UILabel alloc] initWithFrame:CGRectZero];
        bottomLbl3.font = [UIFont systemFontOfSize:13.0f];
        bottomLbl3.textColor = [UIColor redColor];
        bottomLbl3.backgroundColor = [UIColor clearColor];
        bottomLbl3.textAlignment = NSTextAlignmentCenter;
        [self addSubview:bottomLbl3];
        
        imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self addSubview:imageScrollView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect cellBaseRect = self.bounds;
    CGRect rect;
    
    rect.origin.x = PADDING_LEFT;
    rect.origin.y = PADDING_TOP;
    rect.size.height = 25;
    rect.size.width = cellBaseRect.size.width - 2*PADDING_LEFT;
    topLbl.frame = rect;
    
    rect.origin.y += topLbl.frame.size.height + PADDING_VER;
    rect.size.width = 115;
    rect.size.height = 20;
    middleLbl.frame = rect;
    
    rect.origin.y += middleLbl.frame.size.height + PADDING_VER;
    rect.size.width = 100;
    rect.size.height = 20;
    bottomLbl1.frame = rect;
    
    rect.origin.x += bottomLbl1.frame.size.width + PADDING_HOR;
    rect.size.width = 130;
    rect.size.height = 20;
    bottomLbl2.frame = rect;
    
    rect.origin.x += bottomLbl2.frame.size.width + PADDING_HOR;
    rect.size.width = 60;
    rect.size.height = 20;
    bottomLbl3.frame = rect;
    
    rect.origin.x = PADDING_LEFT;
    rect.origin.y += bottomLbl1.frame.size.height + PADDING_VER*3;
    rect.size.width = cellBaseRect.size.width - 2*PADDING_LEFT;
    rect.size.height = 67.5;
    imageScrollView.frame = rect;
}

// 返回单元格高
+ (NSUInteger)getCellHeight
{
    return PADDING_TOP * 2 + PADDING_VER * 5 + 25 + 20 + 20 + 67.5;
}

@end
