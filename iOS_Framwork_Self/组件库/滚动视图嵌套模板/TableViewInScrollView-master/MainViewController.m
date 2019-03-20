//
//  MainViewController.m
//  TableView嵌套(纯净版)&分页控制器
//
//  Created by YangTianCi on 2018/1/7.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import "MainViewController.h"
#import "SubScrollView.h"
#import <MJRefresh.h>
#import <Masonry.h>
#import "BaseScrollView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) BaseScrollView *MainScrollView;
@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) SubScrollView *SubScrollView;

@property (nonatomic,assign) BOOL CanScroll_Main;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.CanScroll_Main = YES;
    [self ConfigurationUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ToTopMethod) name:@"toTop" object:nil];
    
}

-(void)ToTopMethod{
    self.CanScroll_Main = YES;
    self.SubScrollView.CanScroll_Sub = NO;
}

#pragma mark ============ Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 200) {
        self.MainScrollView.contentOffset = CGPointMake(0, 200);
        if (self.CanScroll_Main) {
            self.CanScroll_Main = NO;
            self.SubScrollView.CanScroll_Sub = YES;
        }
    }
    else{
        if (!self.CanScroll_Main) {
            self.MainScrollView.contentOffset = CGPointMake(0, 250);
        }
    }
}

#pragma mark ============ 配置UI
-(void)ConfigurationUI{
    
    //创建 ScrollView
    [self UI_CreatScrollView];
    
    //创建 header
    [self UI_CreatHeader];
    
    //添加刷新 header
    [self UI_AddRefreshHeader];
    
    //添加 subScrollView
    [self UI_SubScrollView];
    
}

-(void)UI_SubScrollView{
    self.SubScrollView = [[SubScrollView alloc]initWithFrame:CGRectMake(0, 300, kScreenWidth, kScreenHeight)];
    self.SubScrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight);
    [self.MainScrollView addSubview:self.SubScrollView];
    self.SubScrollView.backgroundColor = [UIColor whiteColor];
}

-(void)UI_AddRefreshHeader{
    MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.SubScrollView.Refrsh = YES;
        [self.MainScrollView.mj_header endRefreshing];
    }];
    self.MainScrollView.mj_header = header;
}

-(void)UI_CreatHeader{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    [self.MainScrollView addSubview:self.headerView];
    self.headerView.backgroundColor = [UIColor yellowColor];
    
    UILabel *headerLabel = [[UILabel alloc]init];
    [self.headerView addSubview:headerLabel];
    headerLabel.font = [UIFont boldSystemFontOfSize:30];
    headerLabel.text = @"这里是 HeaderView ";
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.headerView);
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    [self.headerView addSubview:tipLabel];
    tipLabel.font = [UIFont boldSystemFontOfSize:16];
    tipLabel.text = @"Segemetn放置区域";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.headerView);
        make.bottom.mas_equalTo(self.headerView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    
}

-(void)UI_CreatScrollView{
    self.MainScrollView = [[BaseScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.MainScrollView];
    self.MainScrollView.backgroundColor = [UIColor whiteColor];
    self.MainScrollView.delegate = self;
    self.MainScrollView.contentSize = CGSizeMake(kScreenWidth, 300 + kScreenHeight);
}


@end
