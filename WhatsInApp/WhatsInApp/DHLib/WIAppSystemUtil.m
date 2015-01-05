//
//  WIAppSystemUtil.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppSystemUtil.h"

@implementation WIAppSystemUtil

+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)appName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return version;
}

+ (BOOL)isIOS6
{
    return ([self systemVersion].intValue >= 6);
}

+ (BOOL)isIOS7
{
    return ([self systemVersion].intValue >= 7);
}

+ (BOOL)isIOS8
{
    return ([self systemVersion].intValue >= 8);
}

+ (void)logAllFont
{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}

+ (float)scale
{
    return [UIScreen mainScreen] .scale;
}

+ (BOOL)isRetina3_5
{
    return fabs((double)[[UIScreen mainScreen] bounds].size.height-(double)480) < DBL_EPSILON;
}

+ (BOOL)isRetina4
{
    return fabs((double)[[UIScreen mainScreen] bounds].size.height-(double)568 ) < DBL_EPSILON;
}

+ (CGFloat)screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (int)leftLocalNotificationSize
{
    UIApplication * sharedApplication = [UIApplication sharedApplication];
    NSArray * scheduledLocalNotification = [sharedApplication scheduledLocalNotifications];
    return ([self maxLocalNotificationSize] - scheduledLocalNotification.count);
}

+ (int)maxLocalNotificationSize
{
    return 64;
}



@end

















