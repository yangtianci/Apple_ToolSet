//
//  ViewController.m
//  TableView嵌套(纯净版)&分页控制器
//
//  Created by YangTianCi on 2018/1/7.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     
     主视图以及子视图, 必须先存在两个 Bool 类型的变量来标识当前是否可以滚动的状态.
     
     主视图在 scrollViewDidScroll 函数中监听偏移量, 并根据偏移量设置自身以及子视图是否可以滚动的状态, 同时, 子视图也在 scrollViewDidScroll 函数中监听自身偏移量, 并且根据偏移量改变自身滚动状态以及通过通知手段改变主视图的滚动状态.
     
     执行循环:
     1. 进入主视图之后, 设置主视图状态可以滚动, 此时因为子视图的滚动变量默认为 No, 因此滑动事件发生的时候只有主视图会响应, 子视图会固定偏移量为 zero
     2. 继续滑动主视图, 如果超过预定的值, 则在 scrollViewDidScroll 函数中设置为固定主视图的偏移量为固定值, 并且改变主视图以及子视图是否可以滚动的标识值, 此时, 进入主视图固定偏移量, 子视图可以相应滑动的状态
     3. 向下滑动子视图, 如果子视图的偏移量为 0, 则表示滑动的视图应该切换为主视图, 因此, 此时切换自身的滑动标识符为 NO, 同时通过通知改变主视图的滑动标识符, 就会发生手势的自然切换.
     
     附加: 添加刷新加载操作
     
     * 刷新操作只需要增加给主视图, 加载操作增加给每个子视图即可
     
     */
    
    UILabel *tipLabel = [[UILabel alloc]init];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    tipLabel.font = [UIFont systemFontOfSize:30];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"点击屏幕继续";
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    [self presentViewController:mainVC animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
