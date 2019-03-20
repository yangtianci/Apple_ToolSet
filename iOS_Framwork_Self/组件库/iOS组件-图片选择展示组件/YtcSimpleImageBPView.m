//
//  YtcSimpleImageBPView.m
//  DemoView
//
//  Created by 杨天赐 on 2019/1/17.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import "YtcSimpleImageBPView.h"



@interface YtcSimpleImageBPView ()


//@property (strong, nonatomic) UILabel *centerLab;

@property (strong, nonatomic) UIImageView *placeImgV;

@end



@implementation YtcSimpleImageBPView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        self.layer.cornerRadius = 10;
//        self.layer.masksToBounds = YES;
//
//        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        self.layer.borderWidth = 2;

        CGRect labRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.placeImgV = [[UIImageView alloc]initWithFrame:labRect];
        [self addSubview:self.placeImgV];
        self.placeImgV.image = [UIImage imageNamed:@"YtcSImages@2x.png"];
        
        
//        self.centerLab = [[UILabel alloc]initWithFrame:labRect];
//        [self addSubview:self.centerLab];
//
//        self.centerLab.font = [UIFont systemFontOfSize:50];
//        self.centerLab.textColor = [UIColor darkGrayColor];
//        self.centerLab.textAlignment = NSTextAlignmentCenter;
//        self.centerLab.numberOfLines = 1;
//        self.centerLab.text = @"+";

    }
    return self;
}


@end
