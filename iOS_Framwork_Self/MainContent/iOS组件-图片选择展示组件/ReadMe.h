

希望同时选择视频的添加方式

如果要选择视频, 则同时修改 PhptoManager 以及使用 YtcSimpleImageModel 类作为数据传输模型

同时修改 cell 内部对 img 的处理方法

// ==================================================================== cell 内解析模型的方法

YtcSimpleImageModel *md = (YtcSimpleImageModel*)img;
if (md.obj_Type == mdType_img) {
    self.imgV.image = md.img;
}else if (md.obj_Type == mdType_video){
    self.imgV.image = md.videoImg;
}else if (md.obj_Type == mdType_url){
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:md.url]];
}else{
    NSLog(@"未添加类型, 不予处理");
}


// ==================================================================== PhotoManager 的处理

self.photoManager.CallBack = ^(UIImage *img) {
    
    // ====================================================================
    
    YtcSimpleImageModel *md = [[YtcSimpleImageModel alloc]init];
    
    if ([img isKindOfClass:[NSString class]] || [img isKindOfClass:[NSURL class]]) {
        md.obj_Type = mdType_video;
        md.video = (NSURL*)img;
        md.videoImg = [CFXCPPublishController getThumbnailImageFromFilePath:md.video.absoluteString time:1];
    }else{
        md.obj_Type = mdType_img;
        md.img = img;
    }
    
    // ====================================================================
    
    [WS.imgArr addObject:md];
    
    [WS.imgsView ConfigImgArr:WS.imgArr CallBack:^(CGRect bunce) {
        
        CGFloat tH = bunce.size.height;
        WS.imgVMas.constant = tH;
        [WS.view setNeedsLayout];
        [WS.view layoutIfNeeded];
        
    }];
    
};

// ==================================================================== VC 获取视频缩略图的方法

//获取本地视频缩略图
+ (UIImage *)getThumbnailImageFromFilePath:(NSString *)videoPath time:(NSTimeInterval )videoTime {
    
    if (!videoPath) {
        return nil;
    }
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:videoPath] options:nil];
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 1;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 600)
                                                    actualTime:NULL error:nil];
    
    
    if (!thumbnailImageRef) {
        return nil;
    }
    
    UIImage *thumbnailImage = [[UIImage alloc] initWithCGImage:thumbnailImageRef];
    
    CFRelease(thumbnailImageRef);
    
    return thumbnailImage;
    
}



