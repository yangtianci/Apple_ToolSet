//
//  LinkNode.h
//  OC_Data_Structure_Demo
//
//  Created by YangTianCi on 2018/1/16.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 基本构成: 链表的数据结构在于集合元素, 也就是节点之间具有相互指向关系, 也就是每个节点中会包含向前指向的节点指针或者向后指向的节点地址, 所以无论何时, 链表节点的基本组织元素都有一个或者两个指针.
 
 区分:
 {
     1.单向无循环链表: 元素只包含向后指向的指针数据
     2.双向无循环链表: 元素包含向前以及向后的两个指针数据
     3.单向/双向循环链表: 除了满足以上条件之外, 头尾节点会互相指向
 }
 
 v_OC: 因为需要强引用, 所以采取 hashArray 的方式进行节点的实际存储, 因此元素操作的时候需要有句柄数据, 也就是需要增加 key 字段.
 {
     &: 因为实现以上四种类型的链表形式过于麻烦, 因此只实现( 双向循环链表 )但是提供类型枚举作为区分, 此外, 在获取数据的时候会根据预设值判断是否返回为伪实现.
 }
 
 &.Notic: 作为元素本身的数据关系来说链表并不复杂, 但是需要额外处理的部分在于增删改查时每次都需要检查列表的总个数, 因此, 以下几种情况下的处理格外重要.
 * count == 0: 空表的处理
 * count == 1: 只有首元结点的处理 
 
 */
@interface LinkNode : NSObject

#pragma mark ============ 结构区

//通用字段
@property (nonatomic,copy) NSString *key;

//单向链表
@property (nonatomic,strong) LinkNode *nextNode;

//双向链表需要增加以下字段
@property (nonatomic,strong) LinkNode *preNode;

#pragma mark ============ 数据域
@property (nonatomic,copy) NSString *Data_RandomString;

@end
