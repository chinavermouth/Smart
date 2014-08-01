//
//  ComboBox.h
//  SocialReport
//
//  Created by J.H on 14-5-5.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ComboxDelegate;

@interface Combox : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UIButton *titleBtn;
    UITableView *comboTable;
}

@property (nonatomic, retain) id <ComboxDelegate> delegate;
@property (nonatomic, retain) NSArray *tableItems;
@property (nonatomic, retain) UIButton *titleBtn;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items inView:(UIView *)view;
- (void)setTitle:(NSString *)titleStr withTitleColor:(UIColor *)titleColor withTitleFontSize:(float)fontSize;

@end


@protocol ComboxDelegate <NSObject>

- (void)itemDidSelected:(NSInteger)index;

@end
