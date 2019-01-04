//
//  URL.h
//  JiMi
//
//  Created by YangTianCi on 2018/4/24.
//  Copyright © 2018年 www.JiMi.com. All rights reserved.
//

#ifndef URL_h
#define URL_h

# import <Foundation/Foundation.h>

#pragma mark - ---------- 协议(protocol) ----------
#if DEBUG
static NSString *const URL_PROTOCOL = @"http://";
#else
static NSString *const URL_PROTOCOL = @"http://";
#endif

#pragma mark - ---------- 地址(host) ----------
#if DEBUG
static NSString *const URL_HOST = @"www.baidu.com/";
#else
static NSString *const URL_HOST = @"www.baidu.com/";
#endif

#pragma mark - ---------- 端口(port) ----------
#if DEBUG
static NSString *const URL_PORT = @"8080";
#else
static NSString *const URL_PORT = @"8080";
#endif

#pragma mark - ---------- 路径(path) ----------
static NSString *const URL_PATH_PREFIX = @"";

#define Net_PATH(path) COMBIN(URL_PROTOCOL, URL_HOST, URL_PORT, URL_PATH_PREFIX, path)

#pragma mark - ======================== 模块 Path ========================

static NSString *const customPath_One = @"customPath_One";





#endif /* URL_h */
