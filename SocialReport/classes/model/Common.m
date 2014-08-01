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

@synthesize m_strOpenUDID, m_tenantCode, m_buildingName, m_buildingNo, m_roomNo, m_parameterName, m_clientNo, m_clientName, m_subjectId, m_infoTitle, m_commCodeAry, m_commNoAry, m_commNameAry, m_reportId, m_reportTitle, m_reportStatus, m_imageCacheDic;

- (id)init
{
	if (self = [super init])
    {
        m_strOpenUDID = @"";
        m_imageCacheDic = [[NSMutableDictionary alloc] init];
    }
	return self;
}

+ (id)shared
{
    if (instance == nil){
        @synchronized(self){
            if (instance == nil){
                instance = [[Common alloc]init];
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
    if([m_imageCacheDic count] >= 50)
    {
        m_imageCacheDic = [[NSMutableDictionary alloc] init];
        NSLog(@"Up to 50 pics,clear image memory cache !");
    }
}

@end
