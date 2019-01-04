


#pragma mark >>>>>>>>>> 标签控制器

<UITabBarControllerDelegate>

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *itemNormalArr = @[@"即觅",@"眼缘",@"心动",@"我的"];
    NSArray *itemImgArr = @[@"icondick_shouye",@"icondick_chanpin",@"icondick_xueyuan",@"icondick_wode"];
    NSArray *itemImgSelectArr = @[@"icondick_shouye",@"icondick_chanpin",@"icondick_xueyuan",@"icondick_wode"];
    self.delegate = self;
    [self setupChildVc:[[<#Content#> alloc] init] NavVC:@"<#Content#>" title:itemNormalArr[0] image:itemImgArr[0] selectedImage:itemImgSelectArr[0]];
    
    // ~~~~~~~~~~~~~~~~~~~~~ 增加 //
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    [self hidesBottomBarWhenPushed];
    
    //设置字体
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

//设置控制器的属性、标题
- (void)setupChildVc:(UIViewController *)vc NavVC:(NSString*)navVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.view.backgroundColor = kRandomColor;
    vc.navigationItem.title = title;
    //设置 NavBar
    Class navClass = NSClassFromString(navVC);
    
    UINavigationController *nav = (UINavigationController*)[[navClass alloc] initWithRootViewController:vc];
    UINavigationBar *bar=nav.navigationBar;
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.hidesBottomBarWhenPushed = NO;
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bar.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:nav];
}


#pragma mark >>>>>>>>>> Delegate

{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    <#Content#> *mainTabbar = [[<#Content#> alloc]init];
    self.window.rootViewController = mainTabbar;
    [self.window makeKeyWindow];
    
}



