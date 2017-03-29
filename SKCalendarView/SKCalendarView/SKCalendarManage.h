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

@property (strong, nonatomic) NSMutableArray * calendarDate;
@property (copy, nonatomic) NSArray * weekList;
@property (assign, nonatomic) BOOL isIncreaseHeight;// 是否增加日历高度
@property (assign, nonatomic) NSUInteger todayInMonth;// 今天在本月所处位置

@end
