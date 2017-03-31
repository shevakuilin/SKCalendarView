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

@interface ViewController ()
@property (nonatomic, strong) SKCalendarView * calendarView;
@property (nonatomic, strong) UIButton * nextButton;
@property (nonatomic, strong) UIButton * lastButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.calendarView];
    
    self.nextButton = [UIButton new];
    [self.calendarView addSubview:self.nextButton];
    [self.nextButton setTitle:[NSString stringWithFormat:@"%@月", @(self.calendarView.nextMonth)] forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.calendarView.mas_bottom);
        make.right.equalTo(self.calendarView.mas_right).with.offset(-10);
    }];
    [self.nextButton addTarget:self action:@selector(checkNextMonthCalendar) forControlEvents:UIControlEventTouchUpInside];
    
    self.lastButton = [UIButton new];
    [self.calendarView addSubview:self.lastButton];
    [self.lastButton setTitle:[NSString stringWithFormat:@"%@月", @(self.calendarView.lastMonth)] forState:UIControlStateNormal];
    [self.lastButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.calendarView.mas_bottom);
        make.left.equalTo(self.calendarView.mas_left).with.offset(10);
    }];
    [self.lastButton addTarget:self action:@selector(checkLastMonthCalendar) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (SKCalendarView *)calendarView
{
    if (!_calendarView) {
        _calendarView = [[SKCalendarView alloc] initWithFrame:CGRectMake(self.view.center.x - 150, self.view.center.y - 150, 300, 300)];
        _calendarView.layer.cornerRadius = 5;
        _calendarView.layer.borderColor = [UIColor blackColor].CGColor;
        _calendarView.layer.borderWidth = 0.5;
        _calendarView.calendarTodayTitleColor = [UIColor redColor];
        _calendarView.calendarTodayTitle = @"今日";
        _calendarView.dateColor = [UIColor orangeColor];
        _calendarView.calendarTodayColor = [UIColor whiteColor];
    }
    
    return _calendarView;
}

- (void)checkNextMonthCalendar
{
    self.calendarView.checkNextMonth = YES;
}

- (void)checkLastMonthCalendar
{
    self.calendarView.checkLastMonth = YES;
}

@end
