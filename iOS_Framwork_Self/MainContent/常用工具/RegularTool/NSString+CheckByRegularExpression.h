//
//  NSString+CheckByRegularExpression.h
//  iOS_ExtentionToolLibiary
//
//  Created by YangTianCi on 2017/11/3.
//  Copyright © 2017年 ytc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckByRegularExpression)

/**
 字符串长度范围
 如果最小值为nil, 判断是否超过最大长度, 最大长度为nil, 判断是否大于最小长度
 二者同时为nil, 返回no
 */
-(BOOL(^)(NSInteger minLength, NSInteger maxLength))tc_StrLength;

/**
 将宏文件中的正则字符串填充即可判断
 */
-(BOOL(^)(NSString *regularStr))tc_RegularStr;



@end
