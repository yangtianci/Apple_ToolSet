//
//  DataStoreMan.m
//  DataTransformer
//
//  Created by 杨天赐 on 2019/5/31.
//  Copyright © 2019 YtcTestNoticfication. All rights reserved.
//

#import "DataStoreMan.h"

@interface DataStoreMan ()

// 金库字典_存储所有中间数据
@property (strong, nonatomic) NSMutableDictionary *Coffer;

@end

@implementation DataStoreMan


static DataStoreMan *man;

+(instancetype)ShareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        man = [[DataStoreMan alloc]init];
    });
    return man;
}


-(NSString*)CreatSecretKeyWithDepositer:(Class)depositer customeKey:(NSString*)cKey{
    NSString *className = NSStringFromClass(depositer);
    NSString *secretKey = [NSString stringWithFormat:@"%@-%@",className,cKey];
    if (cKey.length == 0) {
        secretKey = [NSString stringWithFormat:@"%@-default",className];
    }
    if (depositer == nil) {
        secretKey = [NSString stringWithFormat:@"NoName-%@",cKey];
    }
    if (depositer == nil && cKey.length == 0) {
        return nil;
    }
    return secretKey;
}

-(BOOL)CheckAccountWithKey:(NSString*)key{
    
    if ([self.Coffer.allKeys containsObject:key]) {
        return YES;
    }else{
        return NO;
    }
    
}


-(void)Storeman_StoreDataWithKey:(NSString *)key Value:(id)value Response:(void(^)(NSDictionary *info))response{
    
    [self.Coffer setObject:value forKey:key];
    if (response) {
        response(nil);
    }
    
}

-(void)Storeman_WithdrawWithKey:(NSString*)key Response:(void(^)(id money, NSDictionary *info))response{
    
    id money = [self.Coffer valueForKey:key];
    
    if (response) {
        response(money, nil);
    }
    
}


-(NSMutableDictionary *)Coffer{
    if (!_Coffer) {
        _Coffer = [NSMutableDictionary dictionary];
    }
    return _Coffer;
}



@end
