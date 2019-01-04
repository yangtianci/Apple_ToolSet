//
//  Sip_TreeList.m
//  OC_Data_Structure_Demo
//
//  Created by YangTianCi on 2018/1/19.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import "Sip_TreeList.h"

@interface Sip_TreeList()



@end

@implementation Sip_TreeList

//初始化
-(instancetype)initWithRootNode:(Sip_TreeNode*)rootNode Info:(id)info{
    if (self = [super init]) {
        if (rootNode) {
            self.Root_Node = rootNode;
        }else{
            self.Root_Node = [[Sip_TreeNode alloc]init];
        }
    }
    return self;
}

//插入节点 -> 默认, 从左到右找到第一个子节点
-(void)insertNodeWithNode:(Sip_TreeNode*)node{
    

    
    
}

//递归+遍历->函数, 广度优先的寻找第一个空的节点位置
-(Sip_TreeNode*)Imp_methodWithNode:(Sip_TreeNode*)node{
    
    if (node.leftNode == nil) {
        node.leftNode = [[Sip_TreeNode alloc]init];
        return node.leftNode;
    }
    if (node.rightNode == nil) {
        node.rightNode = [[Sip_TreeNode alloc]init];
        return node.rightNode;
    }
    
    return nil;
}

//插入节点 -> 按照给定节点进行操作

//遍历: 前序, 中序, 后序

//求树的最深度 -> 递归&非递归方式

//求树的宽度

//反转二叉树



@end
