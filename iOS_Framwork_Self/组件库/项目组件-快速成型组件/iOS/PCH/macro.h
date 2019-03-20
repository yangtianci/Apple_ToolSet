//
//  macro.h
//  JiMi
//
//  Created by YangTianCi on 2018/4/24.
//  Copyright © 2018年 www.JiMi.com. All rights reserved.
//

#ifndef macro_h
#define macro_h


//弱引用
#define DefineWS __weak typeof(self)WS = self;

//tableView标识符
#define kIdentifierCell @"identifierForTavleViewCell"
#define kIdentifierCellTwo @"identifierForTavleViewCellTwo"
#define kIdentifierSupplementHeader @"identifierForSupplementHeader"
#define kIdentifierSupplementFooter @"identifierForSupplementFooter"


#pragma mark =======================   基本用户数据字段名称



#pragma mark =======================   加载提示

#define kNetLoad    @"正在加载中..."

//常用网络反馈信息
#define kNormalFailMsg    @"网络连接失败,请稍后重试..."
#define NOT_CONNECT_TO_INTERNET_PROMPT  @"似乎已断开与互联网的连接"
#define TIME_OUT_PROMPT                 @"服务器连接超时，请稍后重试"
#define CAN_NOT_CONNECT_TO_HOST_PROMPT  @"服务器连接超时，请稍后重试"
#define CAN_NOT_FIND_HOST_PROMPT        @"主机名称错误,请稍后重试..."
#define UNKOWN_ERROR_PROMPT             @"未知错误,请稍后重试..."


//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark =======================   目录宏
/**
 常用目录宏
 */
//沙盒目录

#define kPathTemp                   NSTemporaryDirectory()

#define kPathDocument               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kPathCache                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#pragma mark ======================= 友盟账户

#define U_MENG_APPKEY       @""
#define U_MENG_TEST_APPKEY  @""

#define WECHAT_APPID        @""
#define WECHAT_APPSECRET    @""

#define QQ_APPID            @""
#define QQ_APPKEY           @""

#define SINA_APPID          @""
#define SINA_APPKEY         @""

#define SHARE_URL           @""



#endif /* macro_h */
