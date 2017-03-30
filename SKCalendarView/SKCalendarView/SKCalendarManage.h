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

@property (strong, nonatomic) NSMutableArray * calendarDate;// 公历
@property (strong, nonatomic) NSMutableArray * chineseCalendarDate;// 农历
@property (copy, nonatomic) NSArray * weekList;
@property (assign, nonatomic) BOOL isIncreaseHeight;// 是否增加日历高度
@property (assign, nonatomic) NSUInteger todayInMonth;// 今天在本月是第几天
@property (assign, nonatomic) NSUInteger month;// 当前月

@end
