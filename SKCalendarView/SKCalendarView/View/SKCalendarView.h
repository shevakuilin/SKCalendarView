//
//  SKCalendarView.h
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKCalendarView;

@protocol SKCalendarViewDelegate <NSObject>

- (void)selectDateWithRow:(NSUInteger)row;

@end

@interface SKCalendarView : UIView
@property (nonatomic, strong) UIColor * weekBackgroundColor;// 周的背景颜色
@property (nonatomic, strong) UIColor * normalInWeekColor;// 周(除双休日外)字体颜色
@property (nonatomic, strong) UIColor * dayoffInWeekColor;// 双休日字体颜色
@property (nonatomic, strong) UIColor * calendarTodayColor;// 本日日期字体颜色
@property (nonatomic, strong) UIColor * dateColor;// 日期小背景颜色
@property (nonatomic, strong) UIImage * dateIcon;// 日期图片
@property (nonatomic, strong) UIColor * holidayBackgroundColor;// 节日背景颜色
@property (nonatomic, strong) UIColor * solarTeromBackgroundColor;// 节气背景颜色
@property (nonatomic, strong) UIColor * dateBackgroundColor;// 日期背景颜色(非节日&节气)
@property (nonatomic, strong) UIImage * dateBackgroundIcon;// 日期背景图片
@property (nonatomic, strong) NSString * calendarTodayTitle;// 本日日期标题
@property (nonatomic, strong) UIColor * calendarTodayTitleColor;// 本日日期标题字体颜色
@property (nonatomic, strong) UIColor * calendarTitleColor;// 日期标题字体颜色
@property (nonatomic, strong) UIColor * holidayColor;// 节日标题字体颜色
@property (nonatomic, strong) UIColor * springColor;// 春季节气颜色
@property (nonatomic, strong) UIColor * summerColor;// 夏季节气颜色
@property (nonatomic, strong) UIColor * autumnColor;// 秋季节气颜色
@property (nonatomic, strong) UIColor * winterColor;// 冬季节气颜色
@property (nonatomic, assign) BOOL enableClickEffect;// 开启点击效果
@property (nonatomic, assign) BOOL enableDateRoundCorner;// 开启日期圆角
@property (nonatomic, weak) id <SKCalendarViewDelegate> delegate;


@property (nonatomic, assign) NSUInteger lastMonth;// 上个月
@property (nonatomic, assign) NSUInteger nextMonth;// 下个月
@property (nonatomic, assign) BOOL checkLastMonth;// 查看上个月
@property (nonatomic, assign) BOOL checkNextMonth;// 查看下个月
@property (assign, nonatomic) NSUInteger year;// 当前年
@property (assign, nonatomic) NSUInteger month;// 当前月
@property (strong, nonatomic) NSString * chineseYear;// 农历年
@property (strong, nonatomic) NSString * chineseMonth;// 农历月
@property (strong, nonatomic) NSMutableArray * chineseCalendarDay;// 农历纯日期(不包含节日和节气)
@property (strong, nonatomic) NSMutableArray * chineseCalendarDate;// 农历日期&节日&节气
@property (assign, nonatomic) NSInteger todayInMonth;// 今天在本月是第几天

/** 根据农历日期获取节日&节气
 * @param chineseDay 农历纯日期(不包括节日&节气)
 */
- (NSString *)getHolidayAndSolarTermsWithChineseDay:(NSString *)chineseDay;

/** 查看指定日期
 * @param date 指定查看的日期
 */
- (void)checkCalendarWithAppointDate:(NSDate *)date;

@end
