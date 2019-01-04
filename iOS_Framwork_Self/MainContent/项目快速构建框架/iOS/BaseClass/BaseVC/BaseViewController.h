//
//  BaseViewController.h
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HudType){
    HudType_Normal,
    HudType_Bar,
    HudType_round
};

@interface BaseViewController : UIViewController


//跳转控制器到指定位置
-(void)PopToIndexVC:(NSInteger)index;

//nav的返回按钮
-(void)BackButtonHidden;
- (void)BackAction;

//nav跳转操作
-(void)PushVC:(Class)vcClass;

//model 操作
-(void)ModalVC:(Class)vcClass CallBack:(void(^)(void))callBack;

//设置导航栏标题
- (void)setNavTitle:(NSString *)navTitle Info:(id)info;

//设置菊花

@property (nonatomic, strong) MBProgressHUD *normalHud;

-(void)showHudHintString:(NSString*)hint;
-(void)showHudMode:(MBProgressHUDMode)mode;
-(void)hideHud;




@end
