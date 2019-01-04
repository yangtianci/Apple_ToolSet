//
//  TCLayoutTool.m
//  JiMi
//
//  Created by YangTianCi on 2018/5/8.
//  Copyright © 2018年 www.JiMi.com. All rights reserved.
//

#import "TCLayoutTool.h"

#import <sys/utsname.h>

@implementation TCLayoutTool

#pragma mark >>>>>>>>>> 创建单例

+(instancetype)shareInstance{
    static TCLayoutTool *layoutTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        layoutTool = [[TCLayoutTool alloc] init];
    });
    return layoutTool;
}

#pragma mark >>>>>>>>>> 计算字体高度宽度函数

-(float)GetHeightWithFont:(UIFont*)font Content:(NSString*)content Width:(CGFloat)width{
    
    if (![content isKindOfClass:[NSString class]]) {
        return 20;
    }
    
    if (content.length <= 0) {
        return 20;
    }
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return size.height;
    
}

-(float)GetWidthWithFont:(UIFont*)font Content:(NSString*)content Height:(CGFloat)height{
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
}

//首先查看对应字体是否有已经计算好的结果
-(void)checkCache{
    /**
     
     经过研究, 似乎不能完成缓存存储
     1. 如果需要计算单行高度, 则直接使用 font 的 lineHeight 属性即可
     2. 多行高度, 需要指定字符串, 基本不太可能获取重复值
     3. 如果是单行的宽度同理, 数据在变动
     4. 多行的宽度一般都是固定的...
     
     */
}

#pragma mark ============ 获取当前机型
-(NSString*)GetDeviceType{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    NSString *regularStr = @"[\\d]+,";
    __block NSString *resultString;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularStr options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    [expression enumerateMatchesInString:platform options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, platform.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSRange range = result.range;
        range.length -= 1;
        resultString = [platform substringWithRange:range];
    }];
    
    return  resultString;
    
}





@end
