//
//  SourceEditorCommand.m
//  FirstPlusing
//
//  Created by 杨天赐 on 2019/1/31.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import "SourceEditorCommand.h"

@implementation SourceEditorCommand


// 获取文件数据源, 行数, 光标

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    /**
     
     参数invocation的属性buffer就是当前文件的数据源
     
     lines表示当前文件全部行数的代码，selections表示当前光标所在的位置
     */
    
    NSLog(@"lines : %@",invocation.buffer.lines);
    NSLog(@"selections : %@",invocation.buffer.selections);
    
//    XCSourceTextBuffer *buffer = invocation.buffer;
//
//    NSArray *lines = buffer.lines;
//
//    NSMutableArray *selections = buffer.selections;
//
////    XCSourceTextRange *rangeText = selections.firstObject;
//
//    NSLog(@"lines : %@", lines);
//
//    NSLog(@"selection : %@", selections);
    
    completionHandler(nil);
}

@end
