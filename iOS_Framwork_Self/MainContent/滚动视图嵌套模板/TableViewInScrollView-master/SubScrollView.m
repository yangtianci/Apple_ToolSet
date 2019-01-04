//
//  SubScrollView.m
//  TableView嵌套(纯净版)&分页控制器
//
//  Created by YangTianCi on 2018/1/7.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import "SubScrollView.h"
#import "SmallTableView.h"

@interface SubScrollView()

@property (nonatomic,strong) SmallTableView *SmallOne;
@property (nonatomic,strong) SmallTableView *SmallTwo;

@end

@implementation SubScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self ConfigurationUI];
    }
    return self;
}

-(void)setCanScroll_Sub:(BOOL)CanScroll_Sub{
    _CanScroll_Sub = CanScroll_Sub;
    if (!CanScroll_Sub) {
        self.SmallOne.OffsetPoint = CGPointMake(0, 0);
        self.SmallTwo.OffsetPoint = CGPointMake(0, 0);
    }
    self.SmallOne.CanScroll_Small = CanScroll_Sub;
    self.SmallTwo.CanScroll_Small = CanScroll_Sub;
}

-(void)setRefrsh:(BOOL)Refrsh{
    _Refrsh = Refrsh;
    if (self.contentOffset.x == 0) {
        self.SmallOne.Refresh = YES;
    }else{
        self.SmallTwo.Refresh = YES;
    }
}

#pragma mark ============ 配置UI
-(void)ConfigurationUI{
    
    self.pagingEnabled = YES;
    self.backgroundColor = [UIColor blueColor];
    
    self.SmallOne = [[SmallTableView alloc]initWithFrame:self.bounds];
    [self addSubview:self.SmallOne];
    self.SmallOne.backgroundColor = [UIColor blueColor];
    
    CGRect newRect = self.bounds;
    newRect.origin.x = [UIScreen mainScreen].bounds.size.width;
    self.SmallTwo = [[SmallTableView alloc]initWithFrame:newRect];
    [self addSubview:self.SmallTwo];
    self.SmallTwo.backgroundColor = [UIColor redColor];
    
    
}





@end
