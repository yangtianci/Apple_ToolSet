//
//  SmallTableView.m
//  TableView嵌套(纯净版)&分页控制器
//
//  Created by YangTianCi on 2018/1/7.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import "SmallTableView.h"
#import <MJRefresh.h>

@interface SmallTableView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *customTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation SmallTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = [NSMutableArray array];
        for (int i = 0; i < 5; i ++) {
            NSString *string = [NSString stringWithFormat:@"%d ---> title",i];
            [self.dataArray addObject:string];
        }
        [self ConfigurationUI];
        [self AddRefresh];
    }
    return self;
}

#pragma mark ============ 核心函数
-(void)setOffsetPoint:(CGPoint)OffsetPoint{
    _OffsetPoint = OffsetPoint;
    self.customTableView.contentOffset = OffsetPoint;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.CanScroll_Small) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.CanScroll_Small = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"toTop" object:nil];
    }
}

-(void)setRefresh:(BOOL)Refresh{
    _Refresh = Refresh;
    [self AddData_Top_Method];
}

//AddData_Top_Method
-(void)AddData_Top_Method{
    //模拟网络请求
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        NSString *string = [NSString stringWithFormat:@"%d ---> title",i];
        [self.dataArray addObject:string];
    }
    [self.customTableView reloadData];
}


//AddData_Bottom_Method
-(void)AddData_Bottom_Method{
    int count = self.dataArray.count;
    for (int i = count; i < count + 5; i++) {
        NSString *string = [NSString stringWithFormat:@"%d ---> title",i];
        [self.dataArray addObject:string];
    }
    [self.customTableView reloadData];
    [self.customTableView.mj_footer endRefreshing];
}


#pragma mark ============ 配置UI

-(void)AddRefresh{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self AddData_Bottom_Method];
    }];
    self.customTableView.mj_footer = footer;
}

-(void)ConfigurationUI{
    [self creatView];
}

-(void)creatView{
    //--必须设置--<##>
    CGRect tableViewRect = self.bounds;
    self.customTableView = [[UITableView alloc]initWithFrame:tableViewRect style:UITableViewStylePlain];
    [self addSubview:self.customTableView];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    self.customTableView.backgroundColor = [UIColor whiteColor];
    
    //--基本设置--<##>
    self.customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.customTableView.separatorColor = [UIColor lightGrayColor];
}

#pragma mark --数据源方法--

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

static NSString *IdentifierForcustomTableView = @"identifierForcustomTavleView";

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierForcustomTableView];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierForcustomTableView];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:0.9];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}






@end
