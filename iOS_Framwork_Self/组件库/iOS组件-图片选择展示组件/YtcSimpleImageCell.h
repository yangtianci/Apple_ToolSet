//
//  YtcSimpleImageCell.h
//  DemoView
//
//  Created by 杨天赐 on 2019/1/17.
//  Copyright © 2019 yangtianci. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, viewType) {
    viewType_imgV,
    viewType_btn
};

@interface YtcSimpleImageCell : UICollectionViewCell



// IsDelete 是否隐藏删除按钮

-(void)ConfigImg:(id)img Type:(viewType)type IsDelete:(BOOL)isdel Index:(NSIndexPath*)idx;


@property (copy, nonatomic) void(^imgClickCB)(NSInteger idx);

@property (copy, nonatomic) void(^delBtnCB)(NSInteger idx);

@property (copy, nonatomic) void(^addBtnCB)(NSInteger idx);


@end

NS_ASSUME_NONNULL_END
