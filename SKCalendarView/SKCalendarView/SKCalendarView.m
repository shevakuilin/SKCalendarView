//
//  SKCalendarView.m
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKCalendarView.h"
#import "SKConstant.h"

@interface SKCalendarView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * calendarCollection;

@end

@implementation SKCalendarView

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
    
}

@end
