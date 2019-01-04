

<#Content#>

#pragma mark >>>>>>>>>> 属性

@property (nonatomic, copy) NSString *<#property#>; // Yy_String 字符属性
@property (nonatomic, strong) <#Class#> *<#property#>; // Yy_Strong 强引用属性
@property (nonatomic, assign) <#Class#> <#property#>; // Yy_Assing 基本类型属性
@property (nonatomic, copy) <#Class#> *<#property#>; // Yy_Copy 深拷贝属性

#pragma mark >>>>>>>>>> 注释

//#pragma mark >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 一级注释 // Yy_P1
//#pragma mark >>>>>>>>>>>>>>>>>>>> 二级注释 // Yy_P2
//#pragma mark >>>>>>>>>>> 三级注释 // Yy_P3

// Yy_Config
//#pragma mark >>>>>>>>>> 配置 UI
//-(void)ConfigUI{
//
//    <#Content#>
//    
//}


#pragma mark >>>>>>>>>> Masonary 布局


// Yy_masLayout Mas布局
[<#Content#> mas_makeConstraints:^(MASConstraintMaker *make) {
    <#Content#>
}];

// Yy_masleft Mas_Left
make.left.mas_equalTo(<#Content#>)<#.with.offset()#>;
// Yy_masright Mas_Right
make.right.mas_equalTo(<#Content#>)<#.with.offset()#>;
// Yy_mastop Mas_Top
make.top.mas_equalTo(<#Content#>)<#.with.offset()#>;
// Yy_masbottom Mas_Bottom
make.bottom.mas_equalTo(<#Content#>)<#.with.offset()#>;
// Yy_maswidth Mas_Width
make.width.mas_equalTo(<#Content#>);
// Yy_masheight Mas_Height
make.height.mas_equalTo(<#Content#>);
// Yy_mascenterX Mas_CenterX
make.centerX.mas_equalTo(<#Content#>);
// Yy_mascenterY Mas_CenterY
make.centerY.mas_equalTo(<#Content#>);
// Yy_masbaseline Mas_Baseline
make.baseline.mas_equalTo(<#Content#>);

#pragma mark >>>>>>>>>> 常用控件

// UICollectionView. UIScrollView. >>> 之后有时间了再写 

#pragma mark >>>>>>>>>> TapGesture

// Yy_Tap 控件_Tap
UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(<#Content#>)];
[<#Content#> addGestureRecognizer:tap];

#pragma mark >>>>>>>>>> UIView

// Yy_View 控件_View
<#UIView *#> = [[UIView alloc]init];
[<#Content#> addSubview:<#Content#>];
<#Content#>.backgroundColor = <#[UIColor ]#>;

#pragma mark >>>>>>>>>> UILabel

// Yy_Label 控件_Label
<#UILabel *#> = [[UILabel alloc]init];
[<#Content#> addSubview:<#Content#>];
<#Content#>.text = @"<#Content#>";
<#Content#>.font = [UIFont systemFontOfSize:<#Content#>];
<#Content#>.textColor = <#[UIColor ]#>;
<#Content#>.textAlignment = NSTextAlignmentCenter;

#pragma mark >>>>>>>>>> UIImageView

// Yy_Image 控件_ImageView
<#UIImageView *#> = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"<#Content#>"]];
[<#Content#> addSubview:<#Content#>];
<#Content#>.userInteractionEnabled = YES;

#pragma mark >>>>>>>>>> UIButton

// Yy_Button 控件_Button
<#UIButton *#> = [[UIButton alloc]init];
[<#Content#> addSubview:<#Content#>];
[<#Content#> setTitle:@"<#Content#>" forState:UIControlStateNormal];
[<#Content#> setTitleColor:<#[UIColor ]#> forState:UIControlStateNormal];
[<#Content#> setBackgroundImage:[UIImage imageNamed:@"<#Content#>"] forState:UIControlStateNormal];
[<#Content#> setBackgroundImage:[UIImage imageNamed:@"<#Content#>"] forState:UIControlStateNormal];
[[<#Content#> rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
    <#Content#>
}];

#pragma mark >>>>>>>>>> UITextField

// Yy_textField 控件_TextField
<#UITextField *#> = [[UITextField alloc]init];
[<#Content#> addSubview:<#Content#>];
<#Content#>.font = <#[UIFont systemFontOfSize:]#>;
<#Content#>.textAlignment = NSTextAlignmentLeft;
<#Content#>.borderStyle = UITextBorderStyleNone;
<#Content#>.placeholder = @"<#Content#>";
[<#Content#> setValue:<#[UIColor ]#> forKeyPath:@"_placeholderLabel.textColor"];
<#Content#>.textColor = <#[UIColor ]#>;

#pragma mark >>>>>>>>>> UITextView

// Yy_textView 控件_TextView
<#UITextView *#> = [[UITextView alloc]init];
[<#Content#> addSubview:<#Content#>];
<#Content#>.font = <#[UIFont systemFontOfSize:]#>;
<#Content#>.textColor = <#[UIColor ]#>;

#pragma mark >>>>>>>>>> UITableView

// Yy_tableView 控件_UITableView
-(void)ConfigTableView{
    
    <#Content#> = [[UITableView alloc]initWithFrame:<#Content#> style:UITableViewStyleGrouped];
    [<#Content#> addSubview:<#Content#>];
    <#Content#>.delegate = self;
    <#Content#>.dataSource = self;
    <#Content#>.backgroundColor = <#[UIColor ]#>;
    
    <#Content#>.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

//#pragma mark --数据源方法--
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return <#Content#>;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return <#Content#>;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    <#Content#>
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return <#Content#>;
}

//#pragma mark --代理方法--
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor clearColor];
    lineView.frame = CGRectMake(0, 0, kScreenWidth, 0);
    return lineView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor clearColor];
    lineView.frame = CGRectMake(0, 0, kScreenWidth, 0);
    return lineView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}







