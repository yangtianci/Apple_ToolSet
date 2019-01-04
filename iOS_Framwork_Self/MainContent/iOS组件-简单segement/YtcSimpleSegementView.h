//
//  YtcSimpleSegementView.h
//  CountryYard
//
//  Created by 杨天赐 on 2018/11/9.
//  Copyright © 2018 tidoo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YtcSimpleSegementView : UIView


-(void)ConfigNormalFont:(NSInteger)normalFont SelectFont:(NSInteger)selecFont NormalColor:(UIColor *)normalColro SelColor:(UIColor *)selColor CursonColor:(UIColor*)cursonColor CursonHeight:(CGFloat)cursonH;

-(void)COnfigMargin1:(CGFloat)margin1 MarginMiddle:(CGFloat)marginMiddle IsScale:(BOOL)isScale;

-(void)ConfigTitleArray:(NSArray*)titleArray;

-(void)SelectIndex:(NSInteger)idx CallBack:(void(^)())callBack;

@property (copy, nonatomic) void(^selectCallBack)(NSInteger selIdx, id info);







@end

NS_ASSUME_NONNULL_END
