//
//  DataStoreMan.h
//  DataTransformer
//
//  Created by 杨天赐 on 2019/5/31.
//  Copyright © 2019 YtcTestNoticfication. All rights reserved.
//

#import <Foundation/Foundation.h>



#pragma mark ============================================== AccountList


#define firstCustomer @"firstCustomer"





NS_ASSUME_NONNULL_BEGIN

// 私人设计模式: 数据保管员

/**
 
 Out : 数据保管员, 负责数据的存储与提取, 不关心任何业务, 如同保管员身份, 提供身份证明, 进行存储提取修改, 适用于不同时期被创建的对象共享同一份数据的情况, 解决时序错乱的问题, 增加业务灵活度
 
 甚至可以完成不同线程之间的数据, 信息共享和通用业务
 
 使用方式:
    存储时, 生成秘钥并存储
    提取时, 根据秘钥提取
    修改时, 对账户内容进行操作即可
 
 特点: 跨时间, 跨域, 跨对象, 全生命周期存在
 
 后续: 硬盘持久化
 
 */

@interface DataStoreMan : NSObject

+(instancetype)ShareInstance;

-(BOOL)CheckAccountWithKey:(NSString*)key;

-(NSString*)CreatSecretKeyWithDepositer:(Class)depositer customeKey:(NSString*)cKey;

-(void)Storeman_StoreDataWithKey:(NSString *)key Value:(id)value Response:(void(^)(NSDictionary *info))response;

-(void)Storeman_WithdrawWithKey:(NSString*)key Response:(void(^)(id money, NSDictionary *info))response;


@end

NS_ASSUME_NONNULL_END
