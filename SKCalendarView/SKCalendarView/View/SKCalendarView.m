//
//  SKCalendarView.m
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKCalendarView.h"
#import "SKConstant.h"
#import "SKCalendarCollectionViewCell.h"
#import "SKWeekCollectionViewCell.h"
#import "SKCalendarManage.h"

@interface SKCalendarView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * weekCollectionView;
@property (nonatomic, strong) UICollectionView * calendarCollectionView;
@property (nonatomic, strong) SKCalendarManage * calendarManage;
@property (nonatomic, strong) UILabel * monthBackgroundLabel;
@property (nonatomic, strong) NSDate * theDate;// 当前日期
@property (nonatomic, assign) NSUInteger theYear;// 本年
@property (nonatomic, assign) NSUInteger theDayInMonth;// 今天在本月所处位置
@property (nonatomic, assign) NSInteger selectedRow;// 选择的日期
@property (nonatomic, strong) NSString * displayChineseDate;//已显示的农历日期&节日&节气

@end

@implementation SKCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.frame = frame;
            [self customView];
        }
    }
    
    return self;
}

- (SKCalendarManage *)calendarManage
{
    if (!_calendarManage) {
        _calendarManage = [SKCalendarManage manage];
        // 设置初始化日期，默认查看今天所处月份日历
        [_calendarManage checkThisMonthRecordFromToday:[NSDate date]];
        self.theDate = [NSDate date];
        self.theYear = _calendarManage.year;
        [self reloadExternalDate];
    }
    return _calendarManage;
}

- (NSUInteger)lastMonth
{
    if (_lastMonth == 0) {
        _lastMonth = self.calendarManage.month - 1;
    }
    return _lastMonth;
}

- (NSUInteger)nextMonth
{
    if (_nextMonth == 0) {
        _nextMonth = self.calendarManage.month + 1;
    }
    return _nextMonth;
}

- (NSInteger)selectedRow
{
    if (_selectedRow == 0) {
        _selectedRow = - 1;
    }
    return _selectedRow;
}

- (NSInteger)todayInMonth
{
    if (_todayInMonth == 0) {
        _todayInMonth = self.calendarManage.todayInMonth;
    }
    return _todayInMonth;
}


#pragma mark - 创建界面
- (void)customView
{
    // 周
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.weekCollectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
    [self addSubview:self.weekCollectionView];
    self.weekCollectionView.backgroundColor = [UIColor whiteColor];
    self.weekCollectionView.delegate = self;
    self.weekCollectionView.dataSource = self;
    [self.weekCollectionView registerClass:[SKWeekCollectionViewCell class] forCellWithReuseIdentifier:@"Week"];
    [self.weekCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        
        make.height.mas_offset(self.frame.size.height / 7.5);
        make.height.mas_greaterThanOrEqualTo(40).priorityHigh();
    }];

    // 日期
    UICollectionViewFlowLayout * dateLayout = [[UICollectionViewFlowLayout alloc] init];
    dateLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.calendarCollectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:dateLayout];
    [self addSubview:self.calendarCollectionView];
    self.calendarCollectionView.backgroundColor = [UIColor whiteColor];
    self.calendarCollectionView.delegate = self;
    self.calendarCollectionView.dataSource = self;
    [self.calendarCollectionView registerClass:[SKCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"Calendar"];
    [self.calendarCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekCollectionView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    // 背景月份
    self.monthBackgroundLabel = [UILabel new];
    [self addSubview:self.monthBackgroundLabel];
    self.monthBackgroundLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:200 / 2550.f];
    self.monthBackgroundLabel.font = [UIFont systemFontOfSize:150.0f weight:120.f];
    self.monthBackgroundLabel.textAlignment = NSTextAlignmentCenter;
    [self.monthBackgroundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - 外部配置
- (void)setWeekBackgroundColor:(UIColor *)weekBackgroundColor
{
    _weekBackgroundColor = weekBackgroundColor;
    self.weekCollectionView.backgroundColor = weekBackgroundColor;
}

- (void)setNormalInWeekColor:(UIColor *)normalInWeekColor
{
    _normalInWeekColor = normalInWeekColor;
}

- (void)setDayoffInWeekColor:(UIColor *)dayoffInWeekColor
{
    _dayoffInWeekColor = dayoffInWeekColor;
}


- (void)setCalendarTodayColor:(UIColor *)calendarTodayColor
{
    _calendarTodayColor = calendarTodayColor;
}

- (void)setDateColor:(UIColor *)dateColor
{
    _dateColor = dateColor;
}

- (void)setDateIcon:(UIImage *)dateIcon
{
    _dateIcon = dateIcon;
}

- (void)setHolidayBackgroundColor:(UIColor *)holidayBackgroundColor
{
    _holidayBackgroundColor = holidayBackgroundColor;
}

- (void)setSolarTeromBackgroundColor:(UIColor *)solarTeromBackgroundColor
{
    _solarTeromBackgroundColor = solarTeromBackgroundColor;
}

- (void)setDateBackgroundColor:(UIColor *)dateBackgroundColor
{
    _dateBackgroundColor = dateBackgroundColor;
}

- (void)setSpringColor:(UIColor *)springColor
{
    _springColor = springColor;
}

- (void)setSummerColor:(UIColor *)summerColor
{
    _summerColor = summerColor;
}

- (void)setAutumnColor:(UIColor *)autumnColor
{
    _autumnColor = autumnColor;
}

- (void)setWinterColor:(UIColor *)winterColor
{
    _winterColor = winterColor;
}

- (void)setDateBackgroundIcon:(UIImage *)dateBackgroundIcon
{
    _dateBackgroundIcon = dateBackgroundIcon;
}

- (void)setCalendarTodayTitle:(NSString *)calendarTodayTitle
{
    _calendarTodayTitle = calendarTodayTitle;
}

- (void)setCalendarTodayTitleColor:(UIColor *)calendarTodayTitleColor
{
    _calendarTodayTitleColor = calendarTodayTitleColor;
}

- (void)setHolidayColor:(UIColor *)holidayColor
{
    _holidayColor = holidayColor;
}

- (void)setCalendarTitleColor:(UIColor *)calendarTitleColor
{
    _calendarTitleColor = calendarTitleColor;
}

- (void)setEnableClickEffect:(BOOL)enableClickEffect
{
    _enableClickEffect = enableClickEffect;
}

- (void)setEnableDateRoundCorner:(BOOL)enableDateRoundCorner
{
    _enableDateRoundCorner = enableDateRoundCorner;
}

- (void)setCheckLastMonth:(BOOL)checkLastMonth
{
    _checkLastMonth = checkLastMonth;
    if (checkLastMonth == YES) {
        self.selectedRow = -1;// 重置已选日期
        NSInteger hours = (self.calendarManage.days - 1) * -24;
        NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:self.theDate];
        [self.calendarManage checkThisMonthRecordFromToday:date];
        self.theDate = date;
        self.monthBackgroundLabel.text = [NSString stringWithFormat:@"%@", @(self.calendarManage.month)];
        [self.calendarCollectionView reloadData];
        [self reloadExternalDate];
    }
}

- (void)setCheckNextMonth:(BOOL)checkNextMonth
{
    _checkNextMonth = checkNextMonth;
    if (checkNextMonth == YES) {
        self.selectedRow = -1;// 重置已选日期
        NSUInteger todayInMonth = self.calendarManage.todayInMonth;
        if (todayInMonth > 1) {
            todayInMonth = self.calendarManage.todayInMonth - self.calendarManage.dayInWeek + 2;
        }
        NSUInteger day = self.calendarManage.days - todayInMonth;
        NSInteger hours = (day + 1) * 24;
        NSDate * date = [NSDate dateWithTimeInterval:hours * 60 * 60 sinceDate:self.theDate];
        [self.calendarManage checkThisMonthRecordFromToday:date];
        self.theDate = date;
        self.monthBackgroundLabel.text = [NSString stringWithFormat:@"%@", @(self.calendarManage.month)];
        [self.calendarCollectionView reloadData];
        [self reloadExternalDate];
    }
}

#pragma mark - 查看指定日期
- (void)checkCalendarWithAppointDate:(NSDate *)date
{
    [self.calendarManage checkThisMonthRecordFromToday:date];
    [self.calendarCollectionView reloadData];
    self.theDate = date;
    [self reloadExternalDate];
}

#pragma mark - 更新外部数据
- (void)reloadExternalDate
{
    self.year = _calendarManage.year;
    self.month = _calendarManage.month;
    self.chineseYear = _calendarManage.chineseYear;
    self.chineseMonth = _calendarManage.chineseMonth;
    self.theDayInMonth = _calendarManage.todayInMonth;
    self.chineseCalendarDay = _calendarManage.chineseCalendarDay;
    self.chineseCalendarDate = _calendarManage.chineseCalendarDate;
    self.monthBackgroundLabel.text = [NSString stringWithFormat:@"%@", @(_calendarManage.month)];
    self.lastMonth = _calendarManage.month - 1;
    self.nextMonth = _calendarManage.month + 1;
}

#pragma mark - 获取节日&节气
- (NSString *)getHolidayAndSolarTermsWithChineseDay:(NSString *)chineseDay
{
    NSString * result = @"";
    NSUInteger row = 0;
    if (self.selectedRow < 0) {
        row = self.todayInMonth;// 默认今天
    } else {
        row = self.selectedRow;
    }
    NSString * date = getNoneNil(self.calendarManage.chineseCalendarDate[row]);
    if (![chineseDay isEqualToString:date]) {
        result = date;
    }
    return getNoneNil(result);
}


#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.calendarCollectionView) {
        if (self.calendarManage.isIncreaseHeight == YES) {
            [self.calendarCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(6 * (self.frame.size.height / 7.5));
            }];
            return 42;
            
        } else {
            if (self.calendarCollectionView.frame.size.height > 218) {
                [self.calendarCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(5 * (self.frame.size.height / 7.5));
                }];
            }
            return 35;
        }
    }
    
    return self.calendarManage.weekList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 日期
    if (collectionView == self.calendarCollectionView) {
        SKCalendarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Calendar" forIndexPath:indexPath];
        // 是否属于双休日
        if ((indexPath.row + 1) % 7 == 0 || (indexPath.row + 1) % 7 == 1) {
            cell.calendarDateColor = self.dayoffInWeekColor;
        } else {
            cell.calendarDateColor = self.normalInWeekColor;
        }
        // 如果是选中的日期
        if (self.selectedRow == indexPath.row && !isEmpty(self.calendarManage.calendarDate[indexPath.row])) {
            cell.enableClickEffect = YES;
            cell.dateColor = [UIColor colorWithRed:204 / 255.0 green:228 / 255.0 blue:236 / 255.0 alpha:1.0];
            cell.calendarDateColor = [UIColor whiteColor];
        } else {
            cell.enableClickEffect = NO;
            cell.dateColor = nil;
        }
        // 是否属于今天
        if (self.theDayInMonth == indexPath.row && self.calendarManage.month == self.calendarManage.theMonth && self.theYear == self.calendarManage.year) {
            cell.calendarDate = getNoneNil(self.calendarManage.calendarDate[indexPath.row]);// 公历日期
            cell.calendarTitle = getNoneNil(self.calendarManage.chineseCalendarDate[indexPath.row]);// 农历日期
            cell.calendarDateColor = self.calendarTodayColor;
            cell.calendarTitle = getNoneNil(self.calendarTodayTitle);
            cell.calendarTitleColor = self.calendarTodayTitleColor;
            cell.dateColor = self.dateColor;
            
        } else {
            cell.calendarDate = getNoneNil(self.calendarManage.calendarDate[indexPath.row]);// 公历日期
            cell.calendarTitle = getNoneNil(self.calendarManage.chineseCalendarDate[indexPath.row]);// 农历日期
            cell.calendarTitleColor = nil;
        }
        // 对节日&节气进行特殊处理
        if (![self.calendarManage.chineseCalendarDay[indexPath.row] isEqualToString:self.calendarManage.chineseCalendarDate[indexPath.row]]) {
            NSString * specialDay = self.calendarManage.chineseCalendarDate[indexPath.row];
            // 节气
            if (specialDay.length == 2 && ![specialDay isEqualToString:@"除夕"] && ![specialDay isEqualToString:@"春节"] && ![specialDay isEqualToString:@"七夕"] && ![specialDay isEqualToString:@"元旦"] && ![specialDay isEqualToString:@"小年"]) {
                cell.dateBackgroundIcon = self.dateBackgroundIcon;
                if (self.calendarManage.month >= 2 && self.calendarManage.month <= 4) {// 春季
                    cell.calendarTitleColor = self.springColor;
                    
                } else if (self.calendarManage.month >= 5 && self.calendarManage.month <= 7) {// 夏季
                    cell.calendarTitleColor = self.summerColor;
                    
                } else if (self.calendarManage.month >= 8 && self.calendarManage.month <= 10) {// 秋季
                    cell.calendarTitleColor = self.autumnColor;

                } else if (self.calendarManage.month >= 11 || self.calendarManage.month == 1){// 冬季
                    cell.calendarTitleColor = self.winterColor;
                }
            } else {// 节日
                if (specialDay.length == 3 || [specialDay isEqualToString:@"除夕"] || [specialDay isEqualToString:@"春节"] || [specialDay isEqualToString:@"七夕"] || [specialDay isEqualToString:@"元旦"] || [specialDay isEqualToString:@"小年"]) {
                    cell.calendarTitleColor = self.holidayColor;
                    cell.dateBackgroundIcon = self.dateBackgroundIcon;
                }
            }
        } else {
            cell.calendarTitleColor = self.calendarTitleColor;
            cell.dateBackgroundIcon = nil;
        }
        
        return cell;
        
    } else {// 周
        SKWeekCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Week" forIndexPath:indexPath];
        cell.week = getNoneNil(self.calendarManage.weekList[indexPath.row]);
        cell.weekBackgroundColor = self.weekCollectionView.backgroundColor;
        if (indexPath.row == 0 || indexPath.row == self.calendarManage.weekList.count - 1) {
            cell.weekColor = [UIColor redColor];
        } else {
            cell.weekColor = [UIColor blackColor];
        }
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(selectDateWithRow:)]) {
        [self.delegate selectDateWithRow:indexPath.row];
    }
    [self.calendarCollectionView reloadData];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width / 7, self.frame.size.height / 7);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end
