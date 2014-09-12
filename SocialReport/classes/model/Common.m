//
//  Common.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "Common.h"
#import "OpenUDID.h"

static Common *instance;

@implementation Common

@synthesize m_strOpenUDID = _m_strOpenUDID, m_imageCacheDic = _m_imageCacheDic, m_userPermissionAry = _m_userPermissionAry;

- (id)init
{
	if (self = [super init])
    {
        _m_strOpenUDID = @"";
        _m_imageCacheDic = [[NSMutableDictionary alloc] init];
        _m_userPermissionAry = [[NSUserDefaults standardUserDefaults] objectForKey:USERPERMISSIONARY];
    }
    
	return self;
}

+ (id)shared
{
    if (instance == nil){
        @synchronized(self){
            if (instance == nil){
                instance = [[Common alloc] init];
            }
        }
    }
    
    return instance;
}

// 获取本机的OpenUDID
- (NSString *)getOpenUDID
{
    return [OpenUDID value];
}

// 检查图片内存缓存
- (void)checkImageMemoryCache
{
    if([_m_imageCacheDic count] >= 50)
    {
        _m_imageCacheDic = [[NSMutableDictionary alloc] init];
        NSLog(@"Up to 50 pics,clear image memory cache !");
    }
}

@end
