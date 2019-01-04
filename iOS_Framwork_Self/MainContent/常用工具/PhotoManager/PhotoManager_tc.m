//
//  PhotoManager_tc.m
//  SmallTool-CameraAndPhotoAlbum
//
//  Created by YangTianCi on 2018/1/11.
//  Copyright © 2018年 ytc. All rights reserved.
//

#import "PhotoManager_tc.h"

@interface PhotoManager_tc()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImagePickerController *picker;
@property (nonatomic,strong) UIImage *selectImg;
@property (nonatomic,strong) NSMutableArray *selectImgArr;
@property (nonatomic,assign) ToolType type;


@end

@implementation PhotoManager_tc

+(instancetype)manager{
    static id manager = nil;
    static dispatch_once_t PhotoToken;
    dispatch_once(&PhotoToken, ^{
        manager = [[PhotoManager_tc alloc]init];
    });
    return manager;
}

//相册 / 拍照 接口
-(void)GetImageWithController:(UIViewController*)controller WithType:(ToolType)type{
    
    _picker = [[UIImagePickerController alloc]init];
    _picker.allowsEditing = self.allowsEditing;
    _picker.delegate = self;
    
    _type = type;
    
    NSMutableDictionary *errInfo = [NSMutableDictionary dictionary];
    if (![UIImagePickerController availableMediaTypesForSourceType:(UIImagePickerControllerSourceType)type]) {
        [errInfo setObject:@"所选媒体类型不可用" forKey:ErrorMsg_TC];
        self.CallBack(nil, nil, errInfo);
        return;
    }
    
    if (type == ToolType_Photo) {
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else if(type == ToolType_Camera){
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        _picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [controller presentViewController:_picker animated:YES completion:^{
    }];
    
}

//压缩图片
-(UIImage*)CpmpressImgWithImg:(UIImage *)orginalImg CompressSize:(CGSize)size CompressScale:(CGFloat)scale{
    UIImage *OnceImg = [self CompressVolumeWithImg:orginalImg Scale:scale];
    UIImage *TwoImg;
    if (size.width == 0 && size.height == 0) {
        return OnceImg;
    }else{
        TwoImg = [self CompressSizeWithImg:OnceImg Size:size];
        return TwoImg;
    }
    return OnceImg;
    
}
//尺寸压缩
-(UIImage*)CompressSizeWithImg:(UIImage*)orginalImg Size:(CGSize)size{
    if (size.width > 0 && size.height > 0) {
        UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
        [orginalImg drawInRect:CGRectMake(0,0,size.width,  size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }else{
        return orginalImg;
    }
}
//质量压缩
-(UIImage*)CompressVolumeWithImg:(UIImage*)orginalImg Scale:(CGFloat)scale{
    if (scale > 0) {
        NSData *data = UIImageJPEGRepresentation(orginalImg, scale);
        UIImage *newImg = [UIImage imageWithData:data];
        return newImg;
    }else{
        return orginalImg;
    }
}

//转Base64
-(NSString*)TransformImgToBase64StrWithImg:(UIImage*)orginal{
    NSData *data = UIImagePNGRepresentation(orginal);
    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return str;
}

//保存本地文件
-(void)SaveImgToLocalPhotoLibiaryWithImg:(UIImage*)img{
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    NSLog(@"%@",msg);
}

#pragma mark === 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *orgianlImg;
    if (self.allowsEditing) {
        orgianlImg = info[@"UIImagePickerControllerEditedImage"];
    }else{
        orgianlImg = info[@"UIImagePickerControllerOriginalImage"];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (self.CallBack) {
        self.CallBack(orgianlImg, nil, nil);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
