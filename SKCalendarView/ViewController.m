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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.calendarView];
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
//        _calendarView.weekBackgroundColor = [UIColor colorWithRed:123 / 255.0 green:133 / 255.0 blue:255 / 255.0 alpha:1.0];
        _calendarView.calendarTodayTitleColor = [UIColor redColor];
        _calendarView.calendarTodayTitle = @"今日";
        _calendarView.dateColor = [UIColor orangeColor];
        _calendarView.calendarTodayColor = [UIColor whiteColor];
    }
    
    return _calendarView;
}

@end
