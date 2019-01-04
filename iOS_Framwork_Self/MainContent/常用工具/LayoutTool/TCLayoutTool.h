//
//  TCLayoutTool.h
//  JiMi
//
//  Created by YangTianCi on 2018/5/8.
//  Copyright © 2018年 www.JiMi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCLayoutTool : NSObject

#pragma mark >>>>>>>>>> 创建单例

+(instancetype)shareInstance;


#pragma mark >>>>>>>>>> 计算字体高度宽度函数

-(float)GetHeightWithFont:(UIFont*)font Content:(NSString*)content Width:(CGFloat)width;

-(float)GetWidthWithFont:(UIFont*)font Content:(NSString*)content Height:(CGFloat)height;

#pragma mark ============ 获取当前机型
-(NSString*)GetDeviceType;




@end
