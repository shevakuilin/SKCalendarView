//
//  SKDateSecurity.m
//  SKCalendarView
//
//  Created by shevchenko on 17/3/29.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKDateSecurity.h"

@implementation SKDateSecurity

+ (BOOL)isNilOrEmpty:(id)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && ([string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])) {
        return YES;
    }
    return NO;
}

+ (NSString *)getNoneNilString:(id)obj
{
    NSString * string = @"";
    if (![obj isKindOfClass:[NSNull class]]) {
        string = [NSString stringWithFormat:@"%@", obj];
    }
    if (obj == nil) {
        string = @"";
    }
    if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:@"null"]) {
        string = @"";
    }
    return string;

}

@end
