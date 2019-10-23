//
//  PMHotProductSlideHeadView.h
//  RichGo
//
//  Created by 杨天赐 on 2019/10/23.
//  Copyright © 2019 chtwm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMHotProductSlideHeadView : UIView

// 配置标题
-(void)ConfigDataWithTitleArr:(NSArray*)titleArr;

// 是否均分
@property (assign, nonatomic) BOOL isAverage;

// 默认选中位置
@property (assign, nonatomic) NSInteger defaultSelectIdx;

// 选中回调
@property (copy, nonatomic) void(^btnCallBack)(NSInteger idx, NSString *title);

// 手动选中某个 idx
-(void)ManualSetSelectIdx:(NSInteger)idx;


@end

NS_ASSUME_NONNULL_END

/**
 
 使用思路
    1.创建属性
    2.懒加载
    3.添加对象
    4.设置具体逻辑
        1. ScrollView 影响 slider -> 补充 1
        2. slider 影响 ScrollView -> 补充 2
 
 Code
 
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 界面代码
 
 ```
 
 #import "PMHotProductSlideHeadView.h"
 @property (strong, nonatomic) PMHotProductSlideHeadView *slidHead;
 
 
 
 -(PMHotProductSlideHeadView *)slidHead{
 if (!_slidHead) {
 _slidHead = [[PMHotProductSlideHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenH, 50)];
 NSArray *titleArr = @[@"近3天关注榜",@"近3天预约榜",@"近3天打款榜"];
 _slidHead.isAverage = YES;
 [_slidHead ConfigDataWithTitleArr:titleArr];
 }
 return _slidHead;
 }
 
 
 #pragma mark ============================================== Slider
 
 [self.view addSubview:self.slidHead];
 [self.slidHead mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.navBar.mas_bottom).with.offset(0);
 make.right.mas_equalTo(self.view.mas_right).with.offset(-0);
 make.left.mas_equalTo(self.view.mas_left).with.offset(0);
 make.height.mas_equalTo(50);
 }];
 
 ```
 
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 补充 - 1 -> ScrollView 滑动影响 slider
 
 #pragma mark ============================================== Delegate
 
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
 
 if (scrollView == self.mainScrollView) {
 // 停止类型1、停止类型2
 BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
 if (scrollToScrollStop) {
 [self scrollViewDidEndScroll];
 }
 }
 
 
 }
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
 if (scrollView == self.mainScrollView) {
 if (!decelerate) {
 // 停止类型3
 BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
 if (dragToDragStop) {
 [self scrollViewDidEndScroll];
 }
 }
 }
 }
 
 #pragma mark - scrollView 滚动停止
 - (void)scrollViewDidEndScroll {
 
 CGPoint CurP = self.mainScrollView.contentOffset;
 NSInteger page = CurP.x / kScreenW;
 
 [self.slidHead ManualSetSelectIdx:page];
 
 }
 
 
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 补充 - 2 -> slider 点击影响 ScrollView
 
 self.slidHead.btnCallBack = ^(NSInteger idx, NSString * _Nonnull title) {
 [UIView animateWithDuration:0.1 animations:^{
 WS.mainScrollView.contentOffset = CGPointMake(kScreenW * idx, 0);
 }];
 };

 
 
 
 */


