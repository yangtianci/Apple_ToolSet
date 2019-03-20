//
//  SourceEditorExtension.m
//  FirstPlusing
//
//  Created by 杨天赐 on 2019/1/31.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import "SourceEditorExtension.h"

@implementation SourceEditorExtension


// 启动时调用

- (void)extensionDidFinishLaunching
{
    // If your extension needs to do any work at launch, implement this optional method.
    
    //在extension启动的时候会被调用，如果需要的话开发者可以在此方法里面做一些初始化的工作

    
}


// 命令属性


/**
 XCSourceEditorCommandName : 命令名称
 XCSoureEditorCommandIdentifier ：标示符
 XCSourceEditorCommandClassName ： 类名
 */

//- (NSArray <NSDictionary <XCSourceEditorCommandDefinitionKey, id> *> *)commandDefinitions
//{
//    // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
//
//    /**
//     commandDefinitions函数的作用和info.plist里面的NSExtension属性的差不多。PS:如果没打算在commandDefinitions中实现命令属性的设置就把函数注释了，否则info.plist里面的设置无效
//     */
//
//    return @[];
//}


@end
