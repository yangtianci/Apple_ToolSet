//
//  SmallTableView.h
//  TableView嵌套(纯净版)&分页控制器
//
//  Created by YangTianCi on 2018/1/7.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallTableView : UIView

@property (nonatomic,assign) BOOL CanScroll_Small;
@property (nonatomic,assign) CGPoint OffsetPoint;
@property (nonatomic,assign) BOOL Refresh;

@end
