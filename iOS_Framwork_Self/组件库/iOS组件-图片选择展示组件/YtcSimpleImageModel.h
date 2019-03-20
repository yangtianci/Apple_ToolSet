//
//  YtcSimpleImageModel.h
//  CountryYard
//
//  Created by 杨天赐 on 2019/1/21.
//  Copyright © 2019 tidoo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSInteger, mdType){
    
    mdType_img,
    mdType_video,
    mdType_url
    
};


@interface YtcSimpleImageModel : NSObject

// 对象类型
@property (assign, nonatomic) mdType obj_Type;

@property (strong, nonatomic) UIImage *img;

@property (strong, nonatomic) NSURL *video;
@property (strong, nonatomic) UIImage *videoImg;

@property (strong, nonatomic) NSString *url;

@end

NS_ASSUME_NONNULL_END
