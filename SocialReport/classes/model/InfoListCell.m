//
//  InfoListCell.m
//  SocialReport
//
//  Created by J.H on 14-4-18.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "InfoListCell.h"

#define  PADDING_LEFT  10
#define  PADDING_TOP   10
#define  PADDING_HOR   15
#define  PADDING_VER   4


@implementation InfoListCell
@synthesize leftUserBtn = _leftUserBtn, leftUserImg = _leftUserImg, leftUserLbl = _leftUserLbl, rightTitleLbl = _rightTitleLbl, rightContentLbl = _rightContentLbl, rightImgScrollView = _rightImgScrollView, bottomTimeLbl = _bottomTimeLbl, bottomRevertLbl = _bottomRevertLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _leftUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_leftUserBtn];
        
        _leftUserImg = [[UIImageView alloc] init];
        [_leftUserBtn addSubview:_leftUserImg];
        
        _leftUserLbl = [[UILabel alloc] init];
        [_leftUserLbl setFont: [UIFont boldSystemFontOfSize:12.0f]];
        [_leftUserLbl setTextColor:[UIColor lightGrayColor]];
        [_leftUserLbl setBackgroundColor:[UIColor clearColor]];
        _leftUserLbl.textAlignment = NSTextAlignmentCenter;
        [_leftUserBtn addSubview:_leftUserLbl];
        
        _rightTitleLbl = [[UILabel alloc] init];
        _rightTitleLbl.font = [UIFont systemFontOfSize:14.0f];
        _rightTitleLbl.textColor = [UIColor blackColor];
        _rightTitleLbl.backgroundColor = [UIColor clearColor];
        _rightTitleLbl.textAlignment = NSTextAlignmentCenter;
        _rightTitleLbl.numberOfLines = 0;
        [self addSubview:_rightTitleLbl];
        
        _rightContentLbl = [[UILabel alloc] init];
        _rightContentLbl.font = [UIFont systemFontOfSize:13.0f];
        _rightContentLbl.textColor = [UIColor blackColor];
        _rightContentLbl.backgroundColor = [UIColor clearColor];
        _rightContentLbl.numberOfLines = 0;
        [self addSubview:_rightContentLbl];
        
        _rightImgScrollView = [[UIScrollView alloc] init];
        [self addSubview:_rightImgScrollView];
        
        _bottomTimeLbl = [[UILabel alloc] init];
        [_bottomTimeLbl setFont: [UIFont boldSystemFontOfSize:12.0f]];
        [_bottomTimeLbl setTextColor:[UIColor lightGrayColor]];
        [_bottomTimeLbl setBackgroundColor:[UIColor clearColor]];
//        _bottomTimeLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bottomTimeLbl];
        
        _bottomRevertLbl = [[UILabel alloc] init];
        [_bottomRevertLbl setFont: [UIFont boldSystemFontOfSize:13.0f]];
        [_bottomRevertLbl setTextColor:[UIColor redColor]];
        [_bottomRevertLbl setBackgroundColor:[UIColor clearColor]];
        //        _bottomRevertLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bottomRevertLbl];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame;
    
    frame.origin.x = PADDING_LEFT;
    frame.origin.y = PADDING_TOP;
    frame.size.height = 75;
    frame.size.width = 75;
    _leftUserBtn.frame = frame;
    
    frame.origin.x = 10;
    frame.origin.y = 0;
    frame.size.width = 55;
    frame.size.height = 55;
    _leftUserImg.frame = frame;
    
    frame.origin.x = 0;
    frame.origin.y = 55;
    frame.size.width = 75;
    frame.size.height = 20;
    _leftUserLbl.frame = frame;
    
    frame.origin.x += _leftUserBtn.frame.size.width + PADDING_HOR;
    frame.origin.y = PADDING_TOP;
    frame.size.width = 210;
    frame.size.height = 30;
    _rightTitleLbl.frame = frame;
    
    frame.origin.y += _rightTitleLbl.frame.size.height;
    frame.size.width = 210;
    frame.size.height = 50;
    _rightContentLbl.frame = frame;
    
    frame.origin.y += _rightContentLbl.frame.size.height + PADDING_VER * 3;
    frame.size.width = 210;
    frame.size.height = 67.5;
    _rightImgScrollView.frame = frame;
    
    frame.origin.x = PADDING_LEFT * 2;
    frame.origin.y += _rightImgScrollView.frame.size.height + PADDING_VER * 3;
    frame.size.width = 220;
    frame.size.height = 20;
    _bottomTimeLbl.frame = frame;
    
    frame.origin.x += _bottomTimeLbl.frame.size.width;
    frame.size.width = 60;
    frame.size.height = 20;
    _bottomRevertLbl.frame = frame;
}

// 返回单元格高
+ (NSUInteger)getCellHeight
{
    return PADDING_TOP + 30 + 50 + 67.5 + PADDING_VER * 6 + 20 + PADDING_TOP;
}

@end
