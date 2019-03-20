


Get

-(void)Request<#(nonnull id)#>WithUserTel:(NSString*)tel Success:(void(^)(id response))success Fail:(void(^)(NSString *msg, id info))fail{
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    
    [para setObject:<#(nonnull id)#> forKey:<#(nonnull id)#>];
    [para setObject:<#(nonnull id)#> forKey:<#(nonnull id)#>];
    
    [self GetData_WithPara:para Info:nil Path:<#(nonnull id)#> Success:^(NSDictionary *dict, id info) {
        
        //        if ([dict[@"code"] isEqualToString:@"0000"]) {
        //            NSString *msg = dict[@"msg"];
        //        }else{
        //            NSString *msg = @"请稍后重试";
        //        }
        
        success( dict );
        
    } Fail:^(NSURLSessionDataTask *task, id info) {
        fail(@"请求失败",task);
    }];
    
}

Post

-(void)Request_<#Name#>WithUserID:(NSString*)userID Page:(NSInteger)page StateType:(NSString*)stateType RefundState:(NSString*)refundState Success:(void(^)(id response))success Fail:(void(^)(NSString *msg, id info))fail{
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    
    [para setObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>];
    [para setObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>];
    [para setObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>];
    
    
    [self PostData_WithPara:para Info:nil Path:<#(nonnull id)#> Success:^(NSDictionary *dict, id info) {
        
        success( dict );
        
    } Fail:^(NSURLSessionDataTask *task, id info) {
        
        fail(@"请求失败",task);
        
    }];
}





if (CFUSERManager.isLogin) {
    // 继续接着下去
} else {
    [CFLoginTool showAlertLogin:^(BOOL isSuccess) {
        
    }];
    return;
}


>>>>>>>>>>>>>> 刷新模板

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *dataArr;


self.dataArr = [NSMutableArray array];
self.currentPage = 1;

-(void)AddRefreshMethod{
    
    WeakSelf
    
    self.list_VM = [[CFMineViewModel alloc]init];
    
    self.customTB.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [WS RefreshMethodWithType:0];
    }];
    
    self.customTB.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [WS RefreshMethodWithType:1];
    }];
    
    [self.customTB.mj_header beginRefreshing];
    
}


// 0 刷新 1 加载更多
-(void)RefreshMethodWithType:(NSInteger)refreshType{
    
    if (refreshType == 0) {
        // 刷新
        
        [self.dataArr removeAllObjects];
        
        [self.customTB.mj_footer resetNoMoreData];
        self.currentPage = 1;
    }else{
        // 加载
        self.currentPage++;
    }
    
    [self.list_VM Request_AttentionShopWithUserID:CFUSERModel.member_id Page:self.currentPage Success:^(id  _Nonnull response) {
        
        NSArray *tempArr = [response safeObjectForKey:@"data"];
        
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CFAttentionShopModel *model = [[CFAttentionShopModel alloc]initWithDict:obj];
            [self.dataArr addObject:model];
        }];
        
        [self.customTB reloadData];
        
        // 结束操作
        [self.customTB.mj_header endRefreshing];
        [self.customTB.mj_footer endRefreshing];
        if (tempArr.count < 10) {
            [self.customTB.mj_footer endRefreshingWithNoMoreData];
            
        }
        
    } Fail:^(NSString * _Nonnull msg, id  _Nonnull info) {
        [self.customTB.mj_header endRefreshing];
        [self.customTB.mj_footer endRefreshing];
        [MBProgressHUD showAutoMessage:msg];
    }];
    
}



if (@available(iOS 11.0, *)) {
    self.table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
} else {
    self.automaticallyAdjustsScrollViewInsets = NO;
}



