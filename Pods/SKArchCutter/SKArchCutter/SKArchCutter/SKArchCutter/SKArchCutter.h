//
//  SKArchCutter.h
//  SKArchCutter
//
//  Created by shevchenko on 17/3/28.
//  Copyright © 2017年 shevchenko. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SKArchCutter : NSObject
/**
 * @param object 需要进行切割的对象
 * @param direction 切割的方向
 * @param cornerRadii 圆角半径
 */
- (void)cuttingWithObject:(id)object direction:(UIRectCorner)direction cornerRadii:(CGFloat)cornerRadii;

@end
