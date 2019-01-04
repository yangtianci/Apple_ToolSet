//
//  PhotoManager_tc.h
//  SmallTool-CameraAndPhotoAlbum
//
//  Created by YangTianCi on 2018/1/11.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const ErrorMsg_TC = @"错误信息";

typedef NS_ENUM(NSInteger, ToolType) {
    ToolType_Photo,
    ToolType_Camera,
    ToolType_SavedPhotosAlbum
};

@interface PhotoManager_tc : NSObject

//创建对象
+(instancetype)manager;

//相册 / 拍照 接口
-(void)GetImageWithController:(UIViewController*)controller WithType:(ToolType)type;

//获取返回数据
@property (nonatomic,copy) void(^CallBack)(UIImage *img, NSDictionary *OtherInfo,NSDictionary *ErrorInfo);

// 是否允许裁剪
@property (nonatomic, assign) BOOL allowsEditing;

//压缩图片
-(UIImage*)CpmpressImgWithImg:(UIImage *)orginalImg CompressSize:(CGSize)size CompressScale:(CGFloat)scale;

//转Base64
-(NSString*)TransformImgToBase64StrWithImg:(UIImage*)orginal;



@end
