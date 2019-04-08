//
//  historyView.h
//  NormalDemo
//
//  Created by 杨天赐 on 2019/4/8.
//  Copyright © 2019 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark ============================================== 搜索历史不规则排序界面

/**
 
 CGRect rect = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height);
 
 historyView *testV = [[historyView alloc]initWithFrame:rect];
 testV.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:testV];
 
 NSArray *arr = [NSArray arrayWithObjects:@"test",@"testtesttesttest",@"testtest",@"testtesttest",@"testtesttesttesttesttesttesttesttesttest",@"testtetetetes",@"testtesttesttesttesttesttesttesttesttest",@"testtesttesttesttesttesttesttesttesttest", nil];
 
 [testV ConfigTitleArr:arr CallBack:^(CGRect lastRect) {
 
 CGFloat maxY = CGRectGetMaxY(lastRect);
 CGRect orgianlF = testV.frame;
 orgianlF.size.height = maxY + 10;
 testV.frame = orgianlF;
 }];
 

 */


@interface historyView : UIView

@property (strong, nonatomic) NSArray *titleArr;

@property (assign, nonatomic) NSInteger Font;
@property (assign, nonatomic) CGFloat TopMargin;
@property (assign, nonatomic) CGFloat RightMargin;
@property (assign, nonatomic) CGFloat BtnSMargin;
@property (assign, nonatomic) CGFloat BtnInnerMargin;
@property (assign, nonatomic) CGFloat BtnVMargin;

-(void)ConfigTitleArr:(NSArray*)titleArray CallBack:(void(^)(CGRect lastRect))cb;


@end

NS_ASSUME_NONNULL_END
