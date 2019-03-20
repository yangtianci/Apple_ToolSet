//
//  LayoutAndColor.h
//  JiMi
//
//  Created by YangTianCi on 2018/4/24.
//  Copyright © 2018年 www.JiMi.com. All rights reserved.
//

#ifndef LayoutAndColor_h
#define LayoutAndColor_h

//动画时间
#define kAnimationShort 0.5

//随机颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:0.9]

//RGBA
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//16进制颜色
#define HexColor(hexValue , Alpha) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:Alpha]

#pragma mark =======================   基本距离宏
/**
 App基本距离参数等
 */
#define kMarginRed 10
#define kMarginBlue 15
#define kMarginForgive 8

/**
 尺寸转化宏
 */

#define kSCREEN_RATE   ([[UIScreen mainScreen] bounds].size.width)/375.0
#define kScreenHeight_Rate ([[UIScreen mainScreen] bounds].size.height)/667.0

/**
 
 常用尺寸宏
 
 */


//屏幕 rect
#define kScreenBounds ([UIScreen mainScreen].bounds)

//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define kStatuebar [[UIApplication sharedApplication] statusBarFrame].size.height


//控制器视图宽高
#define kViewWidth self.view.frame.size.width
#define kViewHeight self.view.frame.size.height - 44 - kStatuebar

//当前视图宽高
#define kCurrentWidth self.frame.size.width
#define kCurrentHeight self.frame.size.height

// 系统版本
#define SystemVersion [[UIDevice currentDevice] systemVersion].floatValue

// 是否是iPhoneX
#define ISIPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
//NavBar高度
#define kNavbar 44

// 底部危险区域
#define kDangerBottom    (ISIPHONEX ?34.f: 0.f)

//tabbar高度
#define kTabbarHeight (ISIPHONEX ?49.f+34.f: 49.f)

//获取安全区域
#define ViewSafeArea(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

#define kPageHeaderHeight    50

//状态栏 ＋ 导航栏 高度
#define kStatueAndNavbar (kStatuebar + kNavbar)

#endif /* LayoutAndColor_h */
