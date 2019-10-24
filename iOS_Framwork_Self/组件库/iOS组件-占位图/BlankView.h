//
//  BlankView.h
//  RichGo
//
//  Created by tuikai on 2017/5/25.
//  Copyright © 2017年 chtwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlankView : UIView

@property(nonatomic,strong)UIImageView*imageView;
@property(nonatomic,strong)UILabel*textlabel;
@end

/**
 
 占位图逻辑: 直接覆盖即可, 根据数据返回情况决定是否出现即可 
 
 如果有需要可以新增的功能
 1.改变为 scrollview
 2.按钮回调 
 
 */

/**
 
 使用方式
 
 // 放置在网络请求结束回调中, 一般来说, 成功失败都需要放置
 
 [self addBlank];
 
 @property(nonatomic,strong) BlankView*blank;
 
 #pragma mark ================= 占位图
 -(void)addBlank{
 
 CGFloat top = kTopHeight;
 CGFloat height =SCREENHEIGHT-kTopHeight;
 
 if (self.dataArr.count==0) {
 _blank =[[BlankView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
 // 如果是 tableview, 则可以设置为 tableview 的 backgroundView
 [self addSubview:_blank];
 } else if(_blank){
 [_blank removeFromSuperview];
 }
 
 }
 

 
 */

