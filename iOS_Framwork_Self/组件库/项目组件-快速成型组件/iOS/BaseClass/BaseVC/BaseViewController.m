//
//  BaseViewController.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "BaseViewController.h"

#import "TimerManager.h"

@interface BaseViewController ()



@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    
    //需要隐藏导航栏下方细线的时候处理
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBG"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[QBXTools imageWithColor:kColorLightGray size:CGSizeMake(kScreenWidth, 0.5)]];
    
    // 设置导航栏标题字体属性
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor darkTextColor]}];
    
    //     替代方案
    //返回按钮 25 * 25
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 7);
    
    [leftButton setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkTextColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"%@ 接收到内存警告", [self class]);
    
}

#pragma mark >>>>>>>>>> 返回按钮

//隐藏返回按钮
-(void)BackButtonHidden{
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)BackAction{
    [self hideHud];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)PopToIndexVC:(NSInteger)index{
    NSArray *VCArr = self.navigationController.childViewControllers;
    if (VCArr.count < index) {
    }else if (self.navigationController == nil){
    }else{
        UIViewController *vc = VCArr[index];
        [self.navigationController popToViewController:vc animated:YES];
    }
}


//nav跳转操作
-(void)PushVC:(Class)vcClass{
    UIViewController *VC = (UIViewController*)[[vcClass alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

//model 操作
-(void)ModalVC:(Class)vcClass CallBack:(void(^)(void))callBack{
    UIViewController *VC = (UIViewController*)[[vcClass alloc]init];
    [self presentViewController:VC animated:YES completion:callBack];
}

#pragma mark >>>>>>>>>> 设置 NavTitle

//设置导航栏标题
- (void)setNavTitle:(NSString *)navTitle Info:(id)info
{
    UILabel *t_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 80, 44)];
    t_label.font = [UIFont systemFontOfSize:20];
    t_label.textColor = [UIColor blackColor];
    t_label.textAlignment = NSTextAlignmentCenter;
    t_label.text = navTitle;
    if (self.navigationItem) {
        self.navigationItem.titleView = t_label;
    }
}


#pragma mark >>>>>>>>>> 菊花相关函数

-(void)showHudHintString:(NSString*)hint{
    self.normalHud.mode = MBProgressHUDModeText;
    self.normalHud.detailsLabel.text = hint;
    self.normalHud.detailsLabel.font = [UIFont systemFontOfSize:16];
    [self.normalHud showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationMiddle * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_normalHud hideAnimated:YES];
        _normalHud = nil;
    });
}

-(void)showHudMode:(MBProgressHUDMode)mode{
    self.normalHud.mode = mode;
    [self.normalHud showAnimated:YES];
}

-(void)hideHud{
    [_normalHud hideAnimated:YES];
    [_normalHud removeFromSuperview];
    _normalHud = nil;
}

-(MBProgressHUD *)normalHud{
    if (!_normalHud) {
        if (self.navigationController.view) {
            _normalHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        }else{
            _normalHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
    }
    return _normalHud;
}






@end
