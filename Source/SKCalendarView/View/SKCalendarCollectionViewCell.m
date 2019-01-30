//
//  SKCalendarCollectionViewCell.m
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKCalendarCollectionViewCell.h"
#import "SKConstant.h"

@interface SKCalendarCollectionViewCell ()
@property (nonatomic, strong) UIView * baseView;// 底部view
@property (nonatomic, strong) UIImageView * backgroundIcon;// 背景图片
@property (nonatomic, strong) UIImageView * icon;// 日期图片
@property (nonatomic, strong) UILabel * dateLabel;// 日期
@property (nonatomic, strong) UILabel * titleLabel;// 日期标题
@property (nonatomic, strong) UIImageView * rightLine;// 右边线
@property (nonatomic, strong) UIImageView * bottomLine;// 下边线

@end

@implementation SKCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            [self customView];
            self.enableLine = YES;
            self.enableDateRoundCorner = YES;
        }
    }
    
    return self;
}

#pragma mark - 创建界面
- (void)customView
{
    // 底部view
    self.baseView = [UIView new];
    [self addSubview:self.baseView];
    self.baseView.backgroundColor = self.backgroundColor;
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景图片
    self.backgroundIcon = [UIImageView new];
    [self.baseView addSubview:self.backgroundIcon];
    self.backgroundIcon.alpha = 0.5;
    [self.backgroundIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.baseView).with.insets(UIEdgeInsetsMake(1, 1, 1, 1));
    }];
    
    // 日期图片
    self.icon = [UIImageView new];
    [self.baseView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.baseView);
        make.top.equalTo(self.baseView).with.offset(3);
        
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    // 日期
    self.dateLabel = [UILabel new];
    [self.baseView addSubview:self.dateLabel];
    self.dateLabel.font = [UIFont systemFontOfSize:15];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.icon);
        make.left.equalTo(self.icon);
        make.right.equalTo(self.icon);
    }];
    
    // 日期标题
    self.titleLabel = [UILabel new];
    [self.baseView addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.icon.mas_bottom).with.offset(2);
        make.bottom.equalTo(self.baseView).with.offset(-2);
        make.left.equalTo(self.baseView);
        make.right.equalTo(self.baseView);
    }];
    
    
    // 边线
    self.rightLine = [UIImageView new];
    [self addSubview:self.rightLine];
    self.rightLine.backgroundColor = [UIColor lightGrayColor];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        
        make.width.mas_offset(0.5);
    }];
    
    self.bottomLine = [UIImageView new];
    [self addSubview:self.bottomLine];
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        
        make.height.mas_offset(0.5);
    }];
}

#pragma mark - 外部设置
- (void)setCalendarDate:(NSString *)calendarDate
{
    _calendarDate = calendarDate;
    self.dateLabel.text = getNoneNil(calendarDate);
}

- (void)setCalendarDateColor:(UIColor *)calendarDateColor
{
    _calendarDateColor = calendarDateColor;
    self.dateLabel.textColor = calendarDateColor;
}

- (void)setDateColor:(UIColor *)dateColor
{
    _dateColor = dateColor;
    self.icon.backgroundColor = dateColor;
}

- (void)setDateIcon:(UIImage *)dateIcon
{
    _dateIcon = dateIcon;
    if (!isEmpty(dateIcon)) {
        self.icon.image = dateIcon;
    }
}

- (void)setDateBackgroundColor:(UIColor *)dateBackgroundColor
{
    _dateBackgroundColor = dateBackgroundColor;
    self.backgroundColor = dateBackgroundColor;
    self.backgroundIcon.backgroundColor = self.backgroundColor;
}

-(void)setDateBackgroundIcon:(UIImage *)dateBackgroundIcon
{
    _dateBackgroundIcon = dateBackgroundIcon;
    self.backgroundIcon.image = dateBackgroundIcon;
}

- (void)setCalendarTitle:(NSString *)calendarTitle
{
    self.titleLabel.text = calendarTitle;
    _calendarTitle = calendarTitle;
}

- (void)setCalendarTitleColor:(UIColor *)calendarTitleColor
{
    _calendarTitleColor = calendarTitleColor;
    self.titleLabel.textColor = calendarTitleColor;
}

- (void)setEnableClickEffect:(BOOL)enableClickEffect
{
    _enableClickEffect = enableClickEffect;
    if (enableClickEffect == YES) {// 开启点击效果
        [SKCalendarAnimationManage clickEffectAnimationForView:self.baseView];
    }
}

- (void)setEnableDateRoundCorner:(BOOL)enableDateRoundCorner
{
    _enableDateRoundCorner = enableDateRoundCorner;
    if (enableDateRoundCorner == YES) {// 开启圆角
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 25, 25) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = CGRectMake(0, 0, 25, 25);
        maskLayer.path = maskPath.CGPath;
        self.icon.layer.mask = maskLayer;
    }
}

- (void)setEnableLine:(BOOL)enableLine
{
    _enableLine = enableLine;
    if (enableLine == YES) {
        self.rightLine.hidden = NO;
        self.bottomLine.hidden = NO;
    } else {
        self.rightLine.hidden = YES;
        self.bottomLine.hidden = YES;
    }
}

@end
