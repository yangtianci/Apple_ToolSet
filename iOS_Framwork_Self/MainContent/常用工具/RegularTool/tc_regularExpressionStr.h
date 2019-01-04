//
//  tc_regularExpressionStr.h
//  iOS_ExtentionToolLibiary
//
//  Created by YangTianCi on 2017/11/3.
//  Copyright © 2017年 ytc. All rights reserved.
//

#ifndef tc_regularExpressionStr_h
#define tc_regularExpressionStr_h



#pragma mark ======= 单一规则

//全部为中文
#define tcRegex_All_Is_Chinese @"^[\u4e00-\u9fa5]*$"

//全部是英文字符
#define tcRegex_All_Is_Letter @"^[a-zA-Z]+$"

//全部是大写英文
#define tcRegex_All_Is_CapitalLetter @"^[A-Z]+$"

//全部是小写英文
#define tcRegex_All_Is_LowercaseLetter @"^[a-z]+$"

//整数或者小数字符串 - 可能会增加负数判断, 增加 - 即可
#define tcRegex_IntegerAndDecimalString @"^[0-9]+([.]{0,1}[0-9]+){0,1}$"

//整数字符串
#define tcRegex_IntegerString @"^\\d+$"

//小数字符串
#define tcRegex_DecimalString @"^[0-9]+[.]{1}[0-9]+]$"

#pragma mark ======= 常用规则

//所有英文及数字组合
#define tcRegex_CharacterAndNumber @"^[a-zA-Z0-9]+$"

//大写英文及数字组合
#define tcRegex_CaptialLetterAndNumber @"^[A-Z0-9]+$"

//小写英文及数字组合
#define tcRegex_LowerletterAndNumber @"^[a-z0-9]+$"

//账号: 字母开头，允许5-16字节，允许字母数字下划线
#define tcRegex_NormalAccount @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$"

//密码: 以字母开头，长度在6~18之间，只能包含字母、数字和下划线
#define tcRegex_NormalPassword @"^[a-zA-Z]\\w{5,17}$"

#pragma mark ======= 常用字符串判断

//邮箱
#define tcRegex_EmailRegular @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"

//移动电话
#define tcRegex_TelephoneRegular @"^1[3|4|5|7|8][0-9]\\d{8}$"

//电话号码
#define tcRegex_PhoneRegular @"^(\(\\d{3,4}-)|\\d{3.4}-)?\\d{7,8}$"

//中国个人身份证
#define tcRegex_IDCardRegular @"\\d{14}[[0-9],0-9xX]"

//URL - 判断的条件好像不完全
#define tcRegex_UrlRegular @"[a-zA-z]+://[^\\s]*"

//QQ号
#define tcRegex_QQRegular @"[1-9][0-9]{4,}"

//中国邮政编码
#define tcRegex_PostCodeRegular @"[1-9]\\d{5}(?!\\d)"

//ip地址
#define tcRegex_IpAddressRegular @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)"

//域名
#define tcRegex_DominRegular @"[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(/.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+/.?"

#endif /* tc_regularExpressionStr_h */
