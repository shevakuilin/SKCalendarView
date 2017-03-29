//
//  SKCalendarManage.m
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKCalendarManage.h"
#import "SKConstant.h"

@interface SKCalendarManage ()
@property (assign, nonatomic) NSUInteger days;
@property (assign, nonatomic) NSUInteger dayInWeek;

@end

@implementation SKCalendarManage

+ (SKCalendarManage *)manage
{
    static SKCalendarManage * manageSinglenton = nil;
    static dispatch_once_t onceCalendar;
    dispatch_once(&onceCalendar, ^{
        manageSinglenton = [[self alloc] init];
        [manageSinglenton calculationThisMonthDays:nil];
        [manageSinglenton calculationThisMonthFirstDayInWeek:nil];
        [manageSinglenton creatCanlendarArray];

    });
    
    return manageSinglenton;
}

#pragma mark - 查看所选日期所处的月份
- (void)checkThisMonthRecordFromToday:(NSDate *)today
{
    if (isEmpty(today)) {
        today = [NSDate date];
    }
    [self calculationThisMonthDays:today];
    [self calculationThisMonthFirstDayInWeek:today];
    [self creatCanlendarArray];
}

#pragma mark - 计算本月天数
- (void)calculationThisMonthDays:(NSDate *)days
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    if (isEmpty(days)) {
        days = [NSDate date];
    }
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:days];
    self.days = range.length;
}

#pragma mark - 计算本月第一天是周几
- (void)calculationThisMonthFirstDayInWeek:(NSDate *)date;
{
    if (isEmpty(date)) {
        date = [NSDate date];
    }
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
    comps = [calendar components:unitFlags fromDate:date];
    NSUInteger day = [comps day];
    if (day > 1) {// 如果不是本月第一天
        NSInteger hours = (day - 1) * -24;
        date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:date];
    }
    
    comps = [calendar components:unitFlags fromDate:date];
    self.dayInWeek = [comps weekday];
}

#pragma mark - 创建日历数组
- (void)creatCanlendarArray
{
    self.canlendarDate = [NSMutableArray new];
    for (NSInteger j = 0; j < 42; j ++) {
        [self.canlendarDate addObject:@""];
    }
    
    switch (self.dayInWeek) {
        case 1:// 周日
            for (NSInteger i = 1; i <= self.days; i ++) {
                [self.canlendarDate replaceObjectAtIndex:i - 1 withObject:@(i)];
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 2:// 周一
            for (NSInteger i = 1; i <= self.days + 1; i ++) {
                if (i >= 2) {
                    [self.canlendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 1)];
                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 3:// 周二
            for (NSInteger i = 1; i <= self.days + 2; i ++) {
                if (i >= 3) {
                    [self.canlendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 2)];
                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 4:// 周三
            for (NSInteger i = 1; i <= self.days + 3; i ++) {
                if (i >= 4) {
                    [self.canlendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 3)];
                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 5:// 周四
            for (NSInteger i = 1; i <= self.days + 4; i ++) {
                if (i >= 5) {
                    [self.canlendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 4)];
                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 6:// 周五
            for (NSInteger i = 1; i <= self.days + 5; i ++) {
                if (i >= 6) {
                    [self.canlendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 5)];
                }
            }
            if (self.days == 31) {// 是否为大月
                self.isIncreaseHeight = YES;
            } else {
                self.isIncreaseHeight = NO;
            }
            break;
            
        case 7:// 周六
            for (NSInteger i = 1; i <= self.days + 6; i ++) {
                if (i >= 7) {
                    [self.canlendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 6)];
                }
            }
            self.isIncreaseHeight = YES;
            break;
            
    }
    
}


@end
