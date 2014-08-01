//
//  SuggestViewController.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-17.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeenToast.h"
#import "Common.h"

@interface SuggestViewController : UIViewController <UITextViewDelegate>
{
    UITextView *suggestTextView;
    LeenToast *myLeenToast;
    float keyboardHeight;
    
    UIToolbar* toolbarView;     //键盘工具栏
}

@end
