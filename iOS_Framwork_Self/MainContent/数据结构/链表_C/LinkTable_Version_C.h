//
//  LinkTable_Version_C.h
//  OC_Data_Structure_Demo
//
//  Created by YangTianCi on 2018/1/17.
//  Copyright © 2018年 ytc. All rights reserved.
//

#ifndef LinkTable_Version_C_h
#define LinkTable_Version_C_h

#include <stdio.h>
#include <mm_malloc.h>

#pragma mark ============ Node 部分

typedef struct ListNode{
    struct LinkNode *preNode;
    struct LinkNode *nextNode;
    char* RandomString_Data;
}Node;










#pragma mark ============ List 部分












#endif /* LinkTable_Version_C_h */
