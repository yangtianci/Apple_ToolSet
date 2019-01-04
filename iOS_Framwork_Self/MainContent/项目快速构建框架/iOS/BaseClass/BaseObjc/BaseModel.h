//
//  BaseModel.h
//  TCMemory
//
//  Created by YangTianCi on 2018/4/13.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject<NSCoding>

-(instancetype)initWithDict:(NSDictionary*)dict;

@end
