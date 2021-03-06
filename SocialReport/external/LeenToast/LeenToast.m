//
//  LeenToast.m
//  CarRepair
//
//  Created by lin bin on 12-2-15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LeenToast.h"
#import <QuartzCore/QuartzCore.h>


@implementation LeenToast

#define FontSize 15
#define LabelFont [UIFont fontWithName:@"Helvetica" size:FontSize]

-(id) init
{
    self = [super init];
    if(self)
    {
        durationTime = ToastDurationShort;
    }
    return  self;
}

- (void) show
{
	if (!view) {
		view=[[UIView alloc] init];
		//[[view layer] setBorderWidth:2.0];//画线的宽度
//		[[view layer] setBorderColor:[UIColor blackColor].CGColor];//颜色
//		[[view layer]setCornerRadius:15.0];//圆角
//		//v.backgroundColor=[UIColor redColor];
//		[view.layer setMasksToBounds:YES];
		
		view.layer.cornerRadius = 8;   
		view.layer.masksToBounds = YES;   
		//给图层添加一个有色边框   
		view.layer.borderWidth = 1;   
		view.layer.borderColor =[[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75] CGColor];// [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];   
		
		UILabel *label=[[UILabel alloc] init];
		label.tag=10;
		label.textAlignment=NSTextAlignmentCenter;
		label.numberOfLines=0;
		label.backgroundColor=[UIColor clearColor];
		label.textColor=[UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14.0f];
		[view addSubview:label];

	}
	
    // remove the last image from view
    for(int i=0; i<[view.subviews count]; i++)
    {
        UIView *subView = [view.subviews objectAtIndex:i];
        NSString * string=[NSString stringWithFormat:@"%@",[subView class]];
        if([string isEqualToString:@"UIImageView"])
        {
            [subView removeFromSuperview];
        }
    }
    
	if(!text)
	   text=@"nothing i do";
	
	UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	NSString *cellText = text;
	

    NSLog(@"x=%f,y=%f,center=(%f,%f)",window.frame.size.width,window.frame.size.height,window.center.x,window.center.y);
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        CGSize constraintSize = CGSizeMake(window.frame.size.height-40, MAXFLOAT);
        CGSize labelSize = [cellText sizeWithFont:LabelFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        view.frame=	CGRectMake(window.center.x-labelSize.width/+300, window.center.y-labelSize.height/2+130, labelSize.width+20, labelSize.height+20);
        view.userInteractionEnabled=YES;
        UILabel *label=(UILabel*)[view viewWithTag:10];
        label.text=text;
        label.frame=CGRectMake(10, 10, labelSize.width, labelSize.height);
        view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        
        CGAffineTransform at =CGAffineTransformMakeRotation(-M_PI/2);//先顺时钟旋转90
        at =CGAffineTransformTranslate(at,200,0);
        [view setTransform:at]; 
    }
    else {
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        CGSize labelSize = [cellText sizeWithFont:LabelFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        view.frame=	CGRectMake(window.center.x-labelSize.width/2-10, window.center.y-labelSize.height/2+140, labelSize.width+20, labelSize.height+20);
        UILabel *label=(UILabel*)[view viewWithTag:10];
        label.text=text;
        label.frame=CGRectMake(10, 10, labelSize.width, labelSize.height);
        view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    }
	
	[window addSubview:view];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:durationTime target:self selector:@selector(timerEvent) userInfo:nil repeats:NO] ;

	// call function when time is up (in this exemple :1 second. to change it, change scheduledTimerWithTimeInterval: 1 to value in second)
	
}

- (void) showWithImg:(UIImage *)image
{
	if (!view)
    {
        
		view=[[UIView alloc] init];
		view.layer.cornerRadius = 8;
		view.layer.masksToBounds = YES;
		//给图层添加一个有色边框
		view.layer.borderWidth = 1;
		view.layer.borderColor =[[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75] CGColor];// [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];
		
		UILabel *label=[[UILabel alloc] init];
		label.tag=10;
		label.textAlignment=NSTextAlignmentCenter;
		label.numberOfLines=0;
		label.backgroundColor=[UIColor clearColor];
		label.textColor=[UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14.0f];
		[view addSubview:label];
		
	}
    
    // remove the last image from view
    for(int i=0; i<[view.subviews count]; i++)
    {
        UIView *subView = [view.subviews objectAtIndex:i];
        NSString * string=[NSString stringWithFormat:@"%@",[subView class]];
        if([string isEqualToString:@"UIImageView"])
        {
            [subView removeFromSuperview];
        }
    }
    
    // add image into view
    if(image != nil)
    {
        CGRect frame = CGRectZero;
        messageIconImage = [[UIImageView alloc]initWithFrame:frame];
        messageIconImage.image = image;
    }
    
    [view addSubview:messageIconImage];
	
	if(!text)
        text=@"nothing i do";
	
	UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	NSString *cellText = text;
    
    NSLog(@"x=%f,y=%f,center=(%f,%f)",window.frame.size.width,window.frame.size.height,window.center.x,window.center.y);
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        CGSize constraintSize = CGSizeMake(window.frame.size.height-40, MAXFLOAT);
        CGSize labelSize = [cellText sizeWithFont:LabelFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        view.frame=	CGRectMake(window.center.x-labelSize.width/+300, window.center.y-labelSize.height/2+130, labelSize.width+20, labelSize.height+20);
        view.userInteractionEnabled=YES;
        UILabel *label=(UILabel*)[view viewWithTag:10];
        label.text=text;
        label.frame=CGRectMake(10, 10, labelSize.width, labelSize.height);
        view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        
        CGAffineTransform at =CGAffineTransformMakeRotation(-M_PI/2);//先顺时钟旋转90
        at =CGAffineTransformTranslate(at,200,0);
        [view setTransform:at];
    }
    else {
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        CGSize labelSize = [cellText sizeWithFont:LabelFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        view.frame=	CGRectMake(window.center.x-labelSize.width/2-10, window.center.y-labelSize.height/2+90, labelSize.width+20, labelSize.height+70);
        UILabel *label=(UILabel*)[view viewWithTag:10];
        label.text=text;
        label.frame=CGRectMake(10, 60, labelSize.width, labelSize.height);
        CGRect frame = CGRectZero;
        frame.origin.x = label.frame.origin.x + (label.frame.size.width - 48) / 2;
        frame.origin.y = label.frame.origin.y - 50;
        frame.size.width = 48;
        frame.size.height = 48;
        
        messageIconImage.frame = frame;
        view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    }
	
	[window addSubview:view];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:durationTime target:self selector:@selector(timerEvent) userInfo:nil repeats:NO] ;
    
	// call function when time is up (in this exemple :1 second. to change it, change scheduledTimerWithTimeInterval: 1 to value in second)
	
}


- (void)timerEvent
{
	[self dismiss];
}
-(void)dismiss
{
	[view removeFromSuperview];
}
- (LeenToast *) setDuration:(NSInteger ) duration
{
    durationTime = duration;
    return self;
}
- (void) settext:(NSString*)strtext
{
	text=strtext;
}
- (LeenToast *) setGravity:(ToastGravity) gravity offsetLeft:(NSInteger) left offsetTop:(NSInteger) top
{
    return  self;
}
- (LeenToast *) setGravity:(ToastGravity) gravity
{
     return  self;
}
- (LeenToast *) setPostion:(CGPoint) position
{
     return  self;
}

@end
