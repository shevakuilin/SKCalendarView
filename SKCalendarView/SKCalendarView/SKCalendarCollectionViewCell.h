//
//  SKCalendarCollectionViewCell.h
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKCalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString * calendarDate;// 日期
@property (nonatomic, strong) UIColor * calendarDateColor;// 日期字体颜色
@property (nonatomic, strong) UIColor * dateColor;// 日期颜色
@property (nonatomic, strong) UIImage * dateIcon;// 日期图片
@property (nonatomic, strong) UIColor * dateBackgroundColor;// 日期背景颜色
@property (nonatomic, strong) UIImage * dateBackgroundIcon;// 日期背景图片
@property (nonatomic, strong) NSString * calendarTitle;// 日期标题
@property (nonatomic, strong) UIColor * calendarTitleColor;// 日期标题字体颜色
@property (nonatomic, assign) BOOL enableClickEffect;// 开启点击效果
@property (nonatomic, assign) BOOL enableDateRoundCorner;// 开启日期圆角, 默认YES
@property (nonatomic, assign) BOOL enableLine;// 开启边线, 默认YES

@end
