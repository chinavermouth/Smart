//
//  InfoDetailListCell.m
//  PersonalSocialReport
//
//  Created by J.H on 14-4-30.
//  Copyright (c) 2014年 J.H. All rights reserved.
//

#import "InfoDetailListCell2.h"

#define  PADDING_LEFT  6
#define  PADDING_TOP   5
#define  PADDING_HOR   5
#define  PADDING_VER   5


@implementation InfoDetailListCell2
@synthesize lineOneLbl, lineTwoLeftLbl, lineTwoRightLbl, leftImgScrollView, lineThreeRightText, lineFourLeftLbl, lineFourRightLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        lineOneLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [lineOneLbl setFont: [UIFont boldSystemFontOfSize:15.0f]];
        [lineOneLbl setBackgroundColor:[UIColor clearColor]];
        lineOneLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lineOneLbl];
        
        lineTwoLeftLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [lineTwoLeftLbl setFont:[UIFont systemFontOfSize:13.0f]];
        [lineTwoLeftLbl setBackgroundColor:[UIColor clearColor]];
//        lineTwoLeftLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lineTwoLeftLbl];
        
        lineTwoRightLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [lineTwoRightLbl setFont:[UIFont systemFontOfSize:13.0f]];
        [lineTwoRightLbl setBackgroundColor:[UIColor clearColor]];
        lineTwoRightLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lineTwoRightLbl];
        
        leftImgScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        leftImgScrollView.directionalLockEnabled = YES;
        leftImgScrollView.pagingEnabled = YES;
        leftImgScrollView.showsVerticalScrollIndicator = NO;
        leftImgScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:leftImgScrollView];
        
        lineThreeRightText = [[UITextView alloc] initWithFrame:CGRectZero];
        [lineThreeRightText setFont:[UIFont systemFontOfSize:13.0f]];
        [lineThreeRightText setBackgroundColor:[UIColor clearColor]];
        lineThreeRightText.editable = NO;
        [self addSubview:lineThreeRightText];
        
        lineFourLeftLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [lineFourLeftLbl setFont:[UIFont systemFontOfSize:13.0f]];
        [lineFourLeftLbl setBackgroundColor:[UIColor clearColor]];
//        lineFourLeftLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lineFourLeftLbl];
        
        lineFourRightLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [lineFourRightLbl setFont:[UIFont systemFontOfSize:13.0f]];
        [lineFourRightLbl setBackgroundColor:[UIColor clearColor]];
        lineFourRightLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lineFourRightLbl];
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
    rect.size.width = cellBaseRect.size.width - 2*PADDING_LEFT;
    rect.size.height = 25;
    lineOneLbl.frame = rect;
    
    rect.origin.y += lineOneLbl.frame.size.height + PADDING_VER;
    rect.size.width = (cellBaseRect.size.width - 2*PADDING_LEFT)/2 - 30;
    rect.size.height = 20;
    lineTwoLeftLbl.frame = rect;
    
    rect.origin.x += lineTwoLeftLbl.frame.size.width;
    rect.size.width = (cellBaseRect.size.width - 2*PADDING_LEFT)/2 + 30;
    lineTwoRightLbl.frame = rect;
    
    rect.origin.x = PADDING_LEFT + 5;
    rect.origin.y += lineTwoRightLbl.frame.size.height + PADDING_VER;
    rect.size.width = 100;
    rect.size.height = 100;
    leftImgScrollView.frame = rect;
    
    rect.origin.x += leftImgScrollView.frame.size.width + 5 + PADDING_HOR;
    rect.size.width = (cellBaseRect.size.width - 2*PADDING_LEFT) - leftImgScrollView.frame.size.width - 2*PADDING_LEFT - 10;
    rect.size.height = 100;
    lineThreeRightText.frame = rect;
    
    rect.origin.x = PADDING_LEFT;
    rect.origin.y += lineThreeRightText.frame.size.height + PADDING_VER;
    rect.size.width = (cellBaseRect.size.width - 2*PADDING_LEFT)/2 - 30;
    rect.size.height = 20;
    lineFourLeftLbl.frame = rect;
    
    rect.origin.x += lineFourLeftLbl.frame.size.width;
    rect.size.width = (cellBaseRect.size.width - 2*PADDING_LEFT)/2 + 30;
    lineFourRightLbl.frame = rect;
    
}

// 返回单元格高
+ (NSUInteger)getCellHeight
{
    return PADDING_TOP * 2 + PADDING_VER * 3 + 25 + 20 + 100 + 20;
}
@end

