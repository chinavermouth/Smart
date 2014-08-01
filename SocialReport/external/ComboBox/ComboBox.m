//
//  ComboBox.m
//  SocialReport
//
//  Created by J.H on 14-5-5.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "ComboBox.h"


@implementation Combox

@synthesize delegate, tableItems, titleBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items inView:(UIView *)view
{
    self = [self initWithFrame:frame];
    self.tableItems = items;
    titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setFrame:CGRectMake(0, 0, frame.size.width, 35)];
    [titleBtn setTitle:@"未选择" forState:UIControlStateNormal];
    [titleBtn setBackgroundImage:[UIImage imageNamed:@"public_TitleBg"] forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleBtnDidTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleBtn];
    
    // 下拉图标
    UIImageView *btnArr = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 37, 2.5, 30, 30)];
    btnArr.image = [UIImage imageNamed:@"arrow_down"];
    [self addSubview:btnArr];
    
    // combox表格
    comboTable = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + 35, frame.size.width, 28 * items.count) style:UITableViewStylePlain];
    comboTable.delegate = self;
    comboTable.dataSource = self;
    comboTable.hidden = YES;
    [view addSubview:comboTable];
    
    // 表格圆边框
    comboTable.layer.borderWidth = 1;
    comboTable.layer.cornerRadius = 7;
    comboTable.layer.borderColor = [[UIColor orangeColor] CGColor];
//    comboTable.separatorColor = [UIColor redColor];
    
    return self;
}

- (void)setTitle:(NSString *)titleStr withTitleColor:(UIColor *)titleColor withTitleFontSize:(float)fontSize
{
    [titleBtn setTitle:titleStr forState:UIControlStateNormal];
    [titleBtn setTitleColor:titleColor forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
}

- (void)titleBtnDidTaped:(id)sender
{
    comboTable.hidden = !comboTable.hidden;
}


#pragma mark UITableViewDataSource

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableItems.count;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CELLIDENTIFIER";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }
    
    cell.textLabel.text = [tableItems objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self setTitle:[tableItems objectAtIndex:indexPath.row] withTitleColor:[UIColor blackColor] withTitleFontSize:15.0f];
    tableView.hidden = YES;
    // 若有实现协议方法，则调用协议
    if ([delegate respondsToSelector:@selector(itemDidSelected:)])
    {
        [delegate itemDidSelected:indexPath.row];
    }
}

@end
