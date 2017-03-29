//
//  SKArchCutter.m
//  SKArchCutter
//
//  Created by shevchenko on 17/3/28.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKArchCutter.h"

@interface SKArchCutter ()
@property (nonatomic, assign) UIRectCorner direction;
@property (nonatomic, assign) UIRectCorner secondCorner;
@property (nonatomic, assign) CGFloat cornerRadii;
@property (nonatomic, strong) id object;

@end

@implementation SKArchCutter

- (instancetype)init
{
    if ([super init]) {
        if (self) {
            
        }
    }
    
    return self;
}

- (void)cuttingWithObject:(id)object direction:(UIRectCorner)direction cornerRadii:(CGFloat)cornerRadii;
{
    self.object = object;
    self.direction = direction;
    self.cornerRadii = cornerRadii;
    [self classOfObject:object];
}

- (void)classOfObject:(id)object
{
    if ([object isKindOfClass:[UIView class]]) {
        UIView * view = object;
        [self cuttingView:view];
        
    } else if ([object isKindOfClass:[UIImageView class]]) {
        UIImageView * imageView = object;
        [self cuttingImageView:imageView];
        
    } else if ([object isKindOfClass:[UIButton class]]) {
        UIButton * button = object;
        [self cuttingButton:button];
        
    } else if ([object isKindOfClass:[UILabel class]]) {
        UILabel * label = object;
        [self cuttingLabel:label];
        
    } else {
        return ;
    }

}

#pragma mark - 切割UIView
- (void)cuttingView:(UIView *)view;
{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:self.direction cornerRadii:CGSizeMake(self.cornerRadii, self.cornerRadii)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark - 切割UIImageView
- (void)cuttingImageView:(UIImageView *)imageView
{
    // 先截取UIImageView视图Layer生成的Image，然后再做渲染
    UIImage * image = nil;
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    if (currnetContext) {
        CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:self.direction cornerRadii:CGSizeMake(self.cornerRadii, self.cornerRadii)].CGPath);
        CGContextClip(currnetContext);
        [imageView.layer renderInContext:currnetContext];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self cuttingImageView:self.object];
        });
    }
}

#pragma mark - 切割UIButton
- (void)cuttingButton:(UIButton *)button
{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:self.direction cornerRadii:CGSizeMake(self.cornerRadii, self.cornerRadii)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = button.bounds;
    maskLayer.path = maskPath.CGPath;
    button.layer.mask = maskLayer;
}

#pragma mark - 切割UILabel
- (void)cuttingLabel:(UILabel *)label
{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:label.bounds byRoundingCorners:self.direction cornerRadii:CGSizeMake(self.cornerRadii, self.cornerRadii)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = label.bounds;
    maskLayer.path = maskPath.CGPath;
    label.layer.mask = maskLayer;
}

@end
