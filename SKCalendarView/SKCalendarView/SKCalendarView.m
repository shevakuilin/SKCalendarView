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
    }
    return _calendarManage;
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
        
        make.height.mas_offset(50);
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
//        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.weekCollectionView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
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
                make.height.mas_offset(218 + (self.frame.size.height / 7.5));
            }];
            return 42;
            
        } else {
            if (self.calendarCollectionView.frame.size.height > 218) {
                [self.calendarCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(218);
                }];
            }
            return 35;
        }
    }
    
    return self.calendarManage.weekList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.calendarCollectionView) {
        SKCalendarCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Calendar" forIndexPath:indexPath];
        cell.calendarDate = getNoneNil(self.calendarManage.calendarDate[indexPath.row]);
        if (self.calendarManage.todayInMonth == indexPath.row) {
            cell.calendarDateColor = [UIColor whiteColor];
            cell.dateColor = [UIColor orangeColor];
            cell.calendarTitle = @"今天";
            //        cell.enableDateRoundCorner = YES;
        } else {
            //        cell.enableDateRoundCorner = NO;
        }
        
        return cell;
        
    } else {
        SKWeekCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Week" forIndexPath:indexPath];
        cell.week = getNoneNil(self.calendarManage.weekList[indexPath.row]);
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
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width / 7.5, self.frame.size.height / 7.5);
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
