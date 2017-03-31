//
//  SKCalendarAnimationManage.m
//  SKCalendarView
//
//  Created by shevchenko on 17/3/31.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKCalendarAnimationManage.h"

@implementation SKCalendarAnimationManage

+ (void)animationWithView:(UIView *)view andEffect:(SK_ANIMATION)effect isNext:(BOOL)next
{
    CATransition * transition = [CATransition animation];
    if (next == YES) {// 向下翻页
        switch (effect) {
            case SK_ANIMATION_REVEAL:
                transition.type = @"pageUnCurl";
                transition.subtype = kCATransitionFromLeft;
                break;
            case SK_ANIMATION_RIPPLE:
                transition.type = @"rippleEffect";
                transition.subtype = kCATransitionFromLeft;
                break;
            case SK_ANIMATION_SUCK:
                transition.type = @"suckEffect";
                transition.subtype = kCATransitionFromLeft;
                break;
        }
    } else {
        switch (effect) {
            case SK_ANIMATION_REVEAL:
                transition.type = @"pageCurl";
                transition.subtype = kCATransitionFromLeft;
                
                break;
            case SK_ANIMATION_RIPPLE:
                transition.type = @"rippleEffect";
                transition.subtype = kCATransitionFromRight;
                break;
            case SK_ANIMATION_SUCK:
                transition.type = @"suckEffect";
                transition.subtype = kCATransitionFromRight;
                break;
        }
    }
    transition.duration = 0.5;
    [view.layer addAnimation:transition forKey:nil];
    
}

+ (void)clickEffectAnimationForView:(UIView *)view
{
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.3];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.7];
    scaleAnimation.duration = 0.1;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:scaleAnimation forKey:nil];
}

@end
