//
//  LinkList.h
//  OC_Data_Structure_Demo
//
//  Created by YangTianCi on 2018/1/16.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LinkNode.h"

/**
 此链表可能出现的或者说作为 demo 不需要解决的问题收集:
 1.因为是 OC 实现的, 所以需要强引用状态保证内存不被回收, 但是让用户通过 key 进行赋值取值不属于链表的功能, 本 demo 中将 key 的添加隐藏到链表内部实现, 通过生成随机名称进行存储, 最终选择使用 [self length] 方式实现, 但是一定会出现碰撞, 所以, 应该增加一个不断增长的正整数属性作为标志.
 2.头结点: 本 demo 不设置头结点, 第一个指针就是首元结点, 也就是从元节点开始, 按理来说, 如果设置了头结点其实能更有效的管理空表状态, 并且改变首元结点比较方便. 
 */

typedef NS_ENUM(NSInteger, LinkStyle){
    LinkStyle_Single,
    LinkStyle_BothWay
};

@interface LinkList : NSObject

#pragma mark ============ MainMethod
/**
 只能通过这个函数进行初始化操作, 否则无效
 */
-(instancetype)initWithSigleOrBothWay:(LinkStyle)style IsCycle:(BOOL)cycle;

//增
/**
 从最后增加节点 == 替换尾节点: node == nil 即可
 替换头节点: node == headNode 即可
 isPre: 选择节点插入位置为 node 之前还是之后
 */
-(void)insertNode:(LinkNode*)newNode ToNode:(LinkNode*)node isPre:(BOOL)pre;

//删
-(void)removeNode:(LinkNode*)node;// 其实也可以用 key 进行代替
-(void)removeAllNode;

//改
-(void)bringNodeToHead:(LinkNode*)node;
-(void)exchangeNode:(LinkNode*)One_node withNode:(LinkNode*)Two_node;
-(void)reverse;

//查
//-(LinkNode*)nodeForKey:(NSString*)key;
/**
 {
 &: 如果从外部提供 key 值进行存储
 }
 */
-(LinkNode*)headNode;
-(LinkNode*)footNode;

-(void)EnumerateNodeWith:(void(^)(LinkNode *node, NSInteger index, BOOL lastNode, id info))handle;

#pragma mark ============ BaseMethod


-(BOOL)isEmpty;
-(NSUInteger)length;


@end
