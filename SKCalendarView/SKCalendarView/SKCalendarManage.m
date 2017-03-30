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
@property (assign, nonatomic) NSUInteger days;// 本月天数
@property (assign, nonatomic) NSUInteger dayInWeek;// 本月第一天是周几
@property (assign, nonatomic) NSUInteger year;// 年
@property (assign, nonatomic) NSUInteger month;// 月
@property (assign, nonatomic) NSUInteger day;// 日


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
        [manageSinglenton creatcalendarArray];
        [manageSinglenton getWeekString];
        [manageSinglenton calculationChinaCalendarWithDate:nil];
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
    [self calculationChinaCalendarWithDate:today];
    [self creatcalendarArray];
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
    NSUInteger day = [comps day];// 是本月第几天
    self.todayInMonth = day;
    if (day > 1) {// 如果不是本月第一天
        // 将日期推算到本月第一天
        NSInteger hours = (day - 1) * -24;
        date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:date];
    }
    
    comps = [calendar components:unitFlags fromDate:date];
    self.dayInWeek = [comps weekday];// 是周几
    self.year = [comps year];
    self.month = [comps month];
    self.day = [comps day];
}

#pragma mark - 创建日历数组
- (void)creatcalendarArray
{
    self.calendarDate = [NSMutableArray new];
    self.chineseCalendarDate = [NSMutableArray new];
    for (NSInteger j = 0; j < 42; j ++) {// 创建空占位数组
        [self.calendarDate addObject:@""];
        [self.chineseCalendarDate addObject:@""];
    }
    // 向前推算日期到本月第一天
    NSInteger hours = (self.todayInMonth - 1) * -24;
    NSDate * firstDay = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:[NSDate date]];
    if (self.todayInMonth > 1) {
        self.todayInMonth = self.todayInMonth + self.dayInWeek - 2;// 计算在本月日历上所处的位置
    }
    switch (self.dayInWeek) {// 根据本月第一天是周几，来确定之后的日期替换空占位
        case 1:// 周日
            for (NSInteger i = 1; i <= self.days; i ++) {
                [self.calendarDate replaceObjectAtIndex:i - 1 withObject:@(i)];// 替换公历日期
                for (NSInteger j = 1; j <= self.days; j ++) {
                    // 向后推算至本月末
                    NSInteger hours = (j - 1) * 24;
                    NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:firstDay];
                    NSString * chineseDay = [self calculationChinaCalendarWithDate:date];
                    [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 2:// 周一
            for (NSInteger i = 1; i <= self.days + 1; i ++) {
                if (i >= 2) {
                    [self.calendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 1)];
                    for (NSInteger j = 1; j <= self.days + 1; j ++) {
                        if (j >= 2) {
                            // 向后推算至本月末
                            NSInteger hours = (j - 2) * 24;
                            NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:firstDay];
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                        }
                    }

                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 3:// 周二
            for (NSInteger i = 1; i <= self.days + 2; i ++) {
                if (i >= 3) {
                    [self.calendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 2)];
                    for (NSInteger j = 1; j <= self.days + 2; j ++) {
                        if (j >= 3) {
                            // 向后推算至本月末
                            NSInteger hours = (j - 3) * 24;
                            NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:firstDay];
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                        }
                    }

                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 4:// 周三
            for (NSInteger i = 1; i <= self.days + 3; i ++) {
                if (i >= 4) {
                    [self.calendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 3)];
                    for (NSInteger j = 1; j <= self.days + 3; j ++) {
                        if (j >= 4) {
                            // 向后推算至本月末
                            NSInteger hours = (j - 4) * 24;
                            NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:firstDay];
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                        }
                    }

                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 5:// 周四
            for (NSInteger i = 1; i <= self.days + 4; i ++) {
                if (i >= 5) {
                    [self.calendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 4)];
                    for (NSInteger j = 1; j <= self.days + 4; j ++) {
                        if (j >= 5) {
                            // 向后推算至本月末
                            NSInteger hours = (j - 5) * 24;
                            NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:firstDay];
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                        }
                    }

                }
            }
            self.isIncreaseHeight = NO;
            break;
            
        case 6:// 周五
            for (NSInteger i = 1; i <= self.days + 5; i ++) {
                if (i >= 6) {
                    [self.calendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 5)];
                    for (NSInteger j = 1; j <= self.days + 5; j ++) {
                        if (j >= 6) {
                            // 向后推算至本月末
                            NSInteger hours = (j - 6) * 24;
                            NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:firstDay];
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                        }
                    }

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
                    [self.calendarDate replaceObjectAtIndex:i - 1 withObject:@(i - 6)];
                    for (NSInteger j = 1; j <= self.days + 6; j ++) {
                        if (j >= 7) {
                            // 向后推算至本月末
                            NSInteger hours = (j - 7) * 24;
                            NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:firstDay];
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                        }
                    }

                }
            }
            self.isIncreaseHeight = YES;
            break;
    }
}

#pragma mark - 获取周
- (void)getWeekString
{
    self.weekList = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
}

#pragma mark - 计算农历日期
- (NSString *)calculationChinaCalendarWithDate:(NSDate *)date
{
    if (isEmpty(date)) {
        return nil;
    }
    NSArray * chineseMonths = @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                                @"九月", @"十月", @"冬月", @"腊月"];
    NSArray * chineseDays = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"廿十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
    
    NSCalendar * localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents * localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString * m_str = [chineseMonths objectAtIndex:localeComp.month - 1];
    NSString * d_str = [chineseDays objectAtIndex:localeComp.day - 1];

    NSString * chineseCal_str = d_str;
    NSString * solarTermsDay = [self calculationSolarTermsWithYear:2017 solarTermsIndex:2];
    if([chineseMonths containsObject:m_str] && [d_str isEqualToString:@"初一"]) {
        chineseCal_str = m_str;
        if ([m_str isEqualToString:@"正月"] && [d_str isEqualToString:@"初一"]) {
            chineseCal_str = @"春节";
        } else{
            chineseCal_str = @"初一";
        }
    } else if ([m_str isEqualToString:@"正月"] && [d_str isEqualToString:@"十五"]) {
        chineseCal_str = @"元宵节";
    } else if ([m_str isEqualToString:@"五月"] && [d_str isEqualToString:@"初五"]) {
        chineseCal_str = @"端午节";
    } else if ([m_str isEqualToString:@"八月"] && [d_str isEqualToString:@"十五"]) {
        chineseCal_str = @"中秋节";
    } else if ([m_str isEqualToString:@"九月"] && [d_str isEqualToString:@"初九"]) {
        chineseCal_str = @"重阳节";
    } else if ([m_str isEqualToString:@"腊月"] && [d_str isEqualToString:@"初八"]) {
        chineseCal_str = @"腊八节";
    } else if ([m_str isEqualToString:@"腊月"] && [d_str isEqualToString:@"廿三"]) {
        chineseCal_str = @"小年";
    } else if ([m_str isEqualToString:@"腊月"] && [d_str isEqualToString:@"三十"]) {
        chineseCal_str = @"除夕";
    }
    NSDictionary * Holidays = @{@"01-01":@"元旦",
                               @"02-14":@"情人节",
                               @"03-08":@"妇女节",
                               @"03-12":@"植树节",
                               @"05-01":@"劳动节",
                               @"05-04":@"青年节",
                               @"06-01":@"儿童节",
                               @"07-01":@"建党节",
                               @"08-01":@"建军节",
                               @"09-10":@"教师节",
                               @"10-01":@"国庆节",
                               @"12-24":@"平安夜",
                               @"12-25":@"圣诞节"};
    
    NSDateFormatter * dateFormatt= [[NSDateFormatter alloc] init];
    dateFormatt.dateFormat = @"MM-dd";
    NSString * nowStr = [dateFormatt stringFromDate:date];
    
    NSArray * array = [Holidays allKeys];
    if([array containsObject:nowStr]) {
        chineseCal_str = [Holidays objectForKey:nowStr];
    }
    return chineseCal_str;
}

#pragma mark - 计算二十四节气的具体日期
/**
 * @param year 年份
 * @param index 节气索引，0代表小寒，1代表大寒，其它节气按照顺序类推
 */
- (NSString *)calculationSolarTermsWithYear:(NSUInteger)year solarTermsIndex:(NSUInteger)index
{
    NSString * solarTerms = @"";
    CGFloat base = 365.242 * (year - 1900) + 6.2 + (15.22 * index) - (1.9 * sinf(0.262 * index));// 计算积日
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate * baseDate = [dateFormatter dateFromString:@"1900-1-1"];
    NSInteger hours = (base - 1) * 24;// 由于基准日为1900年1月0日，所以这里需要-1
    NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:baseDate];
   
    
    return solarTerms;
}

@end
