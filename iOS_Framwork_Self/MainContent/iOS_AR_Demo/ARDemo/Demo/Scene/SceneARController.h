//
//  SceneARController.h
//  ARDemo
//
//  Created by YangTianCi on 2018/2/28.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, Sytle){
    
    Style_planeHoriz,
    Style_rotato
    
};

@interface SceneARController : UIViewController


@property (nonatomic, assign) Style style;

@end
