//
//  YtcSimpleInputView.m
//  DemoView
//
//  Created by 杨天赐 on 2019/1/17.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import "YtcSimpleInputView.h"

#define marginVertical 8
#define marginHorizen 8

@interface YtcSimpleInputView ()


@end


@implementation YtcSimpleInputView

-(NSString *)contentString{
    return _inputView.text;
}

// ====================================================================

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self ConfigUI];
        
    }
    return self;
}


-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self ConfigUI];
    
}


-(void)ConfigUI{
    
    self.maxCount = 150;
    
    [self addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).with.offset(0);
        make.right.mas_equalTo(self.mas_right).with.offset(-0);
        make.left.mas_equalTo(self.mas_left).with.offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-0);
        
    }];
    
    [self addSubview:self.placeLab];
    [self.placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.inputView.mas_top).with.offset(marginHorizen);
        make.left.mas_equalTo(self.inputView.mas_left).with.offset(marginVertical);
        make.right.mas_equalTo(self.inputView.mas_right).with.offset(-marginVertical);
        
    }];
    
    [self addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.inputView.mas_right).with.offset(-marginVertical);
        make.bottom.mas_equalTo(self.inputView.mas_bottom).with.offset(-marginHorizen);
        
    }];
    
    
    [self ConfigLogic];
    
}



-(void)ConfigLogic{
    
    __weak typeof(self)WS = self;
    
    [[self.inputView rac_textSignal]subscribeNext:^(NSString * _Nullable x) {

        if (x.length > 0) {
            [WS.placeLab setHidden:YES];
        }else{
            [WS.placeLab setHidden:NO];
        }
        
        NSInteger textCount = x.length;
        
        if (x.length >= WS.maxCount) {
            
            if (WS.masTextCallBack) {
                WS.masTextCallBack(@"超出最大字数");
            }
            
            NSString *string = [x substringToIndex:WS.maxCount];
            WS.inputView.text = string;
            textCount = WS.maxCount;
        }
        
        WS.countLab.text = [NSString stringWithFormat:@"%zd/%zd",textCount,WS.maxCount];
        
    }];
    
}


#pragma mark ============================================== Lazy


-(UITextView *)inputView{
    if (!_inputView) {
        //--必须设置--<##>
        _inputView = [[UITextView alloc]init];
        
        //--基本设置--<##>
        _inputView.font = [UIFont systemFontOfSize:14];
        _inputView.textColor = [UIColor lightGrayColor];
        _inputView.textAlignment = NSTextAlignmentLeft;
        _inputView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    }
    return _inputView;
}


-(UILabel *)placeLab{
    
    if (!_placeLab) {
        
        _placeLab = [[UILabel alloc]init];
        
        _placeLab.font = [UIFont systemFontOfSize:14];
        _placeLab.textColor = [UIColor lightGrayColor];
        _placeLab.textAlignment = NSTextAlignmentLeft;
        _placeLab.numberOfLines = 0;
        _placeLab.text = @"分享当地的趣事...";
    }
    return _placeLab;
}

-(UILabel *)countLab{
    if (!_countLab) {
        
        _countLab = [[UILabel alloc]init];
        
        _countLab.font = [UIFont systemFontOfSize:13];
        _countLab.textColor = [UIColor lightGrayColor];
        _countLab.textAlignment = NSTextAlignmentRight;
        _countLab.numberOfLines = 1;
        _countLab.text = [NSString stringWithFormat:@"0/%zd",self.maxCount];
        
    }
    return _countLab;
}




@end
