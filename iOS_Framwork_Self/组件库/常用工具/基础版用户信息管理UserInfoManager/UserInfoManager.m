
//
//  UserInfoManager.m
//  SignalModule
//
//  Created by 杨天赐 on 2019/4/29.
//  Copyright © 2019 YtcTestNoticfication. All rights reserved.
//

#import "UserInfoManager.h"

#import <objc/runtime.h>

#pragma mark ============================================== 数据模型


@implementation UserInfoModel


- (instancetype)initWithDictionary: (NSDictionary *)dictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

//容错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"\n\n%@值未找到属性\n\n",key);
}

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    [keyedValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNull class]]) {
            NSLog(@"\n\n\n妖兽啦,后台返回空类型啦!!!\n\n\n");
            obj = @"数据类型为NULL";
        }
        if ([obj isKindOfClass:[NSNumber class]]) {
            obj = [NSString stringWithFormat:@"%@",obj];
            NSLog(@"\n\n\n妖兽啦,后台返回number类型啦!!!\n\n\n");
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

@end




#pragma mark ============================================== 数据管理

@implementation UserInfoManager

+ (BOOL)checkLogin
{
    UserInfoModel *model = [self userInfoModel];
    if (1) {
        return NO;
    }
    return YES;
}

//更新model
+ (void)updateModel:(UserInfoModel *)Model
{
    NSMutableArray *pArr = [UserInfoManager GetAllPropertiesListWithModel:Model];
    for (int i = 0; i <pArr.count; i++) {
        id key = pArr[i];
        id string = [Model valueForKey:key];
        id value = [UserInfoManager safeFilterData:string];
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)safeFilterData:(id)data
{
    if ([data isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (data == nil) {
        return @"";
    }
    if ([data isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",data];
    }
    return data;
}

//获取model
+ (UserInfoModel *)userInfoModel
{
    UserInfoModel *model = [[UserInfoModel alloc] init];
    NSMutableArray *pArr = [UserInfoManager GetAllPropertiesListWithModel:model];
    for (int i = 0; i <pArr.count; i++) {
        id key = pArr[i];
        
        id content = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (content != [NSNull class]) {
            [model setValue:content forKey:key];
        }else{
            NSLog(@"出现空值");
        }
    }
    return model;
}

//获取userId
+ (NSString *)userInfoUserId
{
    UserInfoModel *model = [UserInfoManager userInfoModel];
    return nil;
}


//清空个人信息
+ (void)clearModel
{
    NSArray *userInfoKeys = [UserInfoManager GetAllPropertiesListWithModel:[[UserInfoModel alloc]init]];
    [userInfoKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:obj];
    }];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




+(NSMutableArray*)GetAllPropertiesListWithModel:(id)md{

    NSMutableArray *tempArr = [NSMutableArray array];
    
    unsigned int numIvars;
    Ivar *vars = class_copyIvarList([md class], &numIvars);
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        [tempArr addObject:key];
    }
    free(vars);
    return tempArr;
}


@end







