//
//  PersonInfoDetailViewController.h
//  SocialReport
//
//  Created by J.H on 14-4-1.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfoDetailViewController : UIViewController
{
    UITextView *infoTextView;
    NSDictionary *infoDic;
    NSMutableString *arrInfoStr;
}

- (id)initWithPersonInfoDetail:(NSDictionary *)infoDetail;

@end
