//
//  CommunicationHttp.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Common.h"
#import "ASIFormDataRequest.h"

@interface CommunicationHttp : NSObject <ASIHTTPRequestDelegate>
{
    ASIHTTPRequest* requestStatus;
    Common *myCommon;
}

/*HTTP信息上传接口
 *  msgType:消息类型
 *  threadType:0-用新线程;1-不用新线程
 *  strJsonContent: json的字符串
 */
- (NSDictionary *)sendHttpRequest:(HTTPMESSAGETYPE) msgType
                       threadType:(int) threadType
                   strJsonContent:(NSString *) strJsonContent;


@end
