//
//  LeenToast.h
//  CarRepair
//
//  Created by lin bin on 12-2-15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum ToastGravity {
	
	ToastGravityTop = 1000001,
	
	ToastGravityBottom,
	
	ToastGravityCenter
	
}ToastGravity;

typedef enum ToastDuration {
	
	ToastDurationLong = 10,
	
	ToastDurationShort = 2,
	
	ToastDurationNormal = 3
	
}ToastDuration;

typedef enum ToastType {
	
	ToastTypeInfo = -100000,
	
	ToastTypeNotice,
	
	ToastTypeWarning,
	
	ToastTypeError
	
}ToastType;



//@class iToastSettings;

@interface LeenToast : NSObject {

	//iToastSettings *_settings;
	
	NSInteger offsetLeft;
	NSInteger offsetTop;
	NSTimer *timer;
	UIView *view;
	NSString *text;
    NSInteger durationTime;
    UIImageView *messageIconImage;
}

- (void) show;
- (void) dismiss;
- (void) settext:(NSString*)strtext;
- (LeenToast *) setDuration:(NSInteger ) duration;
- (LeenToast *) setGravity:(ToastGravity) gravity offsetLeft:(NSInteger) left offsetTop:(NSInteger) top;
- (LeenToast *) setGravity:(ToastGravity) gravity;
- (LeenToast *) setPostion:(CGPoint) position;
- (void) showWithImg:(UIImage *)image;


@end

//@interface iToastSettings : NSObject<NSCopying>{
//	NSInteger duration;
//	iToastGravity gravity;
//	CGPoint postition;
//	iToastType toastType;
//	NSDictionary *images;
//	BOOL positionIsSet;	
//}
//@property(assign) NSInteger duration;
//@property(assign) iToastGravity gravity;
//@property(assign) CGPoint postition;
//@property(readonly) NSDictionary *images;
//- (void) setImage:(UIImage *)img forType:(iToastType) type;
//+ (iToastSettings *) getSharedSettings;
//@end
