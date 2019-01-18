//
//  YtcSimpleImagesView.h
//  DemoView
//
//  Created by 杨天赐 on 2019/1/17.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YtcSimpleImagesView : UIView


#pragma mark ================= 可初始化数据

// canEdit == NO, 仅仅展示图片, 不能编辑
@property (assign, nonatomic) BOOL canEdit;

@property (assign, nonatomic) CGFloat TopMargin;
@property (assign, nonatomic) CGFloat RightLeftMargin;
@property (assign, nonatomic) CGFloat BottomMargin;
@property (assign, nonatomic) CGFloat MiddleVerticalMargin;
@property (assign, nonatomic) CGFloat MiddleHorizonMargin;


@property (assign, nonatomic) CGFloat WidthHeigthPercent;
@property (assign, nonatomic) NSInteger maxImgCount;

@property (assign, nonatomic) CGFloat columCount;

#pragma mark ================= 设置完数据后调用函数初始化

-(void)ShowTime;

#pragma mark ================= 数据绑定 channel


-(void)ConfigImgArr:(NSArray*)imgArr CallBack:(void(^)(CGRect bunce))callBack;

@property (copy, nonatomic) void(^ImgClickCB)(NSInteger idx);

@property (copy, nonatomic) void(^DeleteClickCB)(NSInteger idx);

@property (copy, nonatomic) void(^AddClickCB)(void);



@end


/**
 
 #pragma mark ============================================== 使用范例
 
 
 self.imgV = [[YtcSimpleImagesView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
 self.imgV.TopMargin = 10;
 self.imgV.BottomMargin = 10;
 
 [self.view addSubview:self.imgV];
 
 [self.imgV ShowTime];
 
 self.imgV.AddClickCB = ^{
 [WS.manager GetImageWithController:WS WithType:ToolType_Photo];
 [WS.imgV ConfigImgArr:WS.imgArr CallBack:^(CGRect bunce) {
 
 CGRect orginalF = WS.imgV.frame;
 orginalF.size.height = bunce.size.height;
 WS.imgV.frame = orginalF;
 
 }];
 };
 
 self.imgV.DeleteClickCB = ^(NSInteger idx) {
 [WS.imgArr removeObjectAtIndex:idx];
 
 [WS.imgV ConfigImgArr:WS.imgArr CallBack:^(CGRect bunce) {
 
 CGRect orginalF = WS.imgV.frame;
 orginalF.size.height = bunce.size.height;
 WS.imgV.frame = orginalF;
 
 }];
 };

 */


/**
 
 替换添加按钮样式, 直接修改 YtcSimpleImageBPView 类样式即可
 
 */



NS_ASSUME_NONNULL_END
