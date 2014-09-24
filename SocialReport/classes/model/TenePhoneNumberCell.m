//
//  TenePhoneNumberCell.m
//  SocialReport
//
//  Created by J.H on 14-9-2.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "TenePhoneNumberCell.h"
#import "Common.h"

@implementation TenePhoneNumberCell

@synthesize phoneNumLbl = _phoneNumLbl, rightDelImg = _rightDelImg, rightDelBtn = _rightDelBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _phoneNumLbl = [[UILabel alloc] init];
        _phoneNumLbl.font = [UIFont systemFontOfSize:13.0f];
        _phoneNumLbl.textColor = [UIColor blackColor];
        [self addSubview:_phoneNumLbl];
        
        _rightDelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_rightDelBtn];
        
        _rightDelImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"teneMinus"]];
        [_rightDelBtn addSubview:_rightDelImg];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect frame;
    
    frame.origin.x = 15;
    frame.origin.y = 10;
    frame.size.width = 200;
    frame.size.height = 20;
    _phoneNumLbl.frame = frame;
    
    frame.origin.x = SCREEN_SIZE.width - 17 - 50;
    frame.origin.y = 0;
    frame.size.width = 50 + 17;
    frame.size.height = 40;
    _rightDelBtn.frame = frame;
    
    frame.origin.x = 30;
    frame.origin.y = 10;
    frame.size.width = 20;
    frame.size.height = 20;
    _rightDelImg.frame = frame;
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
