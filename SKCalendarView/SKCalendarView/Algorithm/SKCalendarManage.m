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
@property (nonatomic, strong) NSDateFormatter * dateFormatter;
@property (nonatomic, strong) NSDateFormatter * strDateFormatter;
@property (nonatomic, strong) NSDate * baseDate;

@end

@implementation SKCalendarManage

+ (SKCalendarManage *)manage
{
    static SKCalendarManage * manageSinglenton = nil;
    static dispatch_once_t onceCalendar;
    dispatch_once(&onceCalendar, ^{
        manageSinglenton = [[self alloc] init];
        [manageSinglenton getWeekString];
    });
    
    return manageSinglenton;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormatter;
}

- (NSDateFormatter *)strDateFormatter
{
    if (!_strDateFormatter) {
        _strDateFormatter = [[NSDateFormatter alloc] init];
        [_strDateFormatter setDateFormat:@"MM-dd"];
    }
    return _strDateFormatter;
}

- (NSDate *)baseDate
{
    if (!_baseDate) {
        _baseDate = [self.dateFormatter dateFromString:@"1900-1-1"];
    }
    return _baseDate;
}

#pragma mark - 查看所选日期所处的月份
- (void)checkThisMonthRecordFromToday:(NSDate *)today
{
    if (isEmpty(today)) {
        today = [NSDate date];
    }
    
    [self calculationThisMonthDays:today];
    [self calculationThisMonthFirstDayInWeek:today];
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
    NSDateComponents * theComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
    comps = [calendar components:unitFlags fromDate:date];
    theComps = [calendar components:unitFlags fromDate:[NSDate date]];
    self.theMonth = [theComps month];// 本月的月份
    NSUInteger day = [comps day];// 是本月第几天
    self.todayInMonth = day;
    if (day > 1) {// 如果不是本月第一天
        // 将日期推算到本月第一天
        NSInteger hours = (day - 1) * -24;
        date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:date];
    }
    comps = [calendar components:unitFlags fromDate:date];
    self.dayInWeek = [comps weekday];// 是周几
    self.year = [comps year];// 公历年
    self.month = [comps month];// 公里月

    [self creatcalendarArrayWithDate:date];
}

#pragma mark - 创建日历数组
- (void)creatcalendarArrayWithDate:(NSDate *)date
{
    self.calendarDate = [NSMutableArray new];
    self.chineseCalendarDate = [NSMutableArray new];
    self.chineseCalendarDay = [NSMutableArray new];
    for (NSInteger j = 0; j < 42; j ++) {// 创建空占位数组
        [self.calendarDate addObject:@""];
        [self.chineseCalendarDate addObject:@""];
        [self.chineseCalendarDay addObject:@""];
    }
    // 向前推算日期到本月第一天
    NSDate * firstDay = date;
    self.todayInMonth = self.todayInMonth + self.dayInWeek - 2;// 计算在本月日历上所处的位置
    switch (self.dayInWeek) {// 根据本月第一天是周几，来确定之后的日期替换空占位
        case 1:// 周日
            for (NSInteger i = 1; i <= self.days; i ++) {
                [self.calendarDate replaceObjectAtIndex:i - 1 withObject:@(i)];// 替换公历日期
                for (NSInteger j = 1; j <= self.days; j ++) {// 公历日期
                    // 向后推算至本月末
                    NSInteger hours = (j - 1) * 24;
                    NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:firstDay];
                    NSString * chineseDay = [self calculationChinaCalendarWithDate:date dispalyHoliday:YES];
                    [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                    NSString * noHoliday = [self calculationChinaCalendarWithDate:date dispalyHoliday:NO];
                    [self.chineseCalendarDay replaceObjectAtIndex:j - 1 withObject:noHoliday];
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
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date dispalyHoliday:YES];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                            NSString * noHoliday = [self calculationChinaCalendarWithDate:date dispalyHoliday:NO];
                            [self.chineseCalendarDay replaceObjectAtIndex:j - 1 withObject:noHoliday];
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
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date dispalyHoliday:YES];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                            NSString * noHoliday = [self calculationChinaCalendarWithDate:date dispalyHoliday:NO];
                            [self.chineseCalendarDay replaceObjectAtIndex:j - 1 withObject:noHoliday];
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
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date dispalyHoliday:YES];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                            NSString * noHoliday = [self calculationChinaCalendarWithDate:date dispalyHoliday:NO];
                            [self.chineseCalendarDay replaceObjectAtIndex:j - 1 withObject:noHoliday];
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
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date dispalyHoliday:YES];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                            NSString * noHoliday = [self calculationChinaCalendarWithDate:date dispalyHoliday:NO];
                            [self.chineseCalendarDay replaceObjectAtIndex:j - 1 withObject:noHoliday];
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
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date dispalyHoliday:YES];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                            NSString * noHoliday = [self calculationChinaCalendarWithDate:date dispalyHoliday:NO];
                            [self.chineseCalendarDay replaceObjectAtIndex:j - 1 withObject:noHoliday];
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
                            NSString * chineseDay = [self calculationChinaCalendarWithDate:date dispalyHoliday:YES];
                            [self.chineseCalendarDate replaceObjectAtIndex:j - 1 withObject:chineseDay];// 替换农历日期
                            NSString * noHoliday = [self calculationChinaCalendarWithDate:date dispalyHoliday:NO];
                            [self.chineseCalendarDay replaceObjectAtIndex:j - 1 withObject:noHoliday];
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
- (NSString *)calculationChinaCalendarWithDate:(NSDate *)date dispalyHoliday:(BOOL)display
{
    if (isEmpty(date)) {
        return nil;
    }
    NSArray * chineseYears = @[@"甲子", @"乙丑", @"丙寅", @"丁卯", @"戊辰", @"己巳", @"庚午", @"辛未", @"壬申", @"癸酉", @"甲戌", @"乙亥", @"丙子", @"丁丑", @"戊寅", @"己卯", @"庚辰", @"辛己", @"壬午", @"癸未", @"甲申", @"乙酉", @"丙戌", @"丁亥", @"戊子", @"己丑", @"庚寅", @"辛卯", @"壬辰", @"癸巳", @"甲午", @"乙未", @"丙申", @"丁酉", @"戊戌", @"己亥", @"庚子", @"辛丑", @"壬寅", @"癸丑", @"甲辰", @"乙巳", @"丙午", @"丁未", @"戊申", @"己酉", @"庚戌", @"辛亥", @"壬子", @"癸丑", @"甲寅", @"乙卯", @"丙辰", @"丁巳", @"戊午", @"己未", @"庚申", @"辛酉", @"壬戌", @"癸亥"];
    NSArray * chineseMonths = @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                                @"九月", @"十月", @"冬月", @"腊月"];
    NSArray * chineseDays = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"廿十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
    
    NSCalendar * localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents * localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    self.chineseYear = [chineseYears objectAtIndex:localeComp.year - 1];
    NSString * m_str = [chineseMonths objectAtIndex:localeComp.month - 1];
    self.chineseMonth = m_str;
    NSString * d_str = [chineseDays objectAtIndex:localeComp.day - 1];

    NSString * chineseCal_str = d_str;
    
    // 农历节日
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
    } else if ([m_str isEqualToString:@"七月"] && [d_str isEqualToString:@"初七"]) {
        chineseCal_str = @"七夕";
    } else if ([m_str isEqualToString:@"七月"] && [d_str isEqualToString:@"十五"]) {
        chineseCal_str = @"中元节";
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
    // 公历节日
    NSDictionary * Holidays = @{@"01-01":@"元旦",
                                @"02-14":@"情人节",
                                @"03-08":@"妇女节",
                                @"03-12":@"植树节",
                                @"04-01":@"愚人节",
                                @"05-01":@"劳动节",
                                @"05-04":@"青年节",
                                @"06-01":@"儿童节",
                                @"07-01":@"建党节",
                                @"08-01":@"建军节",
                                @"09-10":@"教师节",
                                @"10-01":@"国庆节",
                                @"12-24":@"平安夜",
                                @"12-25":@"圣诞节"};
    
//    NSDateFormatter * dateFormatt= [[NSDateFormatter alloc] init];
//    [dateFormatt setDateFormat:@"MM-dd"];
    NSString * nowStr = [self.strDateFormatter stringFromDate:date];
    // 复活节, Meeus/Jones/Butcher算法
    NSUInteger a = self.year % 19;
    NSUInteger b = self.year / 100;
    NSUInteger c = self.year % 100;
    NSUInteger d = b / 4;
    NSUInteger e = b % 4;
    NSUInteger f = (b + 8) / 25;
    NSUInteger g = (b - f + 1) / 3;
    NSUInteger h = (19 * a + b - d - g + 15) % 30;
    NSUInteger i = c / 4;
    NSUInteger k = c % 4;
    NSUInteger l = (32 + (2 * e) + (2 * i) - h - k) % 7;
    NSUInteger m = (a + (11 * h) + (22 * l)) / 451;
    NSUInteger theMonth = (h + l - (7 * m) + 114) / 31;
    NSUInteger day = ((h + l - (7 * m) + 114) % 31)+ 1;
    NSString * easter = [NSString stringWithFormat:@"0%@-%@", @(theMonth), @(day)];
    if ([easter isEqualToString:nowStr]) {
        chineseCal_str = @"复活节";
    }
    
    NSArray * array = [Holidays allKeys];
    if([array containsObject:nowStr]) {
        chineseCal_str = [Holidays objectForKey:nowStr];
    }
    
    // 公历礼拜节日
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    NSInteger unit = NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
    comps = [calendar components:unit fromDate:date];
    NSUInteger month = [comps month];
    NSUInteger dayInMonth = [comps day];
    switch (month) {
        case 5:
            if (dayInMonth == 14) {
                chineseCal_str = @"母亲节";
            }
            break;
        case 6:
            if (dayInMonth == 21) {
                chineseCal_str = @"父亲节";
            }
            break;
        case 11:
            if (dayInMonth == 26) {
                chineseCal_str = @"感恩节";
            }
            break;

            
        default:
            break;
    }
    
    // 二十四节气, 将节气按月份拆开计算，否则由于计算积日所需日期转换stringFromDate方法过于耗时将会造成线程卡顿
    NSString * solarTerms = @"";
    switch (self.month) {// 过滤月份
        case 1:
            for (NSInteger i = 0; i < 2; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 0:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"小寒";
                        }
                        break;
                    case 1:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"大寒";
                        }
                        break;
                }
            }
            break;
        case 2:
            for (NSInteger i = 2; i < 4; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 2:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"立春";
                        }
                        break;
                    case 3:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"雨水";
                        }
                        break;
                }
            }
            break;
        case 3:
            for (NSInteger i = 4; i < 6; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 4:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"惊蛰";
                        }
                        break;
                    case 5:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"春分";
                        }
                        break;
                }
            }
            break;
        case 4:
            for (NSInteger i = 6; i < 8; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 6:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"清明";
                        }
                        break;
                    case 7:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"谷雨";
                        }
                        break;
                }
            }
            break;
        case 5:
            for (NSInteger i = 8; i < 10; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 8:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"立夏";
                        }
                        break;
                    case 9:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"小满";
                        }
                        break;
                }
            }
            break;
        case 6:
            for (NSInteger i = 10; i < 12; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 10:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"芒种";
                        }
                        break;
                    case 11:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"夏至";
                        }
                }
            }
            break;
        case 7:
            for (NSInteger i = 12; i < 14; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 12:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"小暑";
                        }
                        break;
                    case 13:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"大暑";
                        }
                    break;                }
            }
            break;
        case 8:
            for (NSInteger i = 14; i < 16; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 14:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"立秋";
                        }
                        break;
                    case 15:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"处暑";
                        }
                        break;
                }
            }
            break;
        case 9:
            for (NSInteger i = 16; i < 18; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 16:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"白露";
                        }
                        break;
                    case 17:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"秋分";
                        }
                        break;
                }
            }
            break;
        case 10:
            for (NSInteger i = 18; i < 20; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 18:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"寒露";
                        }
                        break;
                    case 19:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"霜降";
                        }
                        break;
                }
            }
            break;
        case 11:
            for (NSInteger i = 20; i < 22; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 20:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"立冬";
                        }
                        break;
                    case 21:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"小雪";
                        }
                    break;
                }
            }
            break;
        case 12:
            for (NSInteger i = 22; i < 24; i ++) {
                solarTerms = [self calculationSolarTermsWithYear:self.year solarTermsIndex:i];
                switch (i) {
                    case 22:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"大雪";
                        }
                        break;
                    case 23:
                        if ([solarTerms isEqualToString:nowStr]) {
                            chineseCal_str = @"冬至";
                        }
                        break;
                }
            }
            break;
    }
    
    if (display == YES) {// 需要显示假期&节日
        return chineseCal_str;
    }
    return d_str;
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
    NSInteger hours = (base - 1) * 24;// 由于基准日为1900年1月0日，所以这里需要-1
    NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:self.baseDate];
   
    solarTerms = [self.strDateFormatter stringFromDate:date];
    
    
    return solarTerms;
}

@end
