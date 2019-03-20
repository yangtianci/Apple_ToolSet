//
//  BaseWebViewController.h
//  JiMi
//
//  Created by YangTianCi on 2018/4/26.
//  Copyright © 2018年 www.JiMi.com. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSInteger, WebContentType){
    WebContentType_Url,
    WebContentType_HtmlString,
    WebContentType_Data
};

@interface BaseWebViewController : BaseViewController

-(void)ConfigRequestWithUrl:(NSString*)urlString WebContentType:(WebContentType)contentType Info:(id)info;

@end
