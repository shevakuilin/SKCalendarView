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
@property (strong, nonatomic) NSMutableArray * chineseCalendarDate;// 农历日期&节日&节气
@property (strong, nonatomic) NSMutableArray * chineseCalendarDay;// 农历纯日期(不包含节日和节气)
@property (copy, nonatomic) NSArray * weekList;
@property (assign, nonatomic) BOOL isIncreaseHeight;// 是否增加日历高度
@property (assign, nonatomic) NSUInteger days;// 本月天数
@property (assign, nonatomic) NSInteger todayInMonth;// 今天在本月是第几天
@property (assign, nonatomic) NSUInteger dayInWeek;// 本月第一天是周几, 1为周日，以此类推
@property (assign, nonatomic) NSUInteger year;// 当前年
@property (assign, nonatomic) NSUInteger month;// 当前月
@property (assign, nonatomic) NSUInteger theMonth;// 本月
@property (strong, nonatomic) NSString * chineseYear;// 农历年
@property (strong, nonatomic) NSString * chineseMonth;// 农历月

@end
