//
//  ViewController.m
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "ViewController.h"
#import "SKConstant.h"
#import "SKCalendarView.h"
#import "SKCalendarAnimationManage.h"

@interface ViewController ()
@property (nonatomic, strong) SKCalendarView * calendarView;
@property (nonatomic, strong) UIButton * nextButton;
@property (nonatomic, strong) UIButton * lastButton;
@property (nonatomic, assign) NSUInteger lastMonth;
@property (nonatomic, assign) NSUInteger nextMonth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.calendarView];
    
    // 查看下个月
    self.nextButton = [UIButton new];
    [self.view addSubview:self.nextButton];
    [self.nextButton setTitle:[NSString stringWithFormat:@"%@月", @(self.nextMonth)] forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom);
        make.right.equalTo(self.calendarView.mas_right).with.offset(-10);
    }];
    [self.nextButton addTarget:self action:@selector(checkNextMonthCalendar) forControlEvents:UIControlEventTouchUpInside];
    
    // 查看上个月
    self.lastButton = [UIButton new];
    [self.view addSubview:self.lastButton];
    [self.lastButton setTitle:[NSString stringWithFormat:@"%@月", @(self.lastMonth)] forState:UIControlStateNormal];
    [self.lastButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calendarView.mas_bottom);
        make.left.equalTo(self.calendarView.mas_left).with.offset(10);
    }];
    [self.lastButton addTarget:self action:@selector(checkLastMonthCalendar) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 日历设置
- (SKCalendarView *)calendarView
{
    if (!_calendarView) {
        _calendarView = [[SKCalendarView alloc] initWithFrame:CGRectMake(self.view.center.x - 150, self.view.center.y - 150, 300, 300)];
        _calendarView.layer.cornerRadius = 5;
        _calendarView.layer.borderColor = [UIColor blackColor].CGColor;
        _calendarView.layer.borderWidth = 0.5;
        _calendarView.calendarTodayTitleColor = [UIColor redColor];// 今天标题字体颜色
        _calendarView.calendarTodayTitle = @"今日";// 今天下标题
        _calendarView.dateColor = [UIColor orangeColor];// 今天日期数字背景颜色
        _calendarView.calendarTodayColor = [UIColor whiteColor];// 今天日期字体颜色
        self.lastMonth = _calendarView.lastMonth;// 获取上个月的月份
        self.nextMonth = _calendarView.nextMonth;// 获取下个月的月份
    }
    
    return _calendarView;
}

#pragma mark - 查看上/下一月份日历
- (void)checkNextMonthCalendar
{
    self.calendarView.checkNextMonth = YES;// 查看下月
    [self changeButton:self.nextButton isNext:YES];
    [SKCalendarAnimationManage animationWithView:self.calendarView andEffect:SK_ANIMATION_REVEAL isNext:YES];
}

- (void)checkLastMonthCalendar
{
    self.calendarView.checkLastMonth = YES;// 查看上月
    [self changeButton:self.lastButton isNext:NO];
    [SKCalendarAnimationManage animationWithView:self.calendarView andEffect:SK_ANIMATION_REVEAL isNext:NO];
}

// 改变上/下月按钮的月份
- (void)changeButton:(UIButton *)button isNext:(BOOL)next
{
    if (next == YES) {
        self.lastMonth = self.lastMonth + 1;
        self.nextMonth = self.nextMonth + 1;
        if (self.lastMonth > 12) {
            self.lastMonth = 1;
        }
        if (self.nextMonth > 12) {
            self.nextMonth = 1;
        }
    } else {
        self.lastMonth = self.lastMonth - 1;
        self.nextMonth = self.nextMonth - 1;
        if (self.lastMonth < 1) {
            self.lastMonth = 12;
        }
        if (self.nextMonth < 1) {
            self.nextMonth = 12;
        }
    }
    [self.lastButton setTitle:[NSString stringWithFormat:@"%@月", @(self.lastMonth)] forState:UIControlStateNormal];
    [self.nextButton setTitle:[NSString stringWithFormat:@"%@月", @(self.nextMonth)] forState:UIControlStateNormal];
}

@end
