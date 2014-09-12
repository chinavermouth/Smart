//
//  InfoListCell2.m
//  SocialReport
//
//  Created by J.H on 14-4-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "InfoListCell2.h"

#define  PADDING_LEFT  15
#define  PADDING_TOP   15
#define  PADDING_HOR   5
#define  PADDING_VER   4


@implementation InfoListCell2
@synthesize leftImg = _leftImg, topLbl = _topLbl, middleLbl = _middleLbl, bottomLbl1 = _bottomLbl1, bottomLbl2 = _bottomLbl2, imageScrollView = _imageScrollView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _leftImg = [[UIImageView alloc] init];
        [_leftImg setImage:[UIImage imageNamed:@"listTag"]];
        [self addSubview:_leftImg];
        
        _topLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        [_topLbl setFont: [UIFont boldSystemFontOfSize:14.0f]];
        [_topLbl setBackgroundColor:[UIColor clearColor]];
        _topLbl.textAlignment = NSTextAlignmentCenter;
        _topLbl.numberOfLines = 0;
        [self addSubview:_topLbl];
        
        _middleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _middleLbl.font = [UIFont systemFontOfSize:13.0f];
        _middleLbl.backgroundColor = [UIColor clearColor];
//        _middleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_middleLbl];
        
        _bottomLbl1 = [[UILabel alloc] initWithFrame:CGRectZero];
        _bottomLbl1.font = [UIFont systemFontOfSize:13.0f];
        _bottomLbl1.backgroundColor = [UIColor clearColor];
//        _bottomLbl1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bottomLbl1];
        
        _bottomLbl2 = [[UILabel alloc] initWithFrame:CGRectZero];
        _bottomLbl2.textColor = [UIColor redColor];
        _bottomLbl2.font = [UIFont systemFontOfSize:13.0f];
        _bottomLbl2.backgroundColor = [UIColor clearColor];
//        _bottomLbl2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bottomLbl2];
        
        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageScrollView];
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
    rect.size.width = 30;
    rect.size.height = 36;
    _leftImg.frame = rect;
    
    rect.origin.x += _leftImg.frame.size.width + 10;
    rect.size.height = 40;
    rect.size.width = 250;
    _topLbl.frame = rect;
    
    rect.origin.y += _topLbl.frame.size.height + PADDING_VER;
    rect.size.width = 250;
    rect.size.height = 20;
    _middleLbl.frame = rect;
    
    rect.origin.y += _middleLbl.frame.size.height + PADDING_VER;
    rect.size.width = 175;
    rect.size.height = 20;
    _bottomLbl1.frame = rect;
    
    rect.origin.x += _bottomLbl1.frame.size.width;
    rect.size.width = 85;
    rect.size.height = 20;
    _bottomLbl2.frame = rect;
    
    rect.origin.x = PADDING_LEFT + _leftImg.frame.size.width + 10;
    rect.origin.y += _bottomLbl1.frame.size.height + PADDING_VER*3;
    rect.size.width = cellBaseRect.size.width - 2*PADDING_LEFT - 40;
    rect.size.height = 67.5;
    _imageScrollView.frame = rect;
}

// 返回单元格高
+ (NSUInteger)getCellHeight
{
    return PADDING_TOP * 2 + PADDING_VER * 5 + 40 + 20 + 20 + 67.5;
}

@end
