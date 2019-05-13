//
//  UserInfoManager.h
//  SignalModule
//
//  Created by 杨天赐 on 2019/4/29.
//  Copyright © 2019 YtcTestNoticfication. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 
 readme
 
 数据变更:
 
 UserInfoModel *md = [UserInfoManager userInfoModel];
 md 进行赋值或
 
 管理类:
 
 [UserInfoManager updateModel:md];

 延伸: 可以衍生基类, 处理不同数据存储
 
 UserInfoManager 基本可以说是独立于 UserInfoModel 存在的, 因此, 如果可能要管理多种数据时, 直接更换 model 即可, 关于路径之类的, 则需要进一步优化 
 
 
 */



@interface UserInfoModel : NSObject

// 示例 - 可修改
@property (copy, nonatomic) NSString *dataOne;
@property (nonatomic ,copy) NSString *userId;
@property (nonatomic ,copy) NSString *nickname;
@property (nonatomic,copy) NSString * mobilePhone;


- (instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end



@interface UserInfoManager : NSObject

//获取model
+ (UserInfoModel *)userInfoModel;

//更新model
+ (void)updateModel:(UserInfoModel *)Model;

//清空个人信息
+ (void)clearModel;

//检查登录
+ (BOOL)checkLogin;

//获取userId
+ (NSString *)userInfoUserId;


@end







NS_ASSUME_NONNULL_END
