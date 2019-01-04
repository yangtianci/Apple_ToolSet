//
//  BaseModel.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/13.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "BaseModel.h"
#import <MJExtension.h>

@implementation BaseModel
//快速归接档
MJCodingImplementation

-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    [keyedValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = @"~"; // 后台返回空类型
        }
        if ([obj isKindOfClass:[NSNumber class]]) {
            obj = [NSString stringWithFormat:@"%@",obj]; // 后台返回number类型
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            obj = [obj mutableCopy];
        }
        if ([obj isKindOfClass:[NSArray class]]) {
            obj = [obj mutableCopy];
        }
        [self setValue:obj forKey:key];
    }];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //    DLog(@"\n%@ --- 不存在\n",key);
}

@end
