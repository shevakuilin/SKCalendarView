//
//  SKWeekCollectionViewCell.h
//  SKCalendarView
//
//  Created by shevchenko on 17/3/30.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKWeekCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString * week;
@property (nonatomic, strong) UIColor * weekColor;
@property (nonatomic, strong) UIColor * weekBackgroundColor;
@property (nonatomic, assign) BOOL enableLine;// 开启边线, 默认YES


@end
