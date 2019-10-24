//
//  BlankView.m
//  RichGo
//
//  Created by tuikai on 2017/5/25.
//  Copyright © 2017年 chtwm. All rights reserved.
//

#import "BlankView.h"

@interface BlankView(){
}

@end
@implementation BlankView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame ]) {
        [self layOut];
    }
    return self;
}

-(instancetype)init
{
    if (self=[super init]) {
        [self layOut];
    }
    return self;
}
-(void)layOut{
    self.imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emptyData"]];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(90);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    UILabel *label=[[UILabel alloc]init];self.textlabel=label;
    [self addSubview:label];
    [label sizeToFit];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=UIColorHex(999999);
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"目前暂无数据";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(40);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
}
@end
