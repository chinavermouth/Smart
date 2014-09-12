//
//  ReportListCell.m
//  SocialReport
//
//  Created by J.H on 14-9-5.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ReportListCell.h"

@implementation ReportListCell

@synthesize titleLbl = _titleLbl, timeLbl = _timeLbl, leftImg = _leftImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _leftImg = [[UIImageView alloc] init];
        [_leftImg setImage:[UIImage imageNamed:@"listTag"]];
        [self addSubview:_leftImg];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.font = [UIFont systemFontOfSize:14.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.numberOfLines = 0;
        [self addSubview:_titleLbl];
        
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.font = [UIFont systemFontOfSize:13.0f];
        _timeLbl.textColor = [UIColor lightGrayColor];
        _timeLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:_timeLbl];
    }
    
    return self;
}

- (void)layoutSubviews
{
    CGRect frame;
    
    frame.origin.x = 10;
    frame.origin.y = 10;
    frame.size.width = 31;
    frame.size.height = 42;
    _leftImg.frame = frame;
    
    frame.origin.x += _leftImg.frame.size.width + 10;
    frame.size.width = 250;
    frame.size.height = 35;
    _titleLbl.frame = frame;
    
    frame.origin.y += _titleLbl.frame.size.height + 5;
    frame.size.width = 250;
    frame.size.height = 20;
    _timeLbl.frame = frame;
}

+ (NSUInteger)getCellHeight
{
    return 10 + 35 + 5 + 20 + 10;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
