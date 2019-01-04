//
//  LinkList.m
//  OC_Data_Structure_Demo
//
//  Created by YangTianCi on 2018/1/16.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import "LinkList.h"

#define YNoticMsg(content) <<<<<======== content ========>>>>>

#define YLogNotic(content) NSLog(@"<<<<<======== %@ ========>>>>>",content)

@interface LinkList()

@property (nonatomic,strong) LinkNode *headNode;
@property (nonatomic,strong) LinkNode *footNode;

@property (nonatomic,strong) NSMutableDictionary *ReferenceDictionary;

@property (nonatomic,assign) LinkStyle sytle;
@property (nonatomic,assign) BOOL cycle;

@end

@implementation LinkList

#pragma mark ============ MainMethod

-(instancetype)initWithSigleOrBothWay:(LinkStyle)style IsCycle:(BOOL)cycle{
    if (self = [super init]) {
        self.headNode = nil;
        self.footNode = nil;
        self.ReferenceDictionary = [NSMutableDictionary dictionary];
        self.sytle = style;
        self.cycle = cycle;
    }
    return self;
}

//增
/**
 从最后增加节点 == 替换尾节点: node == nil 即可
 替换头节点: node == headNode 即可
 isPre: 选择节点插入位置为 node 之前还是之后
 */
-(void)insertNode:(LinkNode*)newNode ToNode:(LinkNode*)node isPre:(BOOL)pre{
    // newN 必填
    // node 为空 ==> 直接插入最后
    // node 为 headNode ==> 直接替换头节点
    // node 为 其他节点 ==> 根据 pre 选择顺序
    
    /**
     一般的情况分支逻辑判断的基本形式都是树状, 所以最后肯定会衍生出多种结果, 但是因为判断本身是 DFS , 所以效率上只会增加一层时间或空间复杂度.
     逻辑层次:
     1.输入是否合法
     2.表的当前节点数量状态 ( == 0 | == 1 | >= 2 )
     3.node 和 pre 参数的合法以及特殊情况 -> 如果上一层 == 1
     */
    
    if (newNode == nil) {
        YLogNotic(@"新增节点为空或节点 key 为空");
        return;
    }
    
    //先判断列表数量
    
    if ([self length] <= 0) {
        //数量为空, 直接替换 headNode
        [self RegistNodeWithNode:newNode];
        self.headNode = newNode;
        
        self.headNode.preNode = nil;
        self.headNode.nextNode = nil;
        
    }else{
        #pragma mark ============ 当前 length >= 1
        //确定 node 的状态, 决定节点的插入状态
        NSInteger nodeStatue = 0;
        if (node == nil) {
            nodeStatue = 1;//foot后
        }else{
            #pragma mark ============ 当前 node 存在
            //判断是否包含
            if ([[self.ReferenceDictionary allKeys] containsObject:node.key]) {
                if (node == self.headNode) {
                    nodeStatue = 2;//head前后
                }else{
                    nodeStatue = 3;//插入到其他节点的位置
                }
            }else{
                // node 不存在
                YLogNotic(@"旧节点不存在");
                return;
            }
        }
        
        //根据情况判断如何
        if (nodeStatue == 1) {
            if ([self length] == 1) {
                [self RegistNodeWithNode:newNode];
                if (pre) {
                    //替换首节点
                    
                    LinkNode *tempNode = self.headNode;
                    self.headNode = newNode;
                    self.footNode = tempNode;
                    
                    self.headNode.nextNode = self.footNode;
                    self.headNode.preNode = self.footNode;
                    
                    self.footNode.preNode = self.headNode;
                    self.footNode.nextNode = self.headNode;
                    
                }else{
                    //直接指向尾节点
                    self.footNode = newNode;
                    
                    self.headNode.nextNode = self.footNode;
                    self.headNode.preNode = self.footNode;
                    
                    self.footNode.preNode = self.headNode;
                    self.footNode.nextNode = self.headNode;
                }
            }else{
                [self RegistNodeWithNode:newNode];
                LinkNode *tempNode = self.footNode;
                self.footNode = newNode;
                tempNode.nextNode = self.footNode;
                self.footNode.preNode = tempNode;
                
                self.footNode.nextNode = self.headNode;
                self.headNode.preNode = self.footNode;
                
            }
        }else if (nodeStatue == 2){
            // node == headNode
            if ([self length] == 1) {
                [self RegistNodeWithNode:newNode];
                // 此处已经三个前提条件: 1.newNode 有值 2.node==headNode 3. count==1
                if (pre) {
                    //放置在 headNode 前
                    LinkNode *tempNode = self.headNode;
                    self.headNode = newNode;
                    self.footNode = tempNode;
                    
                    self.headNode.nextNode = self.footNode;
                    self.headNode.preNode = self.footNode;
                    
                    self.footNode.preNode = self.headNode;
                    self.footNode.nextNode = self.headNode;
                }else{
                    //放置在 headNode 后
                    //直接指向尾节点
                    self.footNode = newNode;
                    
                    self.headNode.nextNode = self.footNode;
                    self.headNode.preNode = self.footNode;
                    
                    self.footNode.preNode = self.headNode;
                    self.footNode.nextNode = self.headNode;
                }
            }else{
                [self RegistNodeWithNode:newNode];
                // 此处已经三个前提条件: 1.newNode 有值 2.node==headNode 3. count>=1
                if (pre) {
                 //首节点之前
                    //放置在 headNode 前且 nodeCount > 1
                    LinkNode *tempNode = self.headNode;
                    self.headNode = newNode;
                    self.headNode.nextNode = tempNode;
                    tempNode.preNode = self.headNode;
                    
                    self.headNode.preNode = self.footNode;
                    self.footNode.nextNode = self.headNode;
                    
                }else{
                    //首节点之后
                        //放置在 headNode 后且 nodeCount > 1
                    LinkNode *tempNode = self.headNode.nextNode;
                    
                    self.headNode.nextNode = newNode;
                    newNode.nextNode = tempNode;
                    
                    tempNode.preNode = newNode;
                    newNode.preNode = self.headNode;

                }
            }
        }else if (nodeStatue == 3){
            //Node 不为 headNode, 因此 count 一定大于 1, 但是需要考虑==2,或者是尾节点的情况
            if ([self length] == 1) {
                //不存在这种情况, 省略
            }else{
                [self RegistNodeWithNode:newNode];
                if (node == self.footNode) {
                    if (pre) {
                        LinkNode *preNode = self.footNode.preNode;
                        
                        preNode.nextNode = newNode;
                        newNode.nextNode = self.footNode;
                        
                        self.footNode.preNode = newNode;
                        newNode.preNode = preNode;
                        
                    }else{
                        
                        LinkNode *tempNode = self.footNode;
                        self.footNode = newNode;
                        self.footNode.preNode = tempNode;
                        tempNode.nextNode = self.footNode;
                        
                        self.headNode.preNode = self.footNode;
                        self.footNode.nextNode = self.headNode;
                        
                    }
                }else{
                    //此时 >= 3
                    LinkNode *preNode = node.preNode;
                    LinkNode *nextNode = node.nextNode;
                    
                    if (pre) {
                        preNode.nextNode = newNode;
                        nextNode.nextNode = node;
                        
                        node.preNode = newNode;
                        newNode.preNode = preNode;
                        
                    }else{
                        
                        nextNode.preNode = newNode;
                        newNode.preNode = node;
                        
                        node.nextNode = newNode;
                        newNode.nextNode = nextNode;
                        
                    }
                    
                }
            }
        }else{
            YLogNotic(@"未知错误,请检查");
        }
        
    }
}

//删
-(void)removeNode:(LinkNode*)node{
    if ([self length] == 0) {
        YLogNotic(@"空表,不可删除");
    }else if ([self length] == 1){
        if (node == self.headNode) {
            [self removeAllNode];
            YLogNotic(@"删除完毕,此时为空表");
        }else{
            YLogNotic(@"未知节点,处理错误");
        }
    }else if ([self length] >= 2){
        [self DeRegistNodeWithNode:node];
        if (node == self.headNode) {
            self.headNode = self.footNode;
            self.footNode = nil;
            self.headNode.nextNode = nil;
            self.headNode.preNode = nil;
        }else if (node == self.footNode){
            self.footNode = nil;
            self.headNode.nextNode = nil;
            self.headNode.preNode = nil;
        }else{
            LinkNode *preNode = node.preNode;
            LinkNode *nextNode = node.nextNode;
            preNode.nextNode = nextNode;
            nextNode.preNode = preNode;
        }
    }else{
        YLogNotic(@"其他情况,处理错误");
    }
}// 其实也可以用 key 进行代替
-(void)removeAllNode{
    [self.ReferenceDictionary removeAllObjects];
    self.headNode = nil;
    self.footNode = nil;
}

//改
-(void)bringNodeToHead:(LinkNode*)node{
    if ([self length] == 0) {
        
    }else if ([self length] == 1){
        YLogNotic(@"只有一个元素,不可处理");
    }else if ([self length] == 2){
        if (node == self.footNode) {
            LinkNode *tempNode = self.footNode;
            self.footNode = self.headNode;
            self.headNode = tempNode;
            self.headNode.nextNode = self.footNode;
            self.footNode.nextNode = self.headNode;
            self.headNode.preNode = self.footNode;
            self.footNode.preNode = self.headNode;
        }else{
            YLogNotic(@"节点错误");
        }
    }else if ([self length] >= 3){
        if (node == self.headNode) {
            YLogNotic(@"节点错误");
        }else if (node == self.footNode){
            LinkNode *tempNode = self.footNode;
            self.headNode = tempNode;
            self.footNode = tempNode;
        }else{
            LinkNode *preNode = node.preNode;
            LinkNode *nextNode = node.nextNode;
            LinkNode *tempNode = self.headNode;
            
            preNode.nextNode = nextNode;
            nextNode.preNode = preNode;
            
            self.headNode = node;
            self.headNode.nextNode = tempNode;
            tempNode.preNode = self.headNode;
            
            self.headNode.preNode = self.footNode;
            self.footNode.nextNode = self.headNode;
            
        }
    }else{
        YLogNotic(@"其他情况,处理错误");
    }
}

-(void)exchangeNode:(LinkNode*)One_node withNode:(LinkNode*)Two_node{
    if ([self length] == 0) {
        YLogNotic(@"节点错误");
    }else if ([self length] == 1) {
        YLogNotic(@"节点错误");
    }else if ([self length] == 2) {
        
        LinkNode *tempNode = self.footNode;
        self.headNode = tempNode;
        self.footNode = tempNode;
        
    }else if ([self length] >= 3) {
        
        YLogNotic(@"太麻烦了, 因为要考虑到前后节点是不是头尾节点的关系, 直接放弃了, 反正是 demo, 哈哈哈");
        
    }else{
        YLogNotic(@"其他情况,处理错误");
    }
}

-(void)reverse{
    LinkNode *tempNode = self.footNode;
    self.headNode = tempNode;
    self.footNode = tempNode;
}

//查
-(LinkNode*)headNode{
    return _headNode;
}

-(LinkNode*)footNode{
    return _footNode;
}

-(void)EnumerateNodeWith:(void(^)(LinkNode *node, NSInteger index, BOOL lastNode, id info))handle{
    
    LinkNode *curNode = self.headNode;
    
    for (int i = 0; i < [self.ReferenceDictionary allKeys].count; i ++) {
        BOOL isLast = curNode == self.footNode? YES: NO;
        handle(curNode, i, isLast, nil);
        curNode = curNode.nextNode;
    }
}

#pragma mark ============ BaseMethod


-(BOOL)isEmpty{
    return [self.ReferenceDictionary allKeys].count == 0 ? YES: NO;
}

-(NSUInteger)length{
    NSInteger length = [self.ReferenceDictionary allKeys].count;
    return length;
}

-(void)RegistNodeWithNode:(LinkNode*)node{
    node.key = [NSString stringWithFormat:@"Index:%zd",[self length]];
    [self.ReferenceDictionary setObject:node forKey:node.key];
}

-(void)DeRegistNodeWithNode:(LinkNode*)node{
    [self.ReferenceDictionary removeObjectForKey:node.key];
}

@end
