//
//  SKCalendarManage.h
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKCalendarManage : NSObject

+ (SKCalendarManage *)manage;

- (void)checkThisMonthRecordFromToday:(NSDate *)today;

@property (copy, nonatomic) NSMutableArray * canlendarDate;
@property (assign, nonatomic) BOOL isIncreaseHeight;// 是否增加日历高度


@end
