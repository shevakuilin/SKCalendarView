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

@property (nonatomic, strong) NSMutableArray * calendarDate;// 公历
@property (nonatomic, strong) NSMutableArray * chineseCalendarDate;// 农历日期&节日&节气
@property (nonatomic, strong) NSMutableArray * chineseCalendarDay;// 农历纯日期(不包含节日和节气)
@property (nonatomic, strong) NSMutableArray * chineseCalendarMonth;// 农历月份
@property (nonatomic, copy) NSArray * weekList;
@property (nonatomic, assign) BOOL isIncreaseHeight;// 是否增加日历高度
@property (nonatomic, assign) NSUInteger days;// 本月天数
@property (nonatomic, assign) NSInteger todayInMonth;// 今天在本月是第几天
@property (nonatomic, assign) NSUInteger dayInWeek;// 本月第一天是周几, 1为周日，以此类推
@property (nonatomic, assign) NSUInteger year;// 当前年
@property (nonatomic, assign) NSUInteger month;// 当前月
@property (nonatomic, assign) NSUInteger theMonth;// 本月
@property (nonatomic, copy) NSString * chineseYear;// 农历年
@property (nonatomic, assign) NSUInteger todayPosition;// 今天在所属月份中所处位置

@end
