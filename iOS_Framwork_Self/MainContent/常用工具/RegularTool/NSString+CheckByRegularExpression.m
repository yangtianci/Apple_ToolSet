//
//  NSString+CheckByRegularExpression.m
//  iOS_ExtentionToolLibiary
//
//  Created by YangTianCi on 2017/11/3.
//  Copyright © 2017年 ytc. All rights reserved.
//

#import "NSString+CheckByRegularExpression.h"

#import "tc_regularExpressionStr.h"

@implementation NSString (CheckByRegularExpression)


/**
 字符串长度范围
 如果最小值为nil, 判断是否超过最大长度, 最大长度为nil, 判断是否大于最小长度
 二者同时为nil, 返回no
 */
-(BOOL(^)(NSInteger minLength, NSInteger maxLength))tc_StrLength{
    return ^BOOL(NSInteger minLength, NSInteger maxLength){

        NSString *regularStr;

        if (maxLength <= 0 && minLength <= 0) {
            return NO;
        }

        if (self.length == 0 || self == nil) {
            return NO;
        }

        if (minLength >= 0 && maxLength > 0) {
            //最大有值, 取范围
            regularStr = [NSString stringWithFormat:@".{%zd,%zd}",minLength, maxLength];
        }
        
        if (minLength >= 0 && maxLength == 0) {
            //最大为空, 取是否大于
            regularStr = [NSString stringWithFormat:@".{%zd,}",minLength];
        }

        if (minLength == 0 && maxLength > 0) {
            //最小为空, 取是否小于
            if (self.length < maxLength) {
                return YES;
            }else{
                return NO;
            }
        }

        NSPredicate *predict = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];

        BOOL isRightful = [predict evaluateWithObject:self];

        return isRightful;

    };
}



/**
 
 主要包含内容
 
 * 提供常见的正则表达式
 
 * 常见字符串判断类: Email, IDCard, PhoneNumber等等
 * 常见规则类: 是否同时包含数字大写字母以及小写字母等等
 * 单一规则类: 是否为纯数字, 是否为纯汉字, 是否包含了特殊字符等等
 
 # 因为有三种正则判断手段, 每一种都有部分区别, 所以需要有所选择
 
 */

/**
 将宏文件中的正则字符串填充即可判断
 */
-(BOOL(^)(NSString *regularStr))tc_RegularStr{
    
    return ^BOOL(NSString *regularStr){
        if (self.length == 0 || self == nil || regularStr.length == 0) {
            return NO;
        }
        
        NSPredicate *predict = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];

        BOOL isRightful = [predict evaluateWithObject:self];
        
        return isRightful;
        
    };

}




/**
 
 演示类型API, 不调用
 
 */

-(void)ThreeMethodForUseRegularExpressionToJudgeStrFormatter{
    
    
    /**
     
     因为普通iOS应用中, 基本上只需要判断字符串的格式是否正确, 如果需要判断字符串中是否含有某个字符串, 并且得到目标字符串的范围, 直接使用其他API即可, 因此, 只需要调用正则的判断功能, 不需要查找功能, 因此, 不使用 NSRegularExpression 以及 rangeOfString 两种方式进行判断, 直接使用谓词进行判断
     
     */
    
    /**
    
    NSString *regularStr = @"\\d[0-9]?";
    NSString *bejudgeStr = @"bejudgeStr";
    
    //谓词

    NSPredicate *predict = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF MATCHES %@",regularStr]];
    BOOL isRight = [predict evaluateWithObject:bejudgeStr];
    
    //正则
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc]initWithPattern:regularStr options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSArray *regularResultArr = [regularExpression matchesInString:bejudgeStr options:NSMatchingReportCompletion range:NSMakeRange(0, bejudgeStr.length)];
    NSTextCheckingResult *result = regularResultArr.firstObject;
    
    //sting - 库内不使用, API已经足够简洁
    NSRange resultRange = [bejudgeStr rangeOfString:regularStr options:NSRegularExpressionSearch];

     */
    
}












@end
