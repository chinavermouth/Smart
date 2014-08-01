//
//  Common.h
//  SocialReport
//
//  Created by HuXiaoBin on 14-2-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SYSTEM_VERSION   [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_SIZE  [UIScreen mainScreen].bounds.size

// 请求地址
#define HTTPURL_UPDATE      @"http://xxxxxxxxx"     // 检查更新
#define HTTPURL_IMAGEDATABASE   @"http://app.pmsaas.net"     // 图片位置
#define HTTPURL_AUTOLOGINAUTH      @"http://app.pmsaas.net/IApp3/IsAuthenticated"        // 自动登录认证
#define HTTPURL_LOGIN      @"http://app.pmsaas.net/IApp3/Login"        // 用户登录
#define HTTPURL_LISTREGION     @"http://app.pmsaas.net/IApp3/GetOrgs"      // 列出小区
#define HTTPURL_LISTBUILDING   @"http://app.pmsaas.net/IApp3/GetBuildings"     // 列出楼宇
#define HTTPURL_ARRSEARCH      @"http://app.pmsaas.net/IApp3/GetRoomArrears"       // 欠费查询
#define HTTPURL_LISTROOM   @"http://app.pmsaas.net/IApp3/GetRooms"     // 列出房间
#define HTTPURL_LISTPERSON   @"http://app.pmsaas.net/IApp3/GetRoomClient"     // 列出使用人或者业主信息
#define HTTPURL_MOVEIN    @"http://app.pmsaas.net/IApp3/RegisterIDCard"      // 人员入住
#define HTTPURL_MOVEOUT     @"http://app.pmsaas.net/IApp3/OutRoomClient"     // 人员迁出
#define HTTPURL_GETPARAM    @"http://app.pmsaas.net/IApp3/GetParameter"       // 获取入住参数
#define HTTPURL_RENT      @"http://app.10057.com/App3/CreateInformation"       // 出租出售
#define HTTPURL_LISTREPORT   @"http://app.pmsaas.net/IApp3/GetNoticeList"     // 列出通知公告
#define HTTPURL_REPORTDETAIL  @"http://app.pmsaas.net/IApp3/GetNotice"    // 通知公告详细
#define HTTPURL_GETINFORMATION    @"http://app.pmsaas.net/IApp3/GetInformations"   // 安防巡查、故障申告、环境卫生(返回主题列表)
#define HTTPURL_GETINFORDETAIL    @"http://app.pmsaas.net/IApp3/GetInformationDetails"   // 安防巡查、故障申告、环境卫生(返回主题明细列表)
#define HTTPURL_PUBINFORMATION    @"http://app.pmsaas.net/IApp3/Information"    // 安防巡查、故障申告、环境卫生(提交主题)
#define HTTPURL_COMINFORMATION    @"http://app.pmsaas.net/IApp3/InformationDetail"    // 安防巡查、故障申告、环境卫生(追加记录)
#define HTTPURL_CREATENOTICE      @"http://app.pmsaas.net/IApp3/CreateNotice"        // 创建通知公告(社区和物业公司都可以发布，共用这个接口)
#define HTTPURL_GETTENANTINFO        @"http://app.pmsaas.net/IApp3/GetTenantInfo"    // 返回社区信息或者物业公司信息
#define HTTPURL_CREATEORUPDATETENANTINFO   @"http://app.pmsaas.net/IApp3/CreateOrUpdateTenantInfo"   // 创建编辑社区或物业信息(社区和物业公司都可以发布，共用这个接口)
#define HTTPURL_GETFEEDBACKS        @"http://app.pmsaas.net/IApp3/GetFeedbacks"    // 返回用户提交的故障申告、意见反馈列表
#define HTTPURL_GETFEEDBACKDETAILS  @"http://app.pmsaas.net/IApp3/GetFeedbackDetails"    // 返回故障申告帖子明细
#define HTTPURL_APPENDFEEDBACK      @"http://app.pmsaas.net/IApp3/AppendFeedback"     // 追加故障申告、意见反馈(支持多张图片同时上传)


#define  SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
#define  SCREEN_SIZE     [UIScreen mainScreen].bounds.size
#define  SIGNLINE_HEIGHT     20
#define  NAV_HEIGHT          44
#define  TAB_HEIGHT          49

#define  ISFIRSTLOGIN    @"isFirstLogin"      // 检查是否登录成功过
#define  UID             @"UID"               // 请求令牌口令
#define  USERID          @"UserID"            // 用户ID
#define  USERNAME        @"UserName"          // 用户名
#define  TENANTCODE      @"TenantCode"        // 租户号
#define  COMMUNITYNO     @"communityNo"       // 小区号
#define  COMMUNITYCODE   @"communityCode"     // 小区代码
#define  COMDISPLAYNAME  @"comDisplayName"    // 小区显示名称


// ENUM定义
typedef enum
{
    HTTP_IMAGETEST = -2,
    HTTP_TEST = -1,     // 测试
    HTTP_UPDATE = 0,     // 检查更新
    HTTP_AUTOLOGINAUTH = 1,     //自动登录认证
    HTTP_LOGIN = 2,     // 用户登录
    HTTP_LISTREGION = 3,    // 列出小区
    HTTP_LISTBUILDING = 4,   // 列出楼宇
    HTTP_ARRSEARCH = 5,       // 欠费查询
    HTTP_LISTROOM = 6,       // 列出房间
    HTTP_LISTPERSON = 7,      // 列出使用人或者业主信息
    HTTP_MOVEOUT = 8,        // 人员迁出
    HTTP_GETPARAM = 9,       // 参数列表
    HTTP_MOVEIN = 10,         // 人员入住
    HTTP_RENT = 11,          // 出租出售
    HTTP_LISTREPORT = 12,         // 列出通知公告
    HTTP_REPORTDETAIL = 13,    // 通知公告详细
    HTTP_GETINFORMATION = 14,        // 安防巡查、故障申告、环境卫生(返回主题列表)
    HTTP_GETINFORDETAIL = 15,        // 安防巡查、故障申告、环境卫生(返回主题明细列表)
    HTTP_PUBINFORMATION = 16,    // 安防巡查、故障申告、环境卫生(提交主题)
    HTTP_COMINFORMATION = 17,    // 安防巡查、故障申告、环境卫生(追加记录)
    HTTP_CREATENOTICE = 18,      // 创建通知公告(社区和物业公司都可以发布，共用这个接口)
    HTTP_GETTENANTINFO = 19,     // 返回社区信息或者物业公司信息
    HTTP_CREATEORUPDATETENANTINFO = 20,     // 创建编辑社区或物业信息(社区和物业公司都可以发布，共用这个接口)
    HTTP_GETFEEDBACKS = 21,      // 返回用户提交的故障申告、意见反馈列表
    HTTP_GETFEEDBACKDETAILS = 22,   // 返回故障申告帖子明细
    HTTP_APPENDFEEDBACK = 23,    // 追加故障申告、意见反馈(支持多张图片同时上传)
    
}HTTPMESSAGETYPE;


@interface Common : NSObject
//{
//    // openUdid
//    NSString *m_strOpenUDID;
//    // 租户号
//    NSString *m_tenantCode;
//    // 楼宇名称
//    NSString *m_buildingName;
//    // 楼宇代码
//    NSString *m_buildingNo;
//    // 房间号
//    NSString *m_roomNo;
//    // 参数名称
//    NSString *m_parameterName;
//    // 用户编号
//    NSString *m_clientNo;
//    // 用户名称
//    NSString *m_clientName;
//    // 信息主题ID
//    NSString *m_subjectId;
//    // 信息title
//    NSString *m_infoTitle;
//    // 小区代码数组
//    NSMutableArray *m_commCodeAry;
//    // 小区编号数组
//    NSMutableArray *m_commNoAry;
//    // 小区名称数组
//    NSMutableArray *m_commNameAry;
//    // 申告帖子ID
//    NSString *m_reportId;
//    // 申告帖子标题
//    NSString *m_reportTitle;
//    // 申告帖子处理状态
//    NSString *m_reportStatus;
//}

@property (nonatomic, retain)  NSString *m_strOpenUDID;
@property (nonatomic, retain)  NSString *m_tenantCode;
@property (nonatomic, retain)  NSString *m_buildingName;
@property (nonatomic, retain)  NSString *m_buildingNo;
@property (nonatomic, retain)  NSString *m_roomNo;
@property (nonatomic, retain)  NSString *m_parameterName;
@property (nonatomic, retain)  NSString *m_clientNo;
@property (nonatomic, retain)  NSString *m_clientName;
@property (nonatomic, retain)  NSString *m_subjectId;
@property (nonatomic, retain)  NSString *m_infoTitle;
@property (nonatomic, retain)  NSMutableArray *m_commCodeAry;
@property (nonatomic, retain)  NSMutableArray *m_commNoAry;
@property (nonatomic, retain)  NSMutableArray *m_commNameAry;
@property (nonatomic, retain)  NSString *m_reportId;
@property (nonatomic, retain)  NSString *m_reportTitle;
@property (nonatomic, retain)  NSString *m_reportStatus;
@property (nonatomic, retain)  NSMutableDictionary *m_imageCacheDic;     // 内存图片缓存数组


+ (id)shared;
- (NSString *)getOpenUDID;
- (void)checkImageMemoryCache;

@end