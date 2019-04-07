//
//  SMAgencyOrderControllerViewController.m
//  ShangMi
//
//  Created by 杨天赐 on 2019/4/5.
//  Copyright © 2019 ShangMi. All rights reserved.
//

#import "SMAgencyOrderControllerViewController.h"

#define LeftTable_Width 100  // 左侧tableView的宽度
#define Address_Height  45   // 地址视图高度

@interface SMAgencyOrderControllerViewController ()

<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSMutableArray *dataArray; // 数据

@end

@implementation SMAgencyOrderControllerViewController


#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - sysetem method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"列表联动";
    [self loadData];
    [self creatSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - accessory method

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"vegetable" ofType:@"json"];
    [self.dataArray addObjectsFromArray:[NSArray array]];
}

- (void)creatSubViews {
    // 解决tableView偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 左侧tableView
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Address_Height+64, LeftTable_Width, [UIScreen mainScreen].bounds.size.height - 64 - 50 - Address_Height) style:UITableViewStylePlain];
    self.leftTableView.backgroundColor = [UIColor yellowColor];
    self.leftTableView.dataSource = self;
    self.leftTableView.delegate = self;
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.leftTableView];
    //    // 隐藏单元格分割线
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.leftTableView.showsVerticalScrollIndicator = NO; // 隐藏滚动条
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(LeftTable_Width, Address_Height + 64, [UIScreen mainScreen].bounds.size.width - LeftTable_Width, [UIScreen mainScreen].bounds.size.height - 64 - 50 - Address_Height) style:UITableViewStyleGrouped];
    self.rightTableView.backgroundColor = [UIColor clearColor];
    self.rightTableView.dataSource = self;
    self.rightTableView.delegate = self;
    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.rightTableView];
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.leftTableView == tableView) {
        return 1;
    } else {
        //        return self.dataArray.count;
        return 10;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.leftTableView == tableView) {
        //        return self.dataArray.count;
        return 3;
    } else {
        return 12;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 50;
    } else {
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 0;
    } else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return CGFLOAT_MIN;
    } else {
        return CGFLOAT_MIN;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return @"";
    } else {
        return @"我的蔬菜";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return nil;
    } else {
        UIView *headView = [UIView new];
        headView.backgroundColor = [UIColor yellowColor];
        
        UILabel *headLabel = [UILabel new];
        [headView addSubview:headLabel];
        headLabel.textColor = [UIColor blackColor];
        headLabel.font = [UIFont systemFontOfSize:16];
        
        return headView;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.leftTableView == tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    }
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_leftTableView == tableView) {
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 滑动视图上移动画
    
    if (scrollView == self.rightTableView) {
        //取出当前显示的最顶部的cell的indexpath
        //当前tableview页面可见的分区属性 indexPathsForVisibleRows
        // 取出显示在 视图 且最靠上 的 cell 的 indexPath
        // 判断tableView是否滑动到最底部
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
        if (bottomOffset <= height) {
            NSIndexPath *bottomIndexPath = [[self.rightTableView indexPathsForVisibleRows] lastObject];
            NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:bottomIndexPath.section inSection:0];
            [self.leftTableView selectRowAtIndexPath:moveIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        } else {
            NSIndexPath *topIndexPath = [[self.rightTableView indexPathsForVisibleRows]firstObject];
            NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:topIndexPath.section inSection:0];
            [self.leftTableView selectRowAtIndexPath:moveIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        }
    }else{
        return;
    }
}

@end
