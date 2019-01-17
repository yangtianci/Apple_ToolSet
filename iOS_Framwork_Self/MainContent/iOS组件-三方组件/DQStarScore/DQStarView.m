//
//  DQStarView.m
//  NCHomeBaseTest
//
//  Created by 邓琪 dengqi on 2017/1/13.
//  Copyright © 2017年 邓琪 dengqi. All rights reserved.
//

#import "DQStarView.h"
#import "UIView+Extension.h"

#define DQDefaultImage @"Star_appraise_genger" //自带的背景图片
#define DQSelectImage @"Star_appraise_select"//自带的选中的图片
const NSInteger DQUpSpace = 1;//星星的上边距
@interface DQStarView ()

@property (nonatomic, strong) NSMutableArray *DefalutArr;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIView *clearView;
@property (nonatomic, assign) CGPoint savePoint;

@end
@implementation DQStarView

- (NSMutableArray *)DefalutArr{
    if (!_DefalutArr) {
        
        _DefalutArr = [NSMutableArray new];
    }
    return _DefalutArr;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (UIView *)clearView{
    if (!_clearView) {
        _clearView = [UIView new];
        _clearView.backgroundColor = [UIColor clearColor];
        _clearView.frame = self.bounds;
        _clearView.layer.masksToBounds = YES;
        _clearView.userInteractionEnabled = YES;
        [self addSubview:_clearView];
    }
    return _clearView;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self DQInitWithFunction];
    }
    return self;
}
- (instancetype)initWithDQStarFrme:(CGRect )frame starTotal:(NSUInteger )starTotalCount{
    self = [super initWithFrame:frame];
    if (self) {
        _starTotalCount =starTotalCount;
        [self DQInitWithFunction];
    }
    
    
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
   
}
- (void)setStarTotalCount:(NSUInteger)starTotalCount{
    
    _starTotalCount = starTotalCount;
    [self creationDQUIFunction];
}

- (void)setStarSpace:(CGFloat)starSpace{
    
    _starSpace = starSpace;
    [self starFromChageFunction];
}
- (void)setDefaultStarImageStr:(NSString *)DefaultStarImageStr{
    _DefaultStarImageStr = DefaultStarImageStr;
    [self starFromChageFunction];
    
}
- (void)setSelectStarImageStr:(NSString *)SelectStarImageStr{
    _SelectStarImageStr = SelectStarImageStr;
    [self starFromChageFunction];
}
- (void)setShowStyle:(DQStarShowStyle)ShowStyle{

    _ShowStyle = ShowStyle;
}
- (void)ShowDQStarScoreFunction:(CGFloat )score{
    
    CGFloat countFl = score;
    self.starCurrntFl = countFl;
    if (score>=_starTotalCount) {
        self.clearView.width = self.width;
        return;
    }
    NSInteger count = floorf(countFl);
    if (!countFl) {
        self.clearView.width = 0.0f;
        return;
    }
    CGSize size = [self StarWidthFunction:_DefaultStarImageStr];
    self.clearView.width = (count+1)*_starSpace +size.width*countFl;
    [self setNeedsLayout];
    
}
- (void)DQInitWithFunction{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
    _starSpace = 5;
    if (_starTotalCount<2) {
        _starTotalCount = 5;
    }
    
    _DefaultStarImageStr = DQDefaultImage;
    _SelectStarImageStr = DQSelectImage;
    _ShowStyle = DQStarShowStyleSingleClick;
    _savePoint = CGPointMake(0, 0);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesTapFunction:)];
    [self addGestureRecognizer:tap];
    [self creationDQUIFunction];
    
}
- (void)creationDQUIFunction{
    
    if (CGRectEqualToRect(self.frame, CGRectZero)) {//没有设置位置
        return;
    }
    if (!_starTotalCount) {
        return;
    }
    CGSize size = [self StarWidthFunction:_DefaultStarImageStr];
    if (self.DefalutArr.count&&(self.DefalutArr.count!=_starTotalCount)) {
        [self.DefalutArr removeAllObjects];
    }
    if (self.DefalutArr.count) {
        return;
    }
    for (int i=0; i<_starTotalCount; i++) {
        UIImageView *DefaultImageView = [UIImageView new];
        DefaultImageView.tag = 8000+i;
        DefaultImageView.image = [UIImage imageNamed:_DefaultStarImageStr];
        DefaultImageView.frame = CGRectMake(_starSpace*(i+1)+size.width*i, DQUpSpace, size.width, size.height);
        DefaultImageView.userInteractionEnabled = YES;
        [self addSubview:DefaultImageView];
        [self.DefalutArr addObject:DefaultImageView];
    }
    [self clearView];
    self.clearView.width = 0.0f;
    if (self.dataArr.count&&(self.dataArr.count!=_starTotalCount)) {
        [self.dataArr removeAllObjects];
        
    }
    if (self.dataArr.count) {
        return;
    }
    for (int i=0; i<_starTotalCount; i++) {
        UIImageView *SelectImageView = [UIImageView new];
        SelectImageView.tag = 9000+i;
        SelectImageView.image = [UIImage imageNamed:_SelectStarImageStr];
        SelectImageView.frame = CGRectMake(_starSpace*(i+1)+size.width*i, DQUpSpace, size.width, size.height);
        SelectImageView.userInteractionEnabled = YES;
        [self.clearView addSubview:SelectImageView];
        [self.dataArr addObject:SelectImageView];
    }
    
}
//该方法只会改变一次
- (void)starFromChageFunction{
    if ((!self.dataArr.count)||(!self.DefalutArr.count)) {
        return;
    }
    
    CGSize size = [self StarWidthFunction:_DefaultStarImageStr];
    
    for (int i=0; i<_DefalutArr.count; i++) {
        
        UIImageView *DefaultImageView = [_DefalutArr objectAtIndex:i];
        DefaultImageView.frame = CGRectMake(_starSpace*(i+1)+size.width*i, DQUpSpace, size.width, size.height);
    }
    
    for (int i=0; i<_dataArr.count; i++) {
        UIImageView *SelectImageView = [_dataArr objectAtIndex:i];
        SelectImageView.frame = CGRectMake(_starSpace*(i+1)+size.width*i, DQUpSpace, size.width, size.height);
        
    }
    
    [self setNeedsLayout];
}
//设置星星的宽度
-(CGSize )StarWidthFunction:(NSString *)imageStr{
    
    UIImage *DefaultImage = [UIImage imageNamed:imageStr];
    CGFloat imageWidth = DefaultImage.size.width;
    CGFloat imageHeight = DefaultImage.size.height;
    NSInteger way = 0;// 图片的长宽相等为1 其他为0
    
    if (imageWidth==imageHeight) {
        way = 1;
    }
    CGFloat width = (self.width-(_starTotalCount+1)*_starSpace)/(CGFloat)_starTotalCount;
    CGFloat heigth = self.height-2*DQUpSpace;
    CGFloat realwidth = MIN(width, heigth);
    if (width<=heigth) {//已宽度为准
        if (way) {
            heigth = realwidth;
        }else{
            
            heigth = (width*imageHeight)/imageWidth;
        }
        
    }else{
        
        if (way) {
            width = realwidth;
        }else{
            
            width = (heigth*imageWidth)/imageHeight;
        }
    }
    
    return CGSizeMake(width, heigth);
}
- (void)gesTapFunction:(UITapGestureRecognizer *)ges{
    CGPoint point= [ges locationInView:self];
    if ((point.x<0)&&(point.x>self.width)) {
        return;
    }
    DQStarShowStyle style = _ShowStyle;
    
    if (style == DQStarShowStyleSingleClick) {
        NSInteger index = [self getEventShowStartForPoint:point];
        if (_starCurrntFl<index) {
            [self ShowDQStarScoreFunction:index];
            _starCurrntFl = index;
        }else{
            _starCurrntFl = index+1;
            [self ShowDQStarScoreFunction:(index+1)];
        }
        if ([self.delegate respondsToSelector:@selector(starScoreChangFunction:andScore:)]) {
            
            [self.delegate starScoreChangFunction:self andScore:self.starCurrntFl];
        }
    }else if(style == DQStarShowStyleSingleHalfClick){
        CGFloat StarFl = [self getSingleHalfClickEventShowStartForPoint:point];
        [self ShowDQStarScoreFunction:StarFl];
        _starCurrntFl = StarFl;
        if ([self.delegate respondsToSelector:@selector(starScoreChangFunction:andScore:)]) {
            [self.delegate starScoreChangFunction:self andScore:self.starCurrntFl];
        }
    
    }

}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if ((point.x<0)&&(point.x>self.width)) {
        return;
    }
    DQStarShowStyle style = _ShowStyle;
    if (style==DQStarShowStyleSliding) {
        [self setClearWidth:point.x];
        if ([self.delegate respondsToSelector:@selector(starScoreChangFunction:andScore:)]) {
            _starCurrntFl = [self getStarScoreFromWidth:self.clearView.width];
            [self.delegate starScoreChangFunction:self andScore:self.starCurrntFl];
        }
    }
    [[self nextResponder] touchesEnded:touches withEvent:event];
    self.savePoint = point;

}
- (NSInteger )getEventShowStartForPoint:(CGPoint )point{
    
    CGSize size = [self StarWidthFunction:_DefaultStarImageStr];
    NSInteger index = 0;
    if (point.x<=_starSpace) {
        index = 0;
    }
    if (point.x>=(self.width-_starSpace)) {
       index = _starTotalCount;
    }
    index = floorf(point.x/(size.width+_starSpace));
    
    return index;
}
- (CGFloat )getSingleHalfClickEventShowStartForPoint:(CGPoint )point{
    
    CGSize size = [self StarWidthFunction:_DefaultStarImageStr];
    CGFloat indexFl = 0.0;
    if (point.x<=_starSpace) {
        return 0.0;
    }
    if (point.x>=(self.width-_starSpace)) {
        indexFl = (CGFloat)_starTotalCount;
        return indexFl;
    }
    NSInteger count = floorf(point.x/(size.width+_starSpace));
    
    if ((point.x-(count+1)*_starSpace-count*size.width)<0){
        indexFl = (CGFloat)count;
        return indexFl;
    }else{
        NSInteger halfWidth = floorf(size.width*0.5);
        NSInteger pointWidth = floor((point.x-(count+1)*_starSpace-count*size.width));
        indexFl = pointWidth/halfWidth;
        
    }
    indexFl = (indexFl+1)*0.5+count;
    if (indexFl>=_starTotalCount) {
        indexFl = _starTotalCount;
    }
    
    return indexFl;
}
- (void)setClearWidth:(CGFloat)width{
    if (width<0) {
        self.clearView.width = 0;
    }else if(width>=self.width){
        self.clearView.width = self.width;
    }else{
        self.clearView.width = width;
    }
    CGSize size = [self StarWidthFunction:_DefaultStarImageStr];
    self.starCurrntFl = self.clearView.width/(CGFloat)(_starSpace+size.width);
}
- (CGFloat)getStarScoreFromWidth:(CGFloat)width{
    if (width<=_starSpace) {
        return 0.0;
    }
    if ((width>=self.width-_starSpace)) {
        return (CGFloat)_starTotalCount;
    }
    CGSize size = [self StarWidthFunction:_DefaultStarImageStr];
    NSInteger count = floorf(width/(size.width+_starSpace));
    CGFloat countFl = 0.0;
    if ((width-(count+1)*_starSpace-count*size.width)<0) {
        countFl = 0.0;
    }else{
        countFl = (width-(count+1)*_starSpace-count*size.width)/size.width;
    }
    
    
    return count+countFl;

}
@end
