//
//  TimerManager.h
//  测试专用项目
//
//  Created by YangTianCi on 2017/8/1.
//  Copyright © 2017年 QianBuXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerManager : NSObject

-(void)Start_ReckonTimeWithTimeInterval:(NSTimeInterval)timerInterval ProgressBlock:(void(^)(NSInteger LastInterval))progressBlock FinishBlock:(void(^)())finishBlcok;

-(void)End_ReckonTime;

@end

