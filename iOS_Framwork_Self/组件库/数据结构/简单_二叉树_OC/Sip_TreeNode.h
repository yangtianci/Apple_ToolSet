//
//  Sip_TreeNode.h
//  OC_Data_Structure_Demo
//
//  Created by YangTianCi on 2018/1/19.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 数据元素_结构分解:
 指针域一般包含三个指针, rootP, rightP, leftP.
 
 */

@interface Sip_TreeNode : NSObject

#pragma mark ============ 指针域

@property (nonatomic,strong) Sip_TreeNode *rootNode;
@property (nonatomic,strong) Sip_TreeNode *leftNode;
@property (nonatomic,strong) Sip_TreeNode *rightNode;

#pragma mark ============ 数据域

@property (nonatomic,copy) NSString *randomData_name;



@end
