//
//  BaseWebViewController.m
//  JiMi
//
//  Created by YangTianCi on 2018/4/26.
//  Copyright © 2018年 www.JiMi.com. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@property (nonatomic, strong) WKWebView *MainWebView;

@property (nonatomic, strong) WKWebViewConfiguration *webCofig;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ConfigUI];
    
}

-(void)ConfigUI{
    [self.view addSubview:self.MainWebView];
}

-(void)ConfigRequestWithUrl:(NSString*)urlString WebContentType:(WebContentType)contentType Info:(id)info{
    if (contentType == WebContentType_Url) {
        [self.MainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }else if (contentType == WebContentType_HtmlString){
        [self.MainWebView loadHTMLString:urlString baseURL:nil];
    }else if (contentType == WebContentType_Data){
        [self.MainWebView loadFileURL:[NSURL URLWithString:urlString] allowingReadAccessToURL:[NSURL URLWithString:[NSBundle mainBundle].bundlePath]];
    }
}



#pragma mark >>>>>>>>>> 懒加载

-(WKWebView *)MainWebView{
    if (!_MainWebView) {
        _MainWebView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:self.webCofig];
    }
    return _MainWebView;
}

-(WKWebViewConfiguration *)webCofig{
    if (!_webCofig) {
        _webCofig = [[WKWebViewConfiguration alloc]init];
    }
    return _webCofig;
}




@end
