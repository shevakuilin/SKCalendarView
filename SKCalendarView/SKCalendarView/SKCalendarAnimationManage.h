//
//  SKCalendarAnimationManage.h
//  SKCalendarView
//
//  Created by shevchenko on 17/3/31.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SK_ANIMATION) {
    SK_ANIMATION_REVEAL,// 翻页效果
    SK_ANIMATION_RIPPLE,// 波纹效果
    SK_ANIMATION_SUCK// 吸收效果
};

@interface SKCalendarAnimationManage : NSObject

/** 动画效果
 * @param view 执行动画的view
 * @param effect 动画效果
 * @param next 查看下个月
 */
+ (void)animationWithView:(UIView *)view andEffect:(SK_ANIMATION)effect isNext:(BOOL)next;

/** 点击效果
 * @param view 执行动画的view
 */
+ (void)clickEffectAnimationForView:(UIView *)view;


@end
