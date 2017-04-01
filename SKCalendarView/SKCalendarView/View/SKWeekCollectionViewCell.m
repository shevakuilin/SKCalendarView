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
@property (nonatomic, strong) UIImageView * bottomLine;

@end;

@implementation SKWeekCollectionViewCell

 - (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            [self customView];
            self.enableLine = YES;
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
    
    self.bottomLine = [UIImageView new];
    [self addSubview:self.bottomLine];
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).with.offset(-3);
        
        make.height.mas_offset(0.5);
    }];
}

#pragma mark - 外部配置
- (void)setWeek:(NSString *)week
{
    _week = week;
    if (!isEmpty(week)) {
        self.weekLabel.text = week;
    }
}

- (void)setWeekColor:(UIColor *)weekColor
{
    _weekColor = weekColor;
    if (!isEmpty(weekColor)) {
        self.weekLabel.textColor = weekColor;
    }
}

- (void)setWeekBackgroundColor:(UIColor *)weekBackgroundColor
{
    _weekBackgroundColor = weekBackgroundColor;
    if (!isEmpty(weekBackgroundColor)) {
        self.backgroundColor = weekBackgroundColor;
    }
}

- (void)setEnableLine:(BOOL)enableLine
{
    _enableLine = enableLine;
    if (enableLine == YES) {
        self.bottomLine.hidden = NO;
    } else {
        self.bottomLine.hidden = YES;
    }
}

@end
