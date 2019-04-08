//
//  historyView.m
//  NormalDemo
//
//  Created by 杨天赐 on 2019/4/8.
//  Copyright © 2019 hui. All rights reserved.
//

#import "historyView.h"

#define btnInnerMargin 10

@interface historyView()

@property (strong, nonatomic)NSMutableArray *btnArr;

@property (strong, nonatomic) NSMutableArray *rectArr;

@end


@implementation historyView


-(void)ConfigTitleArr:(NSArray*)titleArray CallBack:(void(^)(CGRect lastRect))cb{
    self.titleArr = titleArray;
    [self ConfigUI];
    NSValue *value = self.rectArr.lastObject;
    CGRect rect = [value CGRectValue];
    if (cb) {
        cb(rect);
    }
}



-(void)ConfigUI{
    
    [self LayoutView];
    
    for (int i = 0; i < self.titleArr.count; i++) {
        
        NSValue *value = self.rectArr[i];
        CGRect frame = value.CGRectValue;
        
        //--必须设置--
        UIButton *customButton = [[UIButton alloc]initWithFrame:frame];
        [self addSubview:customButton];
        //--基本设置--<##>
        [customButton setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [customButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        customButton.titleLabel.font = [UIFont systemFontOfSize:_Font];
        
        //--附加设置 3 --
        customButton.layer.borderColor = [UIColor grayColor].CGColor;
        customButton.layer.borderWidth = 1;
        
        customButton.layer.cornerRadius = ([UIFont systemFontOfSize:_Font].lineHeight + 5)/2;
        customButton.layer.masksToBounds = YES;

    }

    
    
}




-(void)LayoutView{
    
    if (_Font == 0) {
        _Font = 14;
    }
    if (_TopMargin == 0) {
        _TopMargin = 10;
    }
    if (_RightMargin == 0) {
        _RightMargin = 10;
    }
    if (_BtnSMargin == 0) {
        _BtnSMargin = 10;
    }
    if (_BtnInnerMargin == 0) {
        _BtnInnerMargin = 5;
    }
    if (_BtnVMargin == 0) {
        _BtnVMargin = 5;
    }
    
    CGFloat lineHeigth = [UIFont systemFontOfSize:_Font].lineHeight + 5;
    
    CGFloat maxX = _RightMargin;
    CGFloat maxY = _TopMargin;
    NSInteger row = 0;
    
    for (int i = 0; i < self.titleArr.count; i++) {
        
        CGRect rect;
        
        CGFloat currentWitdth = [self GetWidthWithText:self.titleArr[i]];
        CGFloat lastWidth = self.frame.size.width - maxX;
        
        rect.size = CGSizeMake(currentWitdth, lineHeigth);
        
        if (lastWidth >= currentWitdth + _BtnSMargin * 2) {
            // 剩余宽度足够
            rect.origin.x = maxX + _BtnSMargin;
            rect.origin.y = maxY;
            
            maxX += currentWitdth;
            maxX += _BtnSMargin;
            
        }else{
            // 剩余宽度不足
            
            maxY = maxY + _BtnVMargin + lineHeigth;
            row += 1;
            maxX = _RightMargin;
            
            rect.origin.x = maxX + _BtnSMargin;
            rect.origin.y = maxY;
            
            maxX += currentWitdth;
            maxX += _BtnSMargin;
            
        }
        
        NSValue *value = [NSValue valueWithCGRect:rect];
        [self.rectArr addObject:value];
    }
    
}



-(CGFloat)GetWidthWithText:(NSString*)text{
    
    CGFloat width = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, [UIFont systemFontOfSize:_Font].lineHeight) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:_Font]} context:nil].size.width;
    
    return width + _BtnInnerMargin * 2;
    
}

-(NSMutableArray *)rectArr{
    if (!_rectArr) {
        _rectArr = [NSMutableArray array];
    }
    return _rectArr;
}

-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}


@end
