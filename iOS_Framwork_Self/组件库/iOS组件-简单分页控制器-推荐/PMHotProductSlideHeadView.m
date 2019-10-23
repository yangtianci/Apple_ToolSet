//
//  PMHotProductSlideHeadView.m
//  RichGo
//
//  Created by 杨天赐 on 2019/10/23.
//  Copyright © 2019 chtwm. All rights reserved.
//

#import "PMHotProductSlideHeadView.h"


@interface PMHotProductSlideHeadView ()

@property (strong, nonatomic) UIScrollView *MainScrollView;

@property (strong, nonatomic) UIView *cursonView;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) NSMutableArray *BtnArr;


@property (strong, nonatomic) NSArray *titleArr;

@property (strong, nonatomic) UIButton *selectBtn;

@end


@implementation PMHotProductSlideHeadView


static CGFloat NormalFont = 15;
static CGFloat SelectFont = 18;
static CGFloat FirstAndLastMargin = 15;
static CGFloat MiddleMargin = 15;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)ConfigUI{
    
#pragma mark ============================================== BtnArr
    
    self.MainScrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    [self addSubview:self.MainScrollView];
    self.MainScrollView.contentSize = CGSizeMake(kScreenW, self.frame.size.height);
    self.MainScrollView.showsVerticalScrollIndicator = NO;
    self.MainScrollView.showsHorizontalScrollIndicator = NO;
    self.MainScrollView.backgroundColor = [UIColor whiteColor];
    
#pragma mark ============================================== lineView
    
    [self.MainScrollView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"F7F9FC"];
    
#pragma mark ============================================== Cusron
    
    [self.MainScrollView addSubview:self.cursonView];
    self.cursonView.frame = CGRectMake(0, self.frame.size.height-3, 30, 3);
    self.cursonView.backgroundColor = [UIColor orangeColor];
    
    
    
#pragma mark ============================================== BtnS
    
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    CGFloat itemWidth = 0;
    CGFloat itemH = self.frame.size.height;
    
    
    
    NSInteger defaultIdx = self.defaultSelectIdx;
    
    for (int i = 0; i < self.titleArr.count; i++) {
        
        if (self.isAverage == YES) {
            itemX = itemWidth * i;
        }else{
            itemX = itemX + itemWidth;
            if (i == 0) {
                itemX += FirstAndLastMargin;
            }else{
                itemX += MiddleMargin;
            }
        }
        
        NSString *titleString = self.titleArr[i];
        
        if (self.isAverage == YES) {
            NSInteger count = self.titleArr.count;
            itemWidth = kScreenW / count;
        }else{
            itemWidth = [titleString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:SelectFont]} context:nil].size.width;
        }
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(itemX, itemY, itemWidth, itemH)];
        [self.MainScrollView addSubview:btn];
        
        [btn setTitle:titleString forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithHexString:@"B2B6BF"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:NormalFont]];
        btn.tag = i;
        [btn addTarget:self action:@selector(TagMethodWithSender:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == defaultIdx) {
            
            [self TagMethodWithSender:btn];
            
        }
        
        [self.BtnArr addObject:btn];
        
    }
    
    UIButton *lastBtn = self.BtnArr.lastObject;
    CGFloat scrollWidth = CGRectGetMaxX(lastBtn.frame) + FirstAndLastMargin;
    self.MainScrollView.contentSize = CGSizeMake(scrollWidth, self.frame.size.height);
    
}

-(void)TagMethodWithSender:(UIButton*)sender{
    
    self.selectBtn.selected = NO;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:NormalFont];
    
    self.selectBtn = sender;
    self.selectBtn.selected = YES;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:SelectFont];
    
    CGRect originRect = self.cursonView.frame;
    originRect.origin.x = sender.frame.origin.x + ( sender.frame.size.width - originRect.size.width ) / 2;
    
#pragma mark ============================================== 计算偏移
    CGFloat btnX = self.selectBtn.x;
    CGFloat btnMaxX = CGRectGetMaxX(self.selectBtn.frame);
    
    CGFloat scrollX = self.MainScrollView.contentOffset.x;
    CGFloat scrollMaxX = self.MainScrollView.contentOffset.x + self.MainScrollView.size.width;
    
    CGPoint offetSet;
    
    if (btnX > scrollX && btnMaxX < scrollMaxX) {
        // 范围内, 不操作
        offetSet = self.MainScrollView.contentOffset;
    }else{
        if (btnX < scrollX) {
            offetSet = CGPointMake(btnX - MiddleMargin, 0);
        }else {
            offetSet = CGPointMake(btnMaxX - self.MainScrollView.frame.size.width + MiddleMargin, 0);
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.cursonView.frame = originRect;
        if (!self.isAverage) {
            self.MainScrollView.contentOffset = offetSet;
        }
    }];
    
    if (self.btnCallBack) {
        self.btnCallBack(sender.tag, sender.titleLabel.text);
    }
    
}

-(void)ManualSetSelectIdx:(NSInteger)idx{
    
    [self TagMethodWithSender:self.BtnArr[idx]];
    
}



-(void)ConfigDataWithTitleArr:(NSArray *)titleArr{
    self.titleArr = titleArr;
    [self ConfigUI];
}



#pragma mark ============================================== lazy



-(NSMutableArray *)BtnArr{
    if (!_BtnArr) {
        _BtnArr = [NSMutableArray array];
    }
    return _BtnArr;
}


-(UIView *)cursonView{
    
    if (!_cursonView) {
        _cursonView = [[UIView alloc]init];
    }
    return _cursonView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
    }
    return _lineView;
}


@end
