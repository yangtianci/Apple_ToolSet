//
//  YtcSimpleInputView.h
//  DemoView
//
//  Created by 杨天赐 on 2019/1/17.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry.h>

NS_ASSUME_NONNULL_BEGIN



/**
	YtcSimpleInputView *view = [[YtcSimpleInputView alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 200)];
    [self.view addSubview:view];
 */


@interface YtcSimpleInputView : UIView

// ====================================================================

@property (copy, nonatomic) void(^masTextCallBack)(NSString *msg);

@property (copy, nonatomic) NSString *contentString;

// ====================================================================

@property (strong, nonatomic) UILabel *placeLab;

@property (strong, nonatomic) UILabel *countLab;

@property (assign, nonatomic) NSInteger maxCount;

@property (strong, nonatomic) UITextView *inputView;

@end

NS_ASSUME_NONNULL_END
