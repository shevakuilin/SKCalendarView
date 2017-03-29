//
//  SKWeekCollectionViewCell.m
//  SKCalendarView
//
//  Created by shevchenko on 17/3/30.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKWeekCollectionViewCell.h"
#import "SKConstant.h"

@interface SKWeekCollectionViewCell ()
@property (nonatomic, strong) UILabel * weekLabel;

@end;

@implementation SKWeekCollectionViewCell

 - (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            [self customView];
        }
    }
    
    return self;
}

#pragma mark - 创建界面
- (void)customView
{
    self.weekLabel = [UILabel new];
    [self addSubview:self.weekLabel];
    self.weekLabel.font = [UIFont systemFontOfSize:17];
    self.weekLabel.textAlignment = NSTextAlignmentCenter;
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

#pragma mark - 外部配置
- (void)setWeek:(NSString *)week
{
    _week = week;
    self.weekLabel.text = week;
}

- (void)setWeekColor:(UIColor *)weekColor
{
    _weekColor = weekColor;
    self.weekLabel.textColor = weekColor;
}

@end
