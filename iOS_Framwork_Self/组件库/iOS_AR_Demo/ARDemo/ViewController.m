//
//  ViewController.m
//  ARDemo
//
//  Created by YangTianCi on 2018/2/28.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "ViewController.h"

#import "SceneARController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *planeButton;
@property (nonatomic, strong) UIButton *rotatoButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
 
    [self ConfigUI];
    
}

-(void)ClickMethodWithSender:(UIButton*)sender{
    SceneARController *sceneARVC = [[SceneARController alloc]init];
    [self.navigationController pushViewController:sceneARVC animated:YES];
    if (sender == self.planeButton) {
        sceneARVC.style = Style_planeHoriz;
    }else if (sender == self.rotatoButton){
        sceneARVC.style = Style_rotato;
    }else{
        
    }
}

-(void)ConfigUI{
    
    self.planeButton = [[UIButton alloc]init];
    [self.view addSubview:self.planeButton];
    [self.planeButton setTitle:@"平地效果" forState:UIControlStateNormal];
    [self.planeButton addTarget:self action:@selector(ClickMethodWithSender:) forControlEvents:UIControlEventTouchUpInside];
    self.planeButton.frame = CGRectMake(100, 100, 100, 30);
    
    
    self.rotatoButton = [[UIButton alloc]init];
    [self.view addSubview:self.rotatoButton];
    [self.rotatoButton setTitle:@"旋转" forState:UIControlStateNormal];
    [self.rotatoButton addTarget:self action:@selector(ClickMethodWithSender:) forControlEvents:UIControlEventTouchUpInside];
    self.rotatoButton.frame = CGRectMake(100, 170, 100, 30);
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
