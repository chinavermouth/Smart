//
//  CommunicationHttp.m
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "CommunicationHttp.h"
#import "JSON.h"

@implementation CommunicationHttp

- (id)init
{
    self = [super init];
    if (self) {
        myCommon = [Common shared];
    }
    return self;
}

#pragma mark - HTTP信息上传接口
- (NSDictionary *)sendHttpRequest:(HTTPMESSAGETYPE) msgType
                       threadType:(int) threadType
                   strJsonContent:(NSString *) strJsonContent;
{
    NSDictionary *dicResult = [[NSDictionary alloc] init];
    switch (msgType) {
            
        case HTTP_IMAGETEST:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(imageConnection:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self imageConnection:strJsonContent];
            }
            break;
            
        case HTTP_TEST:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(testConnection) toTarget:self withObject:nil];
            }
            else
            {
                [self testConnection];
            }
            break;
            
        case HTTP_UPDATE:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(updateRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self updateRequest:strJsonContent];
            }
            break;
            
        case HTTP_AUTOLOGINAUTH:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(autoLgnAuthRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self autoLgnAuthRequest:strJsonContent];
            }
            break;
            
        case HTTP_LOGIN:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(loginRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self loginRequest:strJsonContent];
            }
            break;
            
        case HTTP_LISTREGION:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(listRegionRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self listRegionRequest:strJsonContent];
            }
            break;
            
        case HTTP_LISTBUILDING:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(listBuildingRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self listBuildingRequest:strJsonContent];
            }
            break;

        case HTTP_ARRSEARCH:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(arrSearchRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self arrSearchRequest:strJsonContent];
            }
            break;
            
        case HTTP_LISTROOM:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(listRoomRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self listRoomRequest:strJsonContent];
            }
            break;
            
        case HTTP_LISTPERSON:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(listPersonRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self listPersonRequest:strJsonContent];
            }
            break;
            
        case HTTP_MOVEOUT:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(moveOutRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self moveOutRequest:strJsonContent];
            }
            break;
            
        case HTTP_GETPARAM:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(getParamRequest) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self getParamRequest];
            }
            break;
            
        case HTTP_MOVEIN:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(moveInRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self moveInRequest:strJsonContent];
            }
            break;
            
        case HTTP_RENT:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(rentRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self rentRequest:strJsonContent];
            }
            break;
            
        case HTTP_LISTREPORT:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(listReportRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self listReportRequest:strJsonContent];
            }
            break;
            
        case HTTP_REPORTDETAIL:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(reportDetailRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self reportDetailRequest:strJsonContent];
            }
            break;
            
        case HTTP_GETINFORMATION:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(getInformationRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self getInformationRequest:strJsonContent];
            }
            break;
            
        case HTTP_GETINFORDETAIL:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(getInfoDetailRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self getInfoDetailRequest:strJsonContent];
            }
            break;
            
        case HTTP_PUBINFORMATION:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(pubInformationRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self pubInformationRequest:strJsonContent];
            }
            break;
            
        case HTTP_COMINFORMATION:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(comInformationRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self comInformationRequest:strJsonContent];
            }
            break;
            
        case HTTP_CREATENOTICE:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(createNoticeRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self createNoticeRequest:strJsonContent];
            }
            break;
            
        case HTTP_GETTENANTINFO:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(getTenantInfoRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self getTenantInfoRequest:strJsonContent];
            }
            break;
            
        case HTTP_CREATEORUPDATETENANTINFO:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(createOrUpdateTenantInfoRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self createOrUpdateTenantInfoRequest:strJsonContent];
            }
            break;
            
        case HTTP_GETFEEDBACKS:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(getFeedbacksRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self getFeedbacksRequest:strJsonContent];
            }
            break;
            
        case HTTP_GETFEEDBACKDETAILS:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(getFeedbackDetailsRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self getFeedbackDetailsRequest:strJsonContent];
            }
            break;
            
        case HTTP_APPENDFEEDBACK:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(appendFeedbackRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self appendFeedbackRequest:strJsonContent];
            }
            break;
            
        case HTTP_GETCOMMUNITYADDRESSLIST:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(getCommAddListRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self getCommAddListRequest:strJsonContent];
            }
            break;
            
        case HTTP_DELETEADDRESSLIST:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(deleteAddressListRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self deleteAddressListRequest:strJsonContent];
            }
            break;
        
        case HTTP_CREATEADDRESSLIST:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(createAddressListRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self createAddressListRequest:strJsonContent];
            }
            break;
            
        case HTTP_GETCOMMUNITYINFO:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(getCommunityInfoRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self getCommunityInfoRequest:strJsonContent];
            }
            break;
            
        case HTTP_CREATEORUPDATECOMMINFO:
            if (threadType == 0)
            {
                [NSThread detachNewThreadSelector:@selector(createOrUpdateCommInfoRequest:) toTarget:self withObject:strJsonContent];
            }
            else
            {
                dicResult = [self createOrUpdateCommInfoRequest:strJsonContent];
            }
            break;
            
        default:
            break;
    }
    return dicResult;
}


#pragma mark - 测试连接

- (void)testConnection
{
    
// make request
    
//// 不带中文参数请求
//    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://www.pmsaas.net/AppInterface/IApp3/GetRoomArrears?roomNo=JXY-01-1-0201A&buildNo=JXY-01&communityNo=JXY&tenantCode=56298&UID=fa26a5f2-8cfe-4341-85c0-768d12cc0678"]];
    
// 带中文参数请求
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.pmsaas.net/AppInterface/IApp3/GetParameter"]];
    [request setPostValue:@"客户档案" forKey:@"moduleName"];
    [request setPostValue:@"与户主关系" forKey:@"ParamperName"];
    [request setPostValue:@"56298" forKey:@"tenantCode"];
    [request setPostValue:@"" forKey:@"productCode"];
    [request setPostValue:@"fa26a5f2-8cfe-4341-85c0-768d12cc0678" forKey:@"UID"];
    
    // send request
    [request startSynchronous];
    
    // get response
    NSString* respString = [request responseString];
    NSLog(@"testConnection respString = %@",respString);
    //    NSDictionary *dicResult = [respString JSONValue];
    
}

#pragma mark ---

- (NSDictionary *)imageConnection:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            NSLog(@"strJsonContent = %@",strJsonContent);
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",HTTPURL_IMAGEDATABASE]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"imageConnection respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"imageConnection error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 检查版本更新

- (NSDictionary *)updateRequest:(NSString *) strJsonContent
{
    return NULL;
}

#pragma mark - 自动登录验证

- (NSDictionary *)autoLgnAuthRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"autoLgnAuthRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 登录请求

- (NSDictionary *)loginRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"loginRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}


#pragma mark - 列出小区请求

- (NSDictionary *)listRegionRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"listRegionRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"listRegionRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 列出楼宇请求

- (NSDictionary *)listBuildingRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"listBuildingRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 欠费查询请求

- (NSDictionary *)arrSearchRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"listBuildingRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 列出房间请求

- (NSDictionary *)listRoomRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"listRoomRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 列出使用人或者业主信息

- (NSDictionary *)listPersonRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"listPersonRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"listPersonRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 用户迁出

- (NSDictionary *)moveOutRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request 为了识别{}，需用stringByAddingPercentEscapesUsingEncoding方法
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[strJsonContent stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"moveOutRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"moveOutRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 获取参数列表

- (NSDictionary *)getParamRequest
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            // 带中文参数请求
            ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:HTTPURL_GETPARAM]];
            [request setPostValue:@"客户档案" forKey:@"moduleName"];
            [request setPostValue:myCommon.m_parameterName forKey:@"ParamperName"];
            [request setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:TENANTCODE] forKey:@"tenantCode"];
            [request setPostValue:@"" forKey:@"productCode"];
            [request setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:UID] forKey:@"UID"];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            //            NSLog(@"respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"moveOutRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 用户迁入 (post)

- (NSDictionary *)moveInRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_MOVEIN,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"moveInRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"moveInRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 出租出售 (post)

- (NSDictionary *)rentRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_RENT,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"rentRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 列出通知公告请求

- (NSDictionary *)listReportRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"listReportRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"listReportRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 通知公告明细

- (NSDictionary *)reportDetailRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"reportDetailRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"reportDetailRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 安防巡查、故障申告、环境卫生(返回主题列表)

- (NSDictionary *)getInformationRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"getInformationRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"getInformationRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 安防巡查、故障申告、环境卫生(返回主题明细列表)

- (NSDictionary *)getInfoDetailRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"getInfoDetailRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"getInfoDetailRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 安防巡查、故障申告、环境卫生(提交主题) (post)

- (NSDictionary *)pubInformationRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_PUBINFORMATION,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"pubInformationRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"pubInformationRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }

}

#pragma mark - 安防巡查、故障申告、环境卫生(追加记录) (post)

- (NSDictionary *)comInformationRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_COMINFORMATION,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"comInformationRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"comInformationRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }

}

#pragma mark - 创建通知公告(社区和物业公司都可以发布，共用这个接口) (post)

- (NSDictionary *)createNoticeRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_CREATENOTICE,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"createNoticeRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"createNoticeRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 返回社区信息或者物业公司信息

- (NSDictionary *)getTenantInfoRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"getTenantInfoRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"getTenantInfoRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 创建编辑社区或物业信息(社区和物业公司都可以发布，共用这个接口) (post)

- (NSDictionary *)createOrUpdateTenantInfoRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_CREATEORUPDATETENANTINFO,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"createOrUpdateTenantInfoRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"createOrUpdateTenantInfoRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 返回社区信息或者物业公司信息

- (NSDictionary *)getFeedbacksRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[strJsonContent stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"getFeedbacksRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"getFeedbacksRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 返回故障申告帖子明细

- (NSDictionary *)getFeedbackDetailsRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"getFeedbackDetailsRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"getFeedbackDetailsRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 追加故障申告、意见反馈(物业公司对业主提出的问题的处理，使用此接口回复) (POST)

- (NSDictionary *)appendFeedbackRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_APPENDFEEDBACK,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"appendFeedbackRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"appendFeedbackRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 获得物业客服通讯录列表

- (NSDictionary *)getCommAddListRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"getCommAddListRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"getCommAddListRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 删除通讯录

- (NSDictionary *)deleteAddressListRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"deleteAddressListRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"deleteAddressListRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 创建通讯录 (POST)

- (NSDictionary *)createAddressListRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_CREATEADDRESSLIST,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
//            NSLog(@"createAddressListRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"createAddressListRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 获取小区信息

- (NSDictionary *)getCommunityInfoRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strJsonContent]];
            
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"getCommunityInfoRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"getCommunityInfoRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

#pragma mark - 创建或编辑小区信息 (POST)

- (NSDictionary *)createOrUpdateCommInfoRequest:(NSString *) strJsonContent
{
    @autoreleasepool
    {
        NSString *strLog = @"";
        NSDictionary *dicResult = nil;
        @try {
            
            // post data
            NSData *postBody = [strJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            // post length
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
            
            // make request
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?UID=%@",HTTPURL_CREATEORUPDATECOMMINFO,[[NSUserDefaults standardUserDefaults] objectForKey:UID]]]];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Content-Length" value:postLength];
            [request setRequestMethod:@"POST"];
            [request appendPostData:postBody];
            [request setValidatesSecureCertificate:NO];
            [request startSynchronous];
            
            // get response
            NSString* respString = [request responseString];
            NSLog(@"createOrUpdateCommInfoRequest respString = %@",respString);
            NSDictionary *dicResult = [respString JSONValue];
            
            return dicResult;
            
        }
        
        @catch (NSException *exception) {
            strLog = [NSString stringWithFormat:@"createOrUpdateCommInfoRequest error:catch error(%@)",exception];
            NSLog(@"%@",strLog);
            return dicResult;
            
        }
        return dicResult;
    }
}

@end
