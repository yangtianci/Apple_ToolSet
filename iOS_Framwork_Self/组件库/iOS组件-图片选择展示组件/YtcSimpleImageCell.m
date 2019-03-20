//
//  YtcSimpleImageCell.m
//  DemoView
//
//  Created by 杨天赐 on 2019/1/17.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import "YtcSimpleImageCell.h"

#import "YtcSimpleImageBPView.h"

@interface YtcSimpleImageCell ()

@property (strong, nonatomic) NSIndexPath *idx;

@property (assign, nonatomic) viewType type;

@property (assign, nonatomic) BOOL isDel;

// ====================================================================

@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

// ====================================================================

@property (strong, nonatomic) YtcSimpleImageBPView *btnPlaceView;


@end


@implementation YtcSimpleImageCell



#pragma mark ================= 数据绑定 channel

-(void)ConfigImg:(id)img Type:(viewType)type IsDelete:(BOOL)isdel Index:(NSIndexPath*)idx{
    
    
    self.idx = idx;
    
    self.type = type;
    self.isDel = isdel;
    
    if (type == viewType_imgV) {
        // 图片
        self.imgV.hidden = NO;
        
        if (self.btnPlaceView) {
            [self.btnPlaceView removeFromSuperview];
        }
        
        if ([img isKindOfClass:[UIImage class]]) {
            self.imgV.image = (UIImage*)img;
        }else if ([img isKindOfClass:[NSString class]]){
            [self.imgV sd_setImageWithURL:[NSURL URLWithString:(NSString*)img]];
        }
        if (isdel) {
            [self.delBtn setHidden:YES];
        }else{
            [self.delBtn setHidden:NO];
        }
    }else{
        // 按钮
        self.imgV.hidden = YES;
        [self.delBtn setHidden:YES];
        [self addSubview:self.btnPlaceView];
    }
    
    [self ConfigLogic];
    
}



#pragma mark ============================================== 初始化

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self ConfigUI];
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self ConfigUI];
    
    self.delBtn.layer.cornerRadius = 9;
    self.delBtn.layer.masksToBounds = YES;

}


-(void)ConfigUI{
    

    
}



-(void)ConfigLogic{
    
//    __weak typeof(self)WS = self;
    
    if (self.type == viewType_imgV) {
        
        self.imgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
        [self.imgV addGestureRecognizer:tapGesture];
        [tapGesture addTarget:self action:@selector(ImgTapMethod:)];

    }else if (self.type == viewType_btn){
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
        [self addGestureRecognizer:tapGesture];
        [tapGesture addTarget:self action:@selector(AddTapMethod:)];
    }
    
    if (self.delBtn) {
        [self.delBtn addTarget:self action:@selector(btnTapMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


-(void)ImgTapMethod:(UITapGestureRecognizer*)tap{
    
    if (self.imgClickCB) {
        self.imgClickCB(self.idx.row);
    }
    
}

-(void)btnTapMethod:(UIButton*)sender{
    
    if (self.delBtnCB) {
        self.delBtnCB(self.idx.row);
    }
    
}

-(void)AddTapMethod:(UITapGestureRecognizer*)tap{
    
    if (self.addBtnCB) {
        self.addBtnCB(self.idx.row);
    }
    
}



#pragma mark ============================================== Lazy


-(YtcSimpleImageBPView *)btnPlaceView{
    if (!_btnPlaceView) {
        _btnPlaceView = [[YtcSimpleImageBPView alloc]initWithFrame:self.bounds];
    }
    return _btnPlaceView;
}




@end
