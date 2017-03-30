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
@property (nonatomic, strong) UIColor * calendarDateColor;// 日期字体颜色
@property (nonatomic, strong) UIColor * calendarTodayColor;// 本日日期字体颜色
@property (nonatomic, strong) UIColor * dateColor;// 日期颜色
@property (nonatomic, strong) UIImage * dateIcon;// 日期图片
@property (nonatomic, strong) UIColor * dateBackgroundColor;// 日期背景颜色
@property (nonatomic, strong) UIImage * dateBackgroundIcon;// 日期背景图片
@property (nonatomic, strong) NSString * calendarTodayTitle;// 本日日期标题
@property (nonatomic, strong) UIColor * calendarTodayTitleColor;// 本日日期标题字体颜色
@property (nonatomic, strong) UIColor * calendarTitleColor;// 日期标题字体颜色
@property (nonatomic, assign) BOOL enableClickEffect;// 开启点击效果
@property (nonatomic, assign) BOOL enableDateRoundCorner;// 开启日期圆角
@property (nonatomic, weak) id <SKCalendarViewDelegate> delegate;


@end
