//
//  SKDateSecurity.h
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKDateSecurity : NSObject

/** 判断给定对象是否为空
 *
 * @param string 对象
 * @return 是否为空
 *
 */
+ (BOOL)isNilOrEmpty:(id)string;


/** 将给定对象转换为字符串
 *
 * @param obj 对象
 * @return 字符串
 *
 */
+ (NSString *)getNoneNilString:(id)obj;


@end
