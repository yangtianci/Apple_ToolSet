//
//  DQStarView.h
//  NCHomeBaseTest
//
//  Created by 邓琪 dengqi on 2017/1/13.
//  Copyright © 2017年 邓琪 dengqi. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 打分的风格*/
typedef NS_OPTIONS(NSUInteger, DQStarShowStyle){
    DQStarShowStyleSingleClick = 0,//单击一个
    DQStarShowStyleSingleHalfClick = 1,//单击半个
    DQStarShowStyleSliding = 2//滑动打分
};
@protocol DQStarViewDelegate <NSObject>
@optional
/**
 * 选择评分的代理方法 view:为展示的评分的视图 score:显示的分数
 */
- (void)starScoreChangFunction:(UIView *)view andScore:(CGFloat)score;

@end
@interface DQStarView : UIView

@property (nonatomic, weak) id<DQStarViewDelegate> delegate;

/**
 * 星星的默认的背景图片名字,如不设置 就会用自带的图片 这里的 DefaultStarImageStr和SelectStarImageStr的大小要一样
 */
@property (nonatomic, copy) NSString *DefaultStarImageStr;

/**
 * 星星的选中的背景图片名字,如不设置 就会用自带的图片
 */
@property (nonatomic, copy) NSString *SelectStarImageStr;

/**
 * 星星之间的间距
 */
@property (nonatomic, assign) CGFloat starSpace;

/**
 * 星星的个数
 */
@property (nonatomic, assign) NSUInteger starTotalCount;

/**
 * 记录星星的分数
 */
@property (nonatomic, assign) CGFloat starCurrntFl;

/**
 * 星星打分的风格
 */
@property (nonatomic, assign) DQStarShowStyle ShowStyle;
/**创建方式 可以不用，但建议使用该方法创建*/
- (instancetype)initWithDQStarFrme:(CGRect )frame starTotal:(NSUInteger )starTotalCount;

/** 设置星星的分数 score*/
- (void)ShowDQStarScoreFunction:(CGFloat )score;
@end
