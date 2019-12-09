//
//  TimerManager.m
//  测试专用项目
//
//  Created by YangTianCi on 2017/8/1.
//  Copyright © 2017年 QianBuXian. All rights reserved.
//

#import "TimerManager.h"

@interface TimerManager ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger interval;
@property (nonatomic,copy) void(^progressBlock)(NSInteger LastInterval);
@property (nonatomic,copy) void(^finishBlcok)() ;

@property (nonatomic,assign) NSInteger CurrentIntrval;
@property (nonatomic,assign) NSInteger TargetInterval;

@end

@implementation TimerManager


-(void)Start_ReckonTimeWithTimeInterval:(NSTimeInterval)timerInterval ProgressBlock:(void(^)(NSInteger LastInterval))progressBlock FinishBlock:(void(^)())finishBlcok{
    __block int interval = (int)timerInterval;
    
    self.interval = interval;
    self.CurrentIntrval = [NSDate date].timeIntervalSince1970;
    self.TargetInterval = self.CurrentIntrval + interval;
    
    self.progressBlock = progressBlock;
    self.finishBlcok = finishBlcok;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerCountDown:) userInfo:nil repeats:YES];
    
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerCountDown:) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    
}

-(void)timerCountDown:(NSTimer *)timer{
    
    self.CurrentIntrval = [NSDate date].timeIntervalSince1970;
    self.interval = self.TargetInterval - self.CurrentIntrval;
    
    if (self.interval > 0) {
        self.progressBlock(self.interval);
    }else if (self.interval <= 0){
        [self End_ReckonTime];
        self.finishBlcok();
    }
}


-(void)End_ReckonTime{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}






@end
