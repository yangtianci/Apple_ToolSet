//
//  YtcSimpleSegementView.m
//  CountryYard
//
//  Created by 杨天赐 on 2018/11/9.
//  Copyright © 2018 tidoo. All rights reserved.
//

#import "YtcSimpleSegementView.h"

@interface YtcSimpleSegementView ()<UIScrollViewDelegate>


@property (assign, nonatomic) CGFloat normalFont;
@property (strong, nonatomic) UIColor *normaColor;

@property (assign, nonatomic) CGFloat selFont;
@property (strong, nonatomic) UIColor *selColor;

@property (assign, nonatomic) CGFloat cursonH;
@property (strong, nonatomic) UIColor *cursonColor;

@property (assign, nonatomic) CGFloat margin1;
@property (assign, nonatomic) CGFloat marginMiddle;
@property (assign, nonatomic) BOOL isScale;


@property (strong, nonatomic) UIScrollView *mainSV;

@property (strong, nonatomic) UIView *cursonView;

@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSMutableArray *btnArray;


@property (strong, nonatomic) UIButton *selBtn;

@end



@implementation YtcSimpleSegementView


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.btnArray = [NSMutableArray array];
        
        self.normalFont = 14;
        self.normaColor = [UIColor lightGrayColor];
        
        self.selFont = 15;
        self.selColor = [UIColor darkGrayColor];
        
        self.cursonH = 3;
        self.cursonColor = [UIColor redColor];
        
        
        self.margin1 = 10;
        self.marginMiddle = 7;
        self.isScale = YES;
        
        [self ConfigUI];
        [self ConfigLogic];
    }
    return self;
}

#pragma mark ================= 配置逻辑

-(void)ConfigLogic{
    
    
    
}

-(void)SelectIndex:(NSInteger)idx CallBack:(void(^)())callBack{
    UIButton *btn = self.btnArray[idx];
    [self btnButtonMethodWithSender:btn];
}


-(void)btnButtonMethodWithSender:(UIButton*)sender{
    
    __weak typeof(self)WS = self;
    
    self.selBtn.selected = NO;
    [self btn_StateNormalWithBtn:self.selBtn];
    
    sender.selected = YES;
    
    self.selBtn = sender;
    [self btn_StateSelectWithBtn:self.selBtn];
    
    CGRect currentOrgianl = sender.frame;
    CGRect cursonFrame = self.cursonView.frame;
    
//    CGFloat finalX = currentOrgianl.origin.x + (currentOrgianl.size.width - cursonFrame.size.width)/2;
    
    cursonFrame.origin.x = currentOrgianl.origin.x;
    cursonFrame.size.width = currentOrgianl.size.width;
    
    [UIView animateWithDuration:0.3 animations:^{
        WS.cursonView.frame = cursonFrame;
    } completion:^(BOOL finished) {
    }];
    
    if (self.selectCallBack) {
        self.selectCallBack(sender.tag, nil);
    }
}

// 妈的, 好像白写了
//-(void)CursonMoveMethodWithBtn:(UIButton*)btn{
//    CGRect btnRect = btn.frame;
//    CGRect cursonRect = CGRectMake(btnRect.origin.x, self.cursonView.frame.origin.y, btnRect.size.width, self.cursonH);
//    [UIView animateWithDuration:0.3 animations:^{
//        self.cursonView.frame = cursonRect;
//    }];
//}


#pragma mark ================= 配置数据

-(void)ConfigNormalFont:(NSInteger)normalFont SelectFont:(NSInteger)selecFont NormalColor:(UIColor *)normalColro SelColor:(UIColor *)selColor CursonColor:(UIColor*)cursonColor CursonHeight:(CGFloat)cursonH{
    
    self.normalFont = normalFont;
    self.normaColor = normalColro;
    
    self.selFont = selecFont;
    self.selColor = selColor;
    
    self.cursonH = cursonH;
    self.cursonColor = cursonColor;
    
}

-(void)COnfigMargin1:(CGFloat)margin1 MarginMiddle:(CGFloat)marginMiddle IsScale:(BOOL)isScale{
    self.margin1 = margin1;
    self.marginMiddle = marginMiddle;
    self.isScale = isScale;
}


-(void)ConfigTitleArray:(NSArray*)titleArray{
    
    // ====================================================================
    
    self.mainSV = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:self.mainSV];
    self.mainSV.contentSize = CGSizeMake(kScreenWidth, self.frame.size.height);
    self.mainSV.backgroundColor = [UIColor whiteColor];
    self.mainSV.delegate = self;
    self.mainSV.showsHorizontalScrollIndicator = NO;
    self.mainSV.showsVerticalScrollIndicator = NO;

    // ====================================================================
    
    self.titleArray = titleArray;
    
    BOOL isBigger = [self isBiggerThanScreenWidthWithArray:self.titleArray];
    
    if (isBigger) {
        [self Layout_1];
    }else{
        if (self.isScale == YES) {
            [self Layout_2];
        }else{
            [self Layout_3];
        }
    }
    
    
    // ====================================================================
    
    UIButton *btn = self.btnArray.firstObject;

    CGRect cursonRect = CGRectMake(btn.frame.origin.x, self.frame.size.height - self.cursonH, btn.frame.size.width, self.cursonH);
    self.cursonView = [[UIView alloc]initWithFrame:cursonRect];
    [self.mainSV addSubview:self.cursonView];
    self.cursonView.backgroundColor = self.cursonColor;
    
}

//可滚动
-(void)Layout_1{
    
    NSMutableString *totalString = [NSMutableString string];
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [totalString appendString:obj];
    }];
    
    CGFloat Twidth = kStringWidth(totalString, self.normalFont + 1);
    Twidth += (self.titleArray.count - 1) * self.marginMiddle;
    Twidth += 2 * self.margin1;
    
    // ====================================================================
    
    self.mainSV.contentSize = CGSizeMake(Twidth + 30, self.frame.size.height);
    
    // ====================================================================
    
    CGFloat currentX = self.margin1;
    
    for (int i = 0; i < self.titleArray.count; i++) {
        
        CGFloat stringWidth = kStringWidth(self.titleArray[i], self.normalFont + 1);
        
        //--必须设置--
        CGRect btnRect = CGRectMake(currentX, 0, stringWidth, self.frame.size.height - self.cursonH);
        UIButton *btn = [[UIButton alloc]initWithFrame:btnRect];
        [self.mainSV addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnButtonMethodWithSender:) forControlEvents:UIControlEventTouchUpInside];
        //--基本设置--<##>
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        
        [self btn_StateNormalWithBtn:btn];
        if (i == 0) {
            [self btn_StateSelectWithBtn:btn];
        }
        
        [self.mainSV addSubview:btn];
        
        [self.btnArray addObject:btn];
        
        currentX += _margin1;
        currentX += stringWidth;
    }
    
}

//不可滚动_平均分布
-(void)Layout_2{
    
    CGFloat itemWidth = kScreenWidth / self.titleArray.count;
    
    // ====================================================================
    
    CGFloat currentX = 0;
    
    for (int i = 0; i < self.titleArray.count; i++) {
        
        //--必须设置--
        CGRect btnRect = CGRectMake(currentX, 0, itemWidth, self.frame.size.height - self.cursonH);
        UIButton *btn = [[UIButton alloc]initWithFrame:btnRect];
        [self.mainSV addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnButtonMethodWithSender:) forControlEvents:UIControlEventTouchUpInside];
        //--基本设置--<##>
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        
        [self btn_StateNormalWithBtn:btn];
        if (i == 0) {
            [self btn_StateSelectWithBtn:btn];
        }
        
        [self.mainSV addSubview:btn];
        [self.btnArray addObject:btn];
        
        currentX += itemWidth;
    }
    
}

//不可滚动_压缩分布
-(void)Layout_3{
    
    CGFloat currentX = _margin1;
    
    for (int i = 0; i < self.titleArray.count; i++) {
        
        CGFloat stringWidth = kStringWidth(self.titleArray[i], self.normalFont);
        
        //--必须设置--
        CGRect btnRect = CGRectMake(currentX, 0, stringWidth, self.frame.size.height - self.cursonH);
        UIButton *btn = [[UIButton alloc]initWithFrame:btnRect];
        [self.mainSV addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnButtonMethodWithSender:) forControlEvents:UIControlEventTouchUpInside];
        //--基本设置--<##>
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        
        [self btn_StateNormalWithBtn:btn];
        if (i == 0) {
            [self btn_StateSelectWithBtn:btn];
        }
        
        [self.mainSV addSubview:btn];
        [self.btnArray addObject:btn];
        
        currentX += _marginMiddle;
    }
    
}

// btn 普通状态设置
-(void)btn_StateNormalWithBtn:(UIButton*)btn{
    [btn setTitleColor:self.normaColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:self.normalFont];
}

// btn 选中状态设置
-(void)btn_StateSelectWithBtn:(UIButton*)btn{
    [btn setTitleColor:self.selColor forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:self.selFont];
}

#pragma mark ================= 计算数据

-(BOOL)isBiggerThanScreenWidthWithArray:(NSArray *)arr{
    
    NSMutableString *totalString = [NSMutableString string];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [totalString appendString:obj];
    }];
    
    CGFloat width = kStringWidth(totalString, self.normalFont);
    width += (arr.count - 1) * self.marginMiddle;
    width += 2 * self.margin1;
    
    return width > kScreenWidth ? YES : NO;
}

#pragma mark ================= 配置 UI

-(void)ConfigUI{
    
    
    
}


@end
