//
//  UIView+Extension.h
// 
//
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//宽高位置大小
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

//中心点的x与y
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


@end
